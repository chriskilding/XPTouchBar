import SwiftUI

struct ConnectionView: View {
    
    @Binding var host: String
    @Binding var port: Int
    
    private var portStr: String {
        let f = NumberFormatter()
        f.alwaysShowsDecimalSeparator = false
        let n = NSNumber(integerLiteral: port)
        return f.string(from: n) ?? ""
    }
    
    var body: some View {
        Form {
            TextField("Host", text: $host)
            Stepper("Port: \(portStr)", value: $port, in: 0...65535)
        }
    }
}
