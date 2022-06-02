import Foundation

struct DREF {
    let dataref: Dataref
    let value: Float
}

extension DREF: CustomDataConvertible {
    var dataValue: Data {
        let dg = XPDatagramBuilder()
        
        dg.append("DREF")
        dg.append(self.value)
        dg.append(self.dataref.description)
        dg.fillTo(count: 509)
        
        return dg.data
    }
}
