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
            Label("X-Plane UDP Connection", systemImage: "bolt.horizontal.fill")
            TextField("Host", text: $host)
            NumberTextField("Port", value: $port, range: 0...65535)
        }
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
