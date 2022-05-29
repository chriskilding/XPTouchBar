import SwiftUI

@main
struct XPTouchBarApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @ObservedObject var props = XPlaneConnector()
            
    var body: some Scene {
        WindowGroup {
            ContentView(throttle: $props.throttle, pitch: $props.pitch, mixture: $props.mixture, flaps: $props.flaps, gear: $props.gear, parkingBrake: $props.parkingBrake, host: $props.host, port: $props.port, isConnected: $props.isConnected)
                .onAppear {
                    props.start()
                }
                .myTouchBar(throttle: $props.throttle, pitch: $props.pitch, mixture: $props.mixture, flaps: $props.flaps, gear: $props.gear, parkingBrake: $props.parkingBrake)
            
        }
        
    }
    
}
