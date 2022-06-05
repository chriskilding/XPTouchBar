import Foundation

struct RREF {
    let frequency: Int
    let id: Int
    let dataref: Dataref
}

extension RREF: CustomDataConvertible {
    var dataValue: Data {
        let dg = XPDatagramBuilder()

        dg.append("RREF")
        dg.append(Float(self.frequency))
        dg.append(Float(self.id))
        dg.append(self.dataref.description)
        dg.fillTo(count: 413)
        
        return dg.data
    }
}
