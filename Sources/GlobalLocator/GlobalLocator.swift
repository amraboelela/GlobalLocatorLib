//
//  GlobalLocator.swift
//  GlobalLocator
//
//  Created by Amr Aboelela on 6/10/21.
//  Copyright © 2021 Amr Aboelela. All rights reserved.
//
//  See LICENCE for details.
//

import CoreLocation
import MapKit

public let globalLocator = GlobalLocator()

public class GlobalLocator {
    
    let codes = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "B", "C", "D", "F",
    "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Z"]
    let forbiddenLetters: Set<String> = ["A", "E", "I", "O", "U", "Y"]
    let codeIndexes = ["0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "B": 10, "C": 11, "D": 12, "F": 13,
                       "G": 14, "H": 15, "J": 16, "K": 17, "L": 18, "M": 19, "N": 20, "P": 21, "Q": 22, "R": 23, "S": 24, "T": 25, "V": 26, "W": 27, "X": 28, "Z": 29]
    
    func numberFor(code: String, max: Double) -> Double {
        var result = 0.0
        guard code.count > 0 else {
            return -1.0
        }
        var unit = max * 2 / Double(codes.count)
        let firstChar = code[0]
        var decimalIndex = Double(codeIndexes[firstChar] ?? 0)
        //var ratio = decimalIndex / Double(codes.count)
        var diff = decimalIndex * unit //ratio * max * 2
        let number = diff - max
        result = result + number
        for i in 1..<code.count {
            let char = code[i]
            decimalIndex = Double(codeIndexes[char] ?? 0)
            unit = unit / Double(codes.count)
            diff = decimalIndex * unit
            result = result + diff
        }
        return result
    }
    
    func codeFor(number: Double, max: Double) -> String {
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
    
    public func locationFor(code: String) -> CLLocationCoordinate2D {
        let theCodes = code.split(separator: " ")
        guard theCodes.count == 2 else {
            return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        let longitude = numberFor(code: String(theCodes[0]), max: 180)
        let latitude = numberFor(code: String(theCodes[1]), max: 90)
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public func spanFor(code: String) -> MKCoordinateSpan {
        var longitudeUnit = 360.0 / Double(codes.count)
        var latitudeUnit = 180.0 / Double(codes.count)
        let theCodes = code.split(separator: " ")
        guard theCodes.count == 2 else {
            return MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        }
        for _ in 1..<theCodes[0].count {
            longitudeUnit = longitudeUnit / Double(codes.count)
        }
        for _ in 1..<theCodes[1].count {
            latitudeUnit = latitudeUnit / Double(codes.count)
        }
        return MKCoordinateSpan(latitudeDelta: latitudeUnit, longitudeDelta: longitudeUnit)
    }
    
    func codeFor(longitude: Double, latitude: Double) -> String {
        return codeFor(number: longitude, max: 180) + " " + codeFor(number: latitude, max: 90)
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
            result = result + averageCode[result.count]
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
        let longitudeCode1 = codeFor(number: longitude1, max: 180)
        let longitudeCode2 = codeFor(number: longitude2, max: 180)
        let latitudeCode1 = codeFor(number: latitude1, max: 90)
        let latitudeCode2 = codeFor(number: latitude2, max: 90)
        let longitudeAverageCode = codeFor(number: longitudeAverage, max: 180)
        let latitudeAverageCode = codeFor(number: latitudeAverage, max: 90)
        var longitudeCode = mergeCodes(code1: longitudeCode1, code2: longitudeCode2, averageCode: longitudeAverageCode)
        var latitudeCode = mergeCodes(code1: latitudeCode1, code2: latitudeCode2, averageCode: latitudeAverageCode)
        if longitudeCode.count < latitudeCode.count {
            longitudeCode = longitudeCode + "0"
        }
        if latitudeCode.count < longitudeCode.count {
            latitudeCode = latitudeCode + "0"
        }
        return longitudeCode + " " + latitudeCode
    }
}
