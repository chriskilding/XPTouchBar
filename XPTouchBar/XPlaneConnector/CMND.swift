import Foundation

/// X-Plane commandref
struct CMND {
    let command: Command
}

extension CMND: CustomDataConvertible {
    var dataValue: Data {
        let dg = XPDatagramBuilder()

        dg.append("CMND")
        dg.append(self.command.description)
        
        return dg.data
    }
}
