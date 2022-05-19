import SwiftUI

struct ConnectionView: View {
    
    @Binding var host: String
    @Binding var port: Int
    @Binding var isConnected: Bool
    
    var connectedSign: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
            Text("Connected")
        }
    }
    
    var disconnectedSign: some View {
        HStack {
            Image(systemName: "exclamationmark.octagon.fill")
            Text("Disconnected")
        }
    }
    
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
            if isConnected {
                connectedSign
            } else {
                disconnectedSign
            }
        }
    }
}
