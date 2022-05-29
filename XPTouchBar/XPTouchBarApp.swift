import SwiftUI

@main
struct XPTouchBarApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @ObservedObject var props = XPlaneConnector()
            
    var body: some Scene {
        WindowGroup {
            ContentView(speedbrake: $props.speedbrake, throttle: $props.throttle, pitch: $props.pitch, mixture: $props.mixture, flaps: $props.flaps, gear: $props.gear, parkingBrake: $props.parkingBrake, simSpeed: $props.simSpeed, host: $props.host, port: $props.port, isConnected: $props.isConnected)
                .onAppear {
                    props.start()
                }
                .myTouchBar(speedbrake: $props.speedbrake, throttle: $props.throttle, pitch: $props.pitch, mixture: $props.mixture, flaps: $props.flaps, gear: $props.gear, parkingBrake: $props.parkingBrake, simSpeed: $props.simSpeed)
            
        }
        
    }
    
}
