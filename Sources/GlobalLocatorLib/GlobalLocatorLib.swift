//
//  GlobalLocatorLib.swift
//  GlobalLocatorLib
//
//  Created by Amr Aboelela on 6/10/21.
//  Copyright © 2021 Amr Aboelela. All rights reserved.
//
//  See LICENCE for details.
//

import CoreLocation
import MapKit

public let globalLocatorLib = GlobalLocatorLib()


enum MeasureType {
    case longitude
    case latitude
}

public class GlobalLocatorLib {
    
    let codes = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "B", "C", "D", "F",
    "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Z"]
    let forbiddenLetters: Set<String> = ["A", "E", "I", "O", "U", "Y"]
    let codeIndexes = ["0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "B": 10, "C": 11, "D": 12, "F": 13,
                       "G": 14, "H": 15, "J": 16, "K": 17, "L": 18, "M": 19, "N": 20, "P": 21, "Q": 22, "R": 23, "S": 24, "T": 25, "V": 26, "W": 27, "X": 28, "Z": 29]
    var spans = [Int:Double]()
    
    func numberFor(code: String, type: MeasureType) -> Double {
        guard code.count > 0 else {
            return -1.0
        }
        let max = type == .longitude ? 180.0 : 90.0
        var unit = max * 2 / Double(codes.count)
        var char = code[0]
        var decimalIndex = Double(codeIndexes[char] ?? 0)
        var diff = decimalIndex * unit
        var result = diff - max
        for i in 1..<code.count {
            char = code[i]
            decimalIndex = Double(codeIndexes[char] ?? 0)
            unit = unit / Double(codes.count)
            diff = decimalIndex * unit
            result = result + diff
        }
        result = result + unit / 2.0
        return result
    }
    
    func codeFor(number: Double, type: MeasureType) -> String {
        let max = type == .longitude ? 180.0 : 90.0
        var diff = number + max
        var ratio = diff / (max * 2)
        var decimalIndex = ratio * Double(codes.count)
        var index = Int(decimalIndex)
        if index >= codes.count {
            index = codes.count - 1
        }
        var code = codes[index]
        var result = code
        diff = decimalIndex - Double(index)
        while diff > 0.0 && result.count < 5 {
            ratio = diff / 1.0
            decimalIndex = ratio * Double(codes.count)
            index = Int(decimalIndex)
            if index >= codes.count {
                index = codes.count - 1
            }
            code = codes[index]
            result = result + code
            diff = decimalIndex - Double(index)
        }
        return result
    }
    
    public func codeFor(location: CLLocationCoordinate2D) -> String {
        return codeFor(longitude: location.longitude, latitude: location.latitude)
    }
    
    public func codeFor(region: MKCoordinateRegion) -> String {
        var latitudeDiff = (region.span.latitudeDelta / 2.0)
        var longitudeDiff = (region.span.longitudeDelta / 2.0)
        latitudeDiff = min(latitudeDiff, longitudeDiff)
        longitudeDiff = latitudeDiff
        return codeFor(
            location1: CLLocationCoordinate2D(
                latitude: region.center.latitude - latitudeDiff,
                longitude: region.center.longitude - longitudeDiff
            ),
            location2: CLLocationCoordinate2D(
                latitude: region.center.latitude + latitudeDiff,
                longitude: region.center.longitude + longitudeDiff
            )
        )
    }
    
    public func locationFor(code: String) -> CLLocationCoordinate2D {
        let theCodes = code.uppercased().split(separator: " ")
        guard theCodes.count == 2 else {
            return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        let longitude = numberFor(code: String(theCodes[0]), type: .longitude)
        let latitude = numberFor(code: String(theCodes[1]), type: .latitude)
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public func spanFor(code: String) -> MKCoordinateSpan {
        let theCodes = code.uppercased().split(separator: " ")
        guard theCodes.count == 2 else {
            return MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        }
        var span1 = spanFor(codeCount: theCodes[0].count)
        var span2 = spanFor(codeCount: theCodes[1].count)
        span1 = min(span1, span2)
        span2 = span1
        return MKCoordinateSpan(
            latitudeDelta: span1,
            longitudeDelta: span2
        )
    }
    
    func spanFor(codeCount: Int) -> Double {
        if let span = spans[codeCount] {
            return span
        }
        let max = 360.0
        var unit = max / Double(codes.count)
        for _ in 1..<codeCount {
            unit = unit / Double(codes.count)
        }
        let span = unit * Double(codeCount)
        spans[codeCount] = span
        return span
    }
    
    func codeSize(number1: Double, number2: Double) -> Int {
        let diff = abs(number2 - number1)
        for i in (2...5).reversed() {
            let span = spanFor(codeCount: i)
            if diff < span * 1.1 {
                return i
            }
        }
        return 1
    }
    
    func codeFor(longitude: Double, latitude: Double) -> String {
        return codeFor(number: longitude, type: .longitude) + " " + codeFor(number: latitude, type: .latitude)
    }
    
    func nextLetter(_ letter: String) -> String {

        // Check if string is build from exactly one Unicode scalar:
        guard let uniCode = UnicodeScalar(letter) else {
            return ""
        }
        switch uniCode {
        case "0" ..< "Z":
            if let unicodeScalar = UnicodeScalar(uniCode.value + 1) {
                let nextChar = String(unicodeScalar)
                if forbiddenLetters.contains(nextChar) {
                    return nextLetter(nextChar)
                } else {
                    return nextChar
                }
            }
        default:
            break
        }
        return ""
    }
    
    func mergeCodes(code1: String, code2: String, averageCode: String) -> String {
        var result = ""
        var char1 = ""
        var char2 = ""
        for i in 0..<code1.count {
            if i < code2.count {
                char1 = code1[i]
                char2 = code2[i]
                if char1 == char2 {
                    result = result + char1
                } else {
                    break
                }
            }
        }
        if result.count < averageCode.count {
            var theCode = averageCode[result.count]
            if result.count + 1 < averageCode.count {
                let nextChar = averageCode[result.count + 1]
                if let index = codeIndexes[nextChar], index > codes.count / 2 {
                    let char = averageCode[result.count]
                    if let charIndex = codeIndexes[char], charIndex < codes.count - 1 {
                        theCode = codes[charIndex + 1]
                    }
                }
            }
            result = result + theCode
        }
        return result
    }
    
    public func codeFor(location1: CLLocationCoordinate2D, location2: CLLocationCoordinate2D) -> String {
        return codeFor(longitude1: location1.longitude, latitude1: location1.latitude, longitude2: location2.longitude, latitude2: location2.latitude)
    }
    
    func codeFor(longitude1: Double, latitude1: Double,
                longitude2: Double, latitude2: Double) -> String {
        let longitudeAverage = (longitude1 + longitude2) / 2.0
        let latitudeAverage = (latitude1 + latitude2) / 2.0
        let longitudeAverageCode = codeFor(number: longitudeAverage, type: .longitude)
        let latitudeAverageCode = codeFor(number: latitudeAverage, type: .latitude)
        let longitudeSize = codeSize(number1: longitude1, number2: longitude2)
        let latitudeSize = codeSize(number1: latitude1, number2: latitude2)
        let theCodeSize = max(longitudeSize, latitudeSize)
        let longitudeCode = longitudeAverageCode.substring(toIndex: theCodeSize)
        let latitudeCode = latitudeAverageCode.substring(toIndex: theCodeSize)
        return longitudeCode + " " + latitudeCode
    }
    
    public func isGLCode(text: String) -> Bool {
        let codes = text.uppercased().split(separator: " ")
        if codes.count != 2 {
            return false
        }
        if codes[0].count != codes[1].count {
            return false
        }
        if codes[0].count > 5 {
            return false
        }
        for char in codes[0] {
            if forbiddenLetters.contains(String(char)) {
                return false
            }
        }
        for char in codes[1] {
            if forbiddenLetters.contains(String(char)) {
                return false
            }
        }
        return true
    }
    
    func isAddress(text: String) -> Bool {
        let tokens = text.split(separator: " ")
        if tokens.count > 0 {
            return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: String(tokens[0])))
        }
        return false
    }
    
    public func regionFor(query: String, fromRegion region: MKCoordinateRegion, callback: @escaping (MKMapItem?, MKCoordinateRegion) -> Void) {
        var resultRegion = region
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                callback(nil, resultRegion)
                return
            }
            let matchingItems = response.mapItems
            if matchingItems.count > 0 {
                let matchingItem = matchingItems[0]
                if let location = matchingItem.placemark.location?.coordinate {
                    var spanValue = 0.1
                    if self.isAddress(text: query) {
                        spanValue = 0.01
                    }
                    resultRegion = MKCoordinateRegion(
                        center: location,
                        span: MKCoordinateSpan(latitudeDelta: spanValue, longitudeDelta: spanValue)
                    )
                    callback(matchingItem, resultRegion)
                }
            }
        }
    }
}