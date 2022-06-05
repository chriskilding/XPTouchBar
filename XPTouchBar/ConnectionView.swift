import SwiftUI

struct ConnectionView: View {
    
    @EnvironmentObject var props: XPlaneConnector
    
    private var portStr: String {
        let f = NumberFormatter()
        f.alwaysShowsDecimalSeparator = false
        let n = NSNumber(integerLiteral: props.port)
        return f.string(from: n) ?? ""
    }
    
    var body: some View {
        Form {
            Section("X-Plane UDP Connection") {
                HStack {
                    TextField("Host", text: $props.host)
                    Button("Reset", action: resetHost)
                }
                HStack {
                    NumberTextField("Port", value: $props.port, range: 0...65535)
                    Button("Reset", action: resetPort)
                }
            }
        }
    }
        
    func resetHost() {
        props.host = "127.0.0.1"
    }
    
    func resetPort() {
        props.port = 49000
    }
}

fileprivate struct NumberTextField: View {
    
    let title: String
    let value: Binding<Int>
    let range: ClosedRange<Int>
    
    init(_ title: String, value: Binding<Int>, range: ClosedRange<Int>) {
        self.title = title
        self.value = value
        self.range = range
    }
    
    var body: some View {
        TextField(title, text: Binding(
            get: { String(value.wrappedValue) },
            set: {
                if let v = Int($0) {
                    if range ~= v {
                        value.wrappedValue = v
                    }
                }
            }
        ))
    }
}
