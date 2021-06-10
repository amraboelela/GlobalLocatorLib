
public let globalLocator = GlobalLocator()

public class GlobalLocator {
    
    let codes = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "B", "C", "D", "F",
    "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Z"]
    
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
    
    func codeFor(latitude: Double, longitude: Double) -> String {
        return codeFor(number: longitude, max: 180) + " " + codeFor(number: latitude, max: 90)
    }
}
