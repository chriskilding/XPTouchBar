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
                self.props.comSelection = .com1
            })
    }
    
    private var com2Mic: Binding<Bool> {
        Binding<Bool>(
            get: {
                return self.props.comSelection == .com2
            },
            set: { _ in
                self.props.comSelection = .com2
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
                Toggle("Parking Brake", isOn: $props.parkingBrake)
                    .keyboardShortcut("B", modifiers: [])
                
                Button("Landing Gear") {
                    props.gear.toggle()
                }.keyboardShortcut("G", modifiers: [])
                
                Button("Show/Hide Map") {
                    props.toggleMap()
                }.keyboardShortcut("M", modifiers: [])
                
                Button("Play/Pause") {
                    props.simSpeed.toggle()
                }
                .keyboardShortcut("P", modifiers: [])
                
                Button("Show/Hide Yoke") {
                    props.hideYoke.toggle()
                }
                .keyboardShortcut("Y", modifiers: [])
                
                autopilot
                
                lights
                
                radios
            }
            
            CommandMenu("Camera") {
                
                Button("Linear Spot") {
                    self.props.camera = .linearSpot
                }
                .keyboardShortcut("1", modifiers: [.shift])
                
                Button("Still Spot") {
                    self.props.camera = .stillSpot
                }
                .keyboardShortcut("2", modifiers: [.shift])
                
                Button("Runway") {
                    self.props.camera = .runway
                }
                .keyboardShortcut("3", modifiers: [.shift])
                
                Button("Circle") {
                    self.props.camera = .circle
                }
                .keyboardShortcut("4", modifiers: [.shift])
                
                Button("Tower") {
                    self.props.camera = .tower
                }
                .keyboardShortcut("5", modifiers: [.shift])
                
                Button("Chase") {
                    self.props.camera = .chase
                }
                .keyboardShortcut("8", modifiers: [.shift])
                
                Button("Cockpit") {
                    self.props.camera = .cockpit
                }
                .keyboardShortcut("9", modifiers: [.shift])
                
                Button("Forward with HUD") {
                    self.props.camera = .hud
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
            Toggle("COM1 Audio", isOn: $props.com1audio)
            Toggle("COM1 Mic", isOn: com1Mic)
        }
    }
    
    var com2radios: some View {
        Group {
            Toggle("COM2 Power", isOn: $props.com2power)
            Toggle("COM2 Audio", isOn: $props.com2audio)
            Toggle("COM2 Mic", isOn: com2Mic)
        }
    }
    
    var nav1radios: some View {
        Group {
            Toggle("NAV1 Power", isOn: $props.nav1power)
            Toggle("NAV1 Audio", isOn: $props.nav1audio)
        }
    }
    
    var nav2radios: some View {
        Group {
            Toggle("NAV2 Power", isOn: $props.nav2power)
            Toggle("NAV2 Audio", isOn: $props.nav2audio)
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
    
    var autopilot: some View {
        Menu("Autopilot") {
            Button("Altitude Mode (ALT)") {
                self.props.autopilotAltitudeHold()
            }
            Button("Approach Mode (APR)") {
                self.props.autopilotApproach()
            }
            Button("Heading Mode (HDG)") {
                self.props.autopilotHeadingHold()
            }
            Button("Navigation Mode (NAV)") {
                self.props.autopilotNav()
            }
            Button("Reverse Mode (REV)") {
                self.props.autopilotBackCourse()
            }
            Divider()
            Button("Vertical Speed Mode (VS)") {
                self.props.autopilotVerticalSpeed()
            }
            Button("Vertical Speed Down (-VS)") {
                self.props.autopilotVerticalSpeedDown()
            }
            Button("Vertical Speed Up (+VS)") {
                self.props.autopilotVerticalSpeedUp()
            }
        }
    }
    
    var radios: some View {
        Menu("Radios") {
            comRadios
            Divider()
            navRadios
            Divider()
            Toggle("DME Audio", isOn: $props.dmeAudio)
        }
    }
    
    var lights: some View {
        Menu("Lights") {
            Toggle("Beacon", isOn: $props.beaconLights)
            Toggle("Landing", isOn: $props.landingLights)
            Toggle("Nav", isOn: $props.navigationLights)
            Toggle("Strobe", isOn: $props.strobeLights)
            Toggle("Taxi", isOn: $props.taxiLight)
        }
    }
}
