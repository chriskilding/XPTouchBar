import SwiftUI

struct ContentView: View {
    @Binding var throttle: Double
    @Binding var pitch: Double
    @Binding var mixture: Double
    @Binding var flaps: Double
    
    @Binding var host: String
    @Binding var port: Int
    @Binding var isConnected: Bool
    
    var body: some View {
        TabView {
            OverView()
                .tabItem {
                    Text("Overview")
                }
                .padding()
            
            ConnectionView(host: $host, port: $port, isConnected: $isConnected)
                .tabItem {
                    Text("Connection")
                }
                .padding()
            
            DebugView(throttle: $throttle, pitch: $pitch, mixture: $mixture, flaps: $flaps)
                .tabItem {
                    Text("Debug")
                }
                .padding()
        }
        .padding()
    }
}
