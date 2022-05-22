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

extension CLLocationCoordinate2D: Equatable {
    static public func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

public struct GLRegion: Identifiable {
    public let id: String
    public let location: CLLocationCoordinate2D
    public let span: CGSize
    
    public init(id: String, location: CLLocationCoordinate2D, span: CGSize) {
        self.id = id
        self.location = location
        self.span = span
    }
}

enum MeasureType {
    case longitude
    case latitude
}

public class GlobalLocatorLib {
    
    let codes = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F",
    "G", "H", "J", "K", "M", "N", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let forbiddenLetters: Set<String> = ["I", "L", "O", "P"]
    let codeIndexes = ["0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15, "G": 16, "H": 17, "J": 18, "K": 19, "M": 20, "N": 21, "Q": 22, "R": 23, "S": 24, "T": 25, "U": 26, "V": 27, "W": 28, "X": 29, "Y": 30, "Z": 31]
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
    
    func combine(code1: String, code2: String) -> String {
        var result = ""
        for i in 0..<code1.count {
            result = result + code1[i] + code2[i]
        }
        return result
    }
    
    func uncombine(code: String) -> String {
        var code1 = ""
        var code2 = ""
        for i in 0..<code.count/2 {
            code1 = code1 + code[i*2]
            code2 = code2 + code[i*2+1]
        }
        return code1 + " " + code2
    }
    
    public func locationFor(code: String) -> CLLocationCoordinate2D {
        let theCodes = uncombine(code: code).uppercased().split(separator: " ")
        guard theCodes.count == 2 else {
            return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        let longitude = numberFor(code: String(theCodes[0]), type: .longitude)
        let latitude = numberFor(code: String(theCodes[1]), type: .latitude)
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public func spanFor(code: String) -> MKCoordinateSpan {
        if code.count % 2 != 0 {
            return MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        }
        let span = spanFor(codeCount: code.count / 2)
        return MKCoordinateSpan(
            latitudeDelta: span,
            longitudeDelta: span
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
        let span = unit * Double(codeCount + 1)
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
        let result = combine(
            code1: codeFor(number: longitude, type: .longitude),
            code2: codeFor(number: latitude, type: .latitude)
        )
        return result
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
        return combine(code1: longitudeCode, code2: latitudeCode)
    }
    
    public func isGLCode(text: String) -> Bool {
        let code = text.uppercased()
        if code.count % 2 != 0 {
            return false
        }
        if code.count > 10 {
            return false
        }
        for char in code {
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
        #if os(watchOS)
        return callback(nil, region)
        #else
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                callback(nil, region)
                return
            }
            let matchingItems = response.mapItems
            if matchingItems.count > 0 {
                let matchingItem = matchingItems[0]
                if let location = matchingItem.placemark.location?.coordinate {
                    var spanValue = 0.1
                    if self.isAddress(text: query) {
                        spanValue = 0.003
                    }
                    let resultRegion = MKCoordinateRegion(
                        center: location,
                        span: MKCoordinateSpan(latitudeDelta: spanValue, longitudeDelta: spanValue)
                    )
                    callback(matchingItem, resultRegion)
                }
            }
        }
        #endif
    }
    
    @available(macOS 10.12, *)
    @available(iOS 10.0, *)
    @available(watchOS 3.0, *)
    public func mapItemFrom(code: String) -> MKMapItem {
        let location = self.locationFor(code: code)
        let result = MKMapItem(placemark: MKPlacemark(coordinate: location))
        result.name = code.uppercased()
        return result
    }
    
    public func annotationFor(region: MKCoordinateRegion, mapSize: CGSize) -> GLRegion {
        print("annotationFor region: \(region), mapSize: \(mapSize)")
        let code = codeFor(region: region)
        let location = locationFor(code: code)
        let span = spanFor(code: code)
        let resultSpan = MKCoordinateSpan(
            latitudeDelta: span.latitudeDelta / Double(1 + code.count / 2) / 2.0,
            longitudeDelta: span.longitudeDelta / Double(1 + code.count / 2)
        )
        let resultSpanSize = CGSize(
            width: CGFloat((resultSpan.longitudeDelta / region.span.longitudeDelta) * Double(mapSize.width)),
            height: CGFloat((resultSpan.latitudeDelta / region.span.latitudeDelta) * Double(mapSize.height))
        )
        return GLRegion(
            id: code,
            location: location,
            span: resultSpanSize
        )
    }
}
