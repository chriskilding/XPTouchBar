import SwiftUI

@main
struct XPTouchBarApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @ObservedObject var props = XPlaneConnector()
    
    private var com1Mic: Binding<Bool> {
        Binding<Bool>(
            get: {
                return self.props.comSelection == .com1
            },
            set: { _ in
                self.props.com1Mic()
            })
    }
    
    private var com2Mic: Binding<Bool> {
        Binding<Bool>(
            get: {
                return self.props.comSelection == .com2
            },
            set: { _ in
                self.props.com2Mic()
            })
    }
    
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
        .onChange(of: props.camera) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.com1audio) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.com2audio) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.nav1audio) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.nav2audio) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.dmeAudio) { newState in
            appDelegate.updateTouchBar()
        }
        .onChange(of: props.comSelection) { newState in
            appDelegate.updateTouchBar()
        }
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
        .commands {
            // Turn off the "New Window" option
            CommandGroup(replacing: .newItem, addition: { })
            
            SidebarCommands()
            
            CommandMenu("Controls") {
                Button("Parking Brake") {
                    props.toggleParkingBrake()
                }.keyboardShortcut("B", modifiers: [])
                
                Button("Landing Gear") {
                    props.toggleLandingGear()
                }.keyboardShortcut("G", modifiers: [])
                
                Button("Show/Hide Map") {
                    props.toggleMap()
                }.keyboardShortcut("M", modifiers: [])
                
                Button("Play/Pause") {
                    props.simSpeed.toggle()
                }
                .keyboardShortcut("P", modifiers: [])
                
                Button("Show/Hide Yoke") {
                    props.toggleYoke()
                }
                .keyboardShortcut("Y", modifiers: [])
                
                lights
                
                radios
            }
            
            CommandMenu("Camera") {
                
                Button("Linear Spot") {
                    self.props.cameraLinearSpot()
                }
                .keyboardShortcut("1", modifiers: [.shift])
                
                Button("Still Spot") {
                    self.props.cameraStillSpot()
                }
                .keyboardShortcut("2", modifiers: [.shift])
                
                Button("Runway") {
                    self.props.cameraRunway()
                }
                .keyboardShortcut("3", modifiers: [.shift])
                
                Button("Circle") {
                    self.props.cameraCircle()
                }
                .keyboardShortcut("4", modifiers: [.shift])
                
                Button("Tower") {
                    self.props.cameraTower()
                }
                .keyboardShortcut("5", modifiers: [.shift])
                
                Button("Chase") {
                    self.props.cameraChase()
                }
                .keyboardShortcut("8", modifiers: [.shift])
                
                Button("Cockpit") {
                    self.props.cameraCockpit()
                }
                .keyboardShortcut("9", modifiers: [.shift])
                
                Button("Forward with HUD") {
                    self.props.cameraHud()
                }
                .keyboardShortcut("W", modifiers: [.shift])
            }
        }
        
        Settings {
            ConnectionView()
                .environmentObject(props)
                .padding()
        }
    }
    
    var com1radios: some View {
        Group {
            Toggle("COM1 Power", isOn: $props.com1power)
            Button("COM1 Audio") {
                props.toggleCom1Audio()
            }
            Toggle("COM1 Mic", isOn: com1Mic)
        }
    }
    
    var com2radios: some View {
        Group {
            Toggle("COM2 Power", isOn: $props.com2power)
            Button("COM2 Audio") {
                props.toggleCom2Audio()
            }
            Toggle("COM2 Mic", isOn: com2Mic)
        }
    }
    
    var nav1radios: some View {
        Group {
            Toggle("NAV1 Power", isOn: $props.nav1power)
            Button("NAV1 Audio") {
                props.toggleNav1Audio()
            }
        }
    }
    
    var nav2radios: some View {
        Group {
            Toggle("NAV2 Power", isOn: $props.nav2power)
            Button("NAV2 Audio") {
                props.toggleNav2Audio()
            }
        }
    }
    
    var comRadios: some View {
        Group {
            com1radios
            Divider()
            com2radios
        }
    }
    
    var navRadios: some View {
        Group {
            nav1radios
            Divider()
            nav2radios
        }
    }
    
    var radios: some View {
        Menu("Radios") {
            comRadios
            Divider()
            navRadios
            Divider()
            Button("DME Audio") {
                props.toggleDmeAudio()
            }
        }
    }
    
    var lights: some View {
        Menu("Lights") {
            Button("Beacon") {
                props.toggleBeaconLights()
            }
            Button("Landing") {
                props.toggleLandingLights()
            }
            Button("Nav") {
                props.toggleNavLights()
            }
            Button("Strobe") {
                props.toggleStrobeLights()
            }
            Button("Taxi") {
                props.toggleTaxiLights()
            }
        }
    }
}
