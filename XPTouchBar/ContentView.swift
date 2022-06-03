import SwiftUI

struct ContentView: View {
    @Binding var speedbrake: Float
    @Binding var throttle: Float
    @Binding var pitch: Float
    @Binding var mixture: Float
    @Binding var flaps: Float
    @Binding var gear: Gear
    @Binding var parkingBrake: Bool
    @Binding var simSpeed: SimSpeed
    @Binding var beaconLights: Bool
    @Binding var landingLights: Bool
    @Binding var navigationLights: Bool
    @Binding var strobeLights: Bool
    @Binding var taxiLight: Bool
    
    @Binding var host: String
    @Binding var port: Int
    
    @State var selectedView: MyTab = .touchBar
    
    @ViewBuilder var childView: some View {
        switch selectedView {
        case .touchBar:
            TouchBarView()
                .padding()
        case .manuals:
            ManualsView()
        case .debug:
            DebugView(speedbrake: $speedbrake, throttle: $throttle, pitch: $pitch, mixture: $mixture, flaps: $flaps, gear: $gear, parkingBrake: $parkingBrake, simSpeed: $simSpeed, beaconLights: $beaconLights, landingLights: $landingLights, navigationLights: $navigationLights, strobeLights: $strobeLights, taxiLight: $taxiLight)
        }
    }
    
    var body: some View {
        childView
            .toolbar {
                Spacer()
                
                Picker("", selection: $selectedView) {
                    Text("Touch Bar").tag(MyTab.touchBar)
                    Text("Manuals").tag(MyTab.manuals)
                    Text("Debug").tag(MyTab.debug)
                }
                .pickerStyle(.segmented)
                
                
                Spacer()
            }
    }
}

enum MyTab {
    case touchBar
    case manuals
    case debug
}
