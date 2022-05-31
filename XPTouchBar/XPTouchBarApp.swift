import SwiftUI

@main
struct XPTouchBarApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @ObservedObject var props = XPlaneConnector()
            
    var body: some Scene {
        WindowGroup {
            ContentView(speedbrake: $props.speedbrake, throttle: $props.throttle, pitch: $props.pitch, mixture: $props.mixture, flaps: $props.flaps, gear: $props.gear, parkingBrake: $props.parkingBrake, simSpeed: $props.simSpeed, beaconLights: $props.beaconLights, landingLights: $props.landingLights, navigationLights: $props.navigationLights, strobeLights: $props.strobeLights, taxiLight: $props.taxiLight, cockpitLights: $props.cockpitLights, instrumentBrightness: $props.instrumentBrightness, host: $props.host, port: $props.port)
                .onAppear {
                    props.start()
                }
                .myTouchBar(speedbrake: $props.speedbrake, throttle: $props.throttle, pitch: $props.pitch, mixture: $props.mixture, flaps: $props.flaps, gear: $props.gear, parkingBrake: $props.parkingBrake, simSpeed: $props.simSpeed, beaconLights: $props.beaconLights, landingLights: $props.landingLights, navigationLights: $props.navigationLights, strobeLights: $props.strobeLights, taxiLight: $props.taxiLight, cockpitLights: $props.cockpitLights, instrumentBrightness: $props.instrumentBrightness)
            
        }
        
    }
    
}
