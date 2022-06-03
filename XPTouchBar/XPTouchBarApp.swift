import SwiftUI

@main
struct XPTouchBarApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @ObservedObject var props = XPlaneConnector()
    
    init() {
        appDelegate.props = props
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(speedbrake: $props.speedbrake, throttle: $props.throttle, pitch: $props.pitch, mixture: $props.mixture, flaps: $props.flaps, gear: $props.gear, parkingBrake: $props.parkingBrake, simSpeed: $props.simSpeed, beaconLights: $props.beaconLights, landingLights: $props.landingLights, navigationLights: $props.navigationLights, strobeLights: $props.strobeLights, taxiLight: $props.taxiLight, host: $props.host, port: $props.port)
        }
        .commands {
            // Turn off the "New Window" option
            CommandGroup(replacing: .newItem, addition: { })
            
            SidebarCommands()
            
            CommandMenu("Controls") {
                Toggle("Parking Brake", isOn: $props.parkingBrake)
                    .keyboardShortcut("B", modifiers: [])
                
                Button("Landing Gear") {
                    props.gear = props.gear.opposite
                }.keyboardShortcut("G", modifiers: [])
                
                Button("Play/Pause") {
                    props.simSpeed = props.simSpeed.opposite
                }.keyboardShortcut("P", modifiers: [])
                
                Toggle("Yoke", isOn: $props.yoke)
                    .keyboardShortcut("Y", modifiers: [])
                
                Menu("Lights") {
                    Toggle("Beacon", isOn: $props.beaconLights)
                    Toggle("Landing", isOn: $props.landingLights)
                    Toggle("Nav", isOn: $props.navigationLights)
                    Toggle("Strobe", isOn: $props.strobeLights)
                    Toggle("Taxi", isOn: $props.taxiLight)
                }
            }
        }
        
        Settings {
            ConnectionView(host: $props.host, port: $props.port)
                .padding()
        }
    }
    
}
