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
            ContentView()
                .environmentObject(props)
        }
        .onChange(of: props.throttle) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.pitch) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.mixture) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.speedbrake) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.flaps) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.beaconLights) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.landingLights) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.navigationLights) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.strobeLights) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.taxiLight) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.gear) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.parkingBrake) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.simSpeed) { newState in
            appDelegate.updateTouchBar()
        }
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
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
            ConnectionView()
                .environmentObject(props)
                .padding()
        }
    }
    
}
