
public let universalLocator = UniversalLocator()

public class UniversalLocator {
    
    let codes = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "B", "C", "D", "F",
    "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Z"]
    
    func codeFor(number: Double) -> String {
        let diff = number - (-180.0)
        let ratio = diff / 360.0
        var index = Int(ratio * Double(codes.count))
        if index >= codes.count {
            index = codes.count - 1
        }
        let code = codes[index]
        return code
    }
    
    func codeFor(latitude: Double, logitude: Double) -> String {
        return codeFor(number: latitude) + " " + codeFor(number: logitude)
    }
}
