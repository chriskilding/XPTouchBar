import Foundation

class XPDatagramBuilder {
    var data = Data()
    
    func append(_ str: String) {
        for c in str {
            data.append(c.asciiValue!)
        }
        data.append(0x00)
    }
    
    func append(_ float: Float) {
        withUnsafeBytes(of: float) {
            data.append(contentsOf: $0)
        }
    }
    
    func fillTo(count: Int, filler: UInt8 = 0x00) {
        for _ in data.count..<count {
            data.append(filler)
        }
    }
}
