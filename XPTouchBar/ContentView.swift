import SwiftUI

struct ContentView: View {
    @Binding var speedbrake: Float
    @Binding var throttle: Float
    @Binding var pitch: Float
    @Binding var mixture: Float
    @Binding var flaps: Float
    @Binding var gear: Gear
    @Binding var parkingBrake: ParkingBrake
    @Binding var simSpeed: SimSpeed
    @Binding var beaconLights: Bool
    @Binding var landingLights: Bool
    @Binding var navigationLights: Bool
    @Binding var strobeLights: Bool
    @Binding var taxiLight: Bool
    @Binding var cockpitLights: Brightness
    @Binding var instrumentBrightness: Brightness
    
    @Binding var host: String
    @Binding var port: Int
    
    var body: some View {
        TabView {
            OverView()
                .tabItem {
                    Text("Overview")
                }
                .padding()
            
            ConnectionView(host: $host, port: $port)
                .tabItem {
                    Text("Connection")
                }
                .padding()
            
            DebugView(speedbrake: $speedbrake, throttle: $throttle, pitch: $pitch, mixture: $mixture, flaps: $flaps, gear: $gear, parkingBrake: $parkingBrake, simSpeed: $simSpeed, beaconLights: $beaconLights, landingLights: $landingLights, navigationLights: $navigationLights, strobeLights: $strobeLights, taxiLight: $taxiLight, cockpitLights: $cockpitLights, instrumentBrightness: $instrumentBrightness)
                .tabItem {
                    Text("Debug")
                }
                .padding()
        }
        .padding()
    }
}
