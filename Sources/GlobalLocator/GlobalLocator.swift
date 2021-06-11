//
//  GlobalLocator.swift
//  GlobalLocator
//
//  Created by Amr Aboelela on 6/10/21.
//  Copyright © 2021 Amr Aboelela. All rights reserved.
//
//  See LICENCE for details.
//

public let globalLocator = GlobalLocator()

public class GlobalLocator {
    
    let codes = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "B", "C", "D", "F",
    "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Z"]
    let forbiddenLetters: Set<String> = ["A", "E", "I", "O", "U", "Y"]
    
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
    
    public func codeFor(longitude: Double, latitude: Double) -> String {
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
    
    func mergeCodes(code1: String, code2: String) -> String {
        var result = ""
        var char1 = ""
        for i in 0..<code1.count {
            if i < code2.count {
                char1 = code1[i]
                let char2 = code2[i]
                if char1 == char2 {
                    result = result + char1
                }
            }
        }
        if result.count < code1.count {
            char1 = code1[result.count]
            result = result + nextLetter(char1)
        }
        return result
    }
    
    public func codeFor(longitude1: Double, latitude1: Double,
                        longitude2: Double, latitude2: Double) -> String {
        let longitudeCode1 = codeFor(number: longitude1, max: 180)
        let longitudeCode2 = codeFor(number: longitude2, max: 180)
        let latitudeCode1 = codeFor(number: latitude1, max: 90)
        let latitudeCode2 = codeFor(number: latitude2, max: 90)
        var code1 = mergeCodes(code1: longitudeCode1, code2: longitudeCode2)
        var code2 = mergeCodes(code1: latitudeCode1, code2: latitudeCode2)
        if code1.count < code2.count {
            code1 = code1 + "0"
        }
        if code2.count < code1.count {
            code2 = code2 + "0"
        }
        return code1 + " " + code2
    }
}
