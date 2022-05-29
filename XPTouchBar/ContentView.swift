import SwiftUI

struct ContentView: View {
    @Binding var speedbrake: Double
    @Binding var throttle: Double
    @Binding var pitch: Double
    @Binding var mixture: Double
    @Binding var flaps: Double
    @Binding var gear: Gear
    @Binding var parkingBrake: ParkingBrake
    @Binding var simSpeed: SimSpeed
    
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
            
            DebugView(speedbrake: $speedbrake, throttle: $throttle, pitch: $pitch, mixture: $mixture, flaps: $flaps, gear: $gear, parkingBrake: $parkingBrake, simSpeed: $simSpeed)
                .tabItem {
                    Text("Debug")
                }
                .padding()
        }
        .padding()
    }
}
