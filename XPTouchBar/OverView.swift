import SwiftUI

struct OverView: View {
    
    @Binding var host: String
    @Binding var port: Int
    @Binding var isConnected: Bool
        
    private var portStr: String {
        let f = NumberFormatter()
        f.alwaysShowsDecimalSeparator = false
        let n = NSNumber(integerLiteral: port)
        return f.string(from: n) ?? ""
    }
    
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
    
    var body: some View {
        VStack {
            Spacer()
            Form {
                Section("X-Plane UDP connection") {
                    TextField("Host", text: $host)
                    Stepper("Port: \(portStr)", value: $port, in: 0...65535)
                    if isConnected {
                        connectedSign
                    } else {
                        disconnectedSign
                    }
                }
            }
            Spacer()
            HStack {
                Image(systemName: "info.circle.fill")
                Text("Go to View > Customize Touch Bar... to choose which X-Plane controls are shown in the Touch Bar.")
            }
        }
    }
}
