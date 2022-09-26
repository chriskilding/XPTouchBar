import AppKit

class MyTouchBar: NSObject, NSTouchBarDelegate {
    
    var props: XPlaneConnector!
    
    func makeTouchBar() -> NSTouchBar {
        let touchBar = NSTouchBar()
        touchBar.customizationIdentifier = .xpTouchBar
        touchBar.defaultItemIdentifiers = [.throttle, .mixture, .flaps]
        touchBar.customizationAllowedItemIdentifiers = [.throttle, .pitch, .mixture, .flaps, .gear, .parkingBrake, .speedbrake, .simSpeed, .lights, .camera, .radios, .flexibleSpace]
        touchBar.delegate = self
        return touchBar
    }
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case .speedbrake:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = "S"
            sliderTouchBarItem.customizationLabel = "Speedbrake"
            sliderTouchBarItem.slider.trackFillColor = .systemMint
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.doubleValue = Double(props.speedbrake)
            sliderTouchBarItem.slider.target = self
            sliderTouchBarItem.slider.action = #selector(Self.speedbrakeChanged(_:))
            return sliderTouchBarItem
        case .throttle:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = "T"
            sliderTouchBarItem.customizationLabel = "Throttle"
            sliderTouchBarItem.slider.trackFillColor = .white
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.doubleValue = Double(props.throttle)
            sliderTouchBarItem.slider.target = self
            sliderTouchBarItem.slider.action = #selector(Self.throttleChanged(_:))
            return sliderTouchBarItem
        case .pitch:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = "P"
            sliderTouchBarItem.customizationLabel = "Propeller Pitch"
            sliderTouchBarItem.slider.trackFillColor = .systemBlue
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.doubleValue = Double(props.pitch)
            sliderTouchBarItem.slider.target = self
            sliderTouchBarItem.slider.action = #selector(Self.pitchChanged(_:))
            return sliderTouchBarItem
        case .mixture:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = "M"
            sliderTouchBarItem.customizationLabel = "Mixture"
            sliderTouchBarItem.slider.trackFillColor = .systemRed
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.doubleValue = Double(props.mixture)
            sliderTouchBarItem.slider.target = self
            sliderTouchBarItem.slider.action = #selector(Self.mixtureChanged(_:))
            return sliderTouchBarItem
        case .flaps:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = "F"
            sliderTouchBarItem.customizationLabel = "Flaps"
            sliderTouchBarItem.slider.trackFillColor = .systemPurple
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.doubleValue = Double(props.flaps)
            sliderTouchBarItem.slider.target = self
            sliderTouchBarItem.slider.action = #selector(Self.flapsChanged(_:))
            return sliderTouchBarItem
        case .gear:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Gear", target: self, action: #selector(Self.gearChanged(_:)))
            toggle.customizationLabel = "Landing Gear"
            return toggle
        case .parkingBrake:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Park", target: self, action: #selector(Self.parkingBrakeChanged(_:)))
            toggle.customizationLabel = "Parking Brake"
            return toggle
        case .simSpeed:
            let simSpeedImages = [
                NSImage(systemSymbolName: "pause.fill", accessibilityDescription: "Pause")!,
                NSImage(systemSymbolName: "play.fill", accessibilityDescription: "1x Speed")!,
                NSImage(systemSymbolName: "forward.fill", accessibilityDescription: "2x Speed")!
            ]
            let control = NSPickerTouchBarItem(identifier: identifier, images: simSpeedImages, selectionMode: .selectOne, target: self, action: #selector(Self.simSpeedChanged(_:)))
            control.controlRepresentation = .expanded
            control.customizationLabel = "Simulation Speed"
            return control
        case .beaconLight:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Beacon", target: self, action: #selector(Self.beaconChanged(_:)))
            toggle.customizationLabel = "Beacon Light"
            return toggle
        case .landingLights:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Land", target: self, action: #selector(Self.landingChanged(_:)))
            toggle.customizationLabel = "Landing Lights"
            return toggle
        case .navigationLights:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Nav", target: self, action: #selector(Self.navigationChanged(_:)))
            toggle.customizationLabel = "Navigation Lights"
            return toggle
        case.taxiLight:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Taxi", target: self, action: #selector(Self.taxiChanged(_:)))
            toggle.customizationLabel = "Taxi Light"
            return toggle
        case .strobeLights:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Strobe", target: self, action: #selector(Self.strobeChanged(_:)))
            toggle.customizationLabel = "Strobe Lights"
            return toggle
        case .lights:
            let popover = NSPopoverTouchBarItem(identifier: identifier)
            popover.customizationLabel = "Lights"
            popover.collapsedRepresentationImage = NSImage(systemSymbolName: "lightbulb", accessibilityDescription: "Lights")
            popover.popoverTouchBar.customizationIdentifier = .lightsBar
            popover.popoverTouchBar.defaultItemIdentifiers = [.beaconLight, .landingLights, .navigationLights, .strobeLights, .taxiLight]
            // This method will also construct the items of the popover touchbar
            popover.popoverTouchBar.delegate = touchBar.delegate!
            return popover
        case .radios:
            let popover = NSPopoverTouchBarItem(identifier: identifier)
            popover.customizationLabel = "Radios"
            popover.collapsedRepresentationImage = NSImage(systemSymbolName: "radio", accessibilityDescription: "Radios")
            popover.popoverTouchBar.customizationIdentifier = .radiosBar
            popover.popoverTouchBar.defaultItemIdentifiers = [.com1, .com1Mic, .flexibleSpace, .com2, .com2Mic, .flexibleSpace, .nav1, .nav2, .flexibleSpace, .dme, .flexibleSpace, .mkr]
            popover.popoverTouchBar.delegate = touchBar.delegate!
            return popover
        case .com1:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "COM1", target: self, action: #selector(Self.com1Changed(_:)))
            toggle.customizationLabel = "COM1"
            return toggle
        case .com2:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "COM2", target: self, action: #selector(Self.com2Changed(_:)))
            toggle.customizationLabel = "COM2"
            return toggle
        case .nav1:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "NAV1", target: self, action: #selector(Self.nav1Changed(_:)))
            toggle.customizationLabel = "NAV1"
            return toggle
        case .nav2:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "NAV2", target: self, action: #selector(Self.nav2Changed(_:)))
            toggle.customizationLabel = "NAV2"
            return toggle
        case .mkr:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "MKR", target: self, action: #selector(Self.mkrChanged(_:)))
            toggle.customizationLabel = "MKR"
            return toggle
        case .dme:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "DME", target: self, action: #selector(Self.dmeChanged(_:)))
            toggle.customizationLabel = "DME"
            return toggle
        case .com1Mic:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "MIC", target: self, action: #selector(Self.com1MicPressed(_:)))
            toggle.customizationLabel = "COM1 MIC"
            return toggle
        case .com2Mic:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "MIC", target: self, action: #selector(Self.com2MicPressed(_:)))
            toggle.customizationLabel = "COM2 MIC"
            return toggle
        case .camera:
            let labels = [
                "Cockpit",
                "Chase",
                "Circle",
                "HUD",
                "Linear",
                "Runway",
                "Spot",
                "Tower",
            ]
            let control = NSPickerTouchBarItem(identifier: identifier, labels: labels, selectionMode: .selectOne, target: self, action: #selector(Self.cameraChanged(_:)))
            control.controlRepresentation = .collapsed
            control.customizationLabel = "Camera"
            control.collapsedRepresentationImage = NSImage(systemSymbolName: "video", accessibilityDescription: "Camera")
            return control
        default:
            return nil
        }
    }
    
    @objc func throttleChanged(_ sender: NSSlider) {
        props.throttle = sender.floatValue
    }
    
    @objc func pitchChanged(_ sender: NSSlider) {
        props.pitch = sender.floatValue
    }
    
    @objc func mixtureChanged(_ sender: NSSlider) {
        props.mixture = sender.floatValue
    }
    
    @objc func flapsChanged(_ sender: NSSlider) {
        props.flaps = sender.floatValue
    }
    
    @objc func speedbrakeChanged(_ sender: NSSlider) {
        props.speedbrake = sender.floatValue
    }
    
    @objc func simSpeedChanged(_ sender: NSPickerTouchBarItem) {
        switch sender.selectedIndex {
        case 0:
            props.simSpeed = .pause
        case 1:
            props.simSpeed = .x1
        case 2:
            props.simSpeed = .x2
        default:
            break
        }
    }
    
    @objc func cameraChanged(_ sender: NSPickerTouchBarItem) {
        switch sender.selectedIndex {
        case 0:
            props.camera = .cockpit
        case 1:
            props.camera = .chase
        case 2:
            props.camera = .circle
        case 3:
            props.camera = .hud
        case 4:
            props.camera = .linearSpot
        case 5:
            props.camera = .runway
        case 6:
            props.camera = .stillSpot
        case 7:
            props.camera = .tower
        default:
            break
        }
    }
    
    @objc func gearChanged(_ sender: NSButton) {
        props.gear.toggle()
    }
    
    @objc func parkingBrakeChanged(_ sender: NSButton) {
        props.parkingBrake.toggle()
    }
    
    @objc func beaconChanged(_ sender: NSButton) {
        props.beaconLights.toggle()
    }
    
    @objc func landingChanged(_ sender: NSButton) {
        props.landingLights.toggle()
    }
    
    @objc func navigationChanged(_ sender: NSButton) {
        props.navigationLights.toggle()
    }
    
    @objc func taxiChanged(_ sender: NSButton) {
        props.taxiLight.toggle()
    }
    
    @objc func strobeChanged(_ sender: NSButton) {
        props.strobeLights.toggle()
    }
    
    @objc func com1Changed(_ sender: NSButton) {
        props.com1audio.toggle()
    }
    
    @objc func com2Changed(_ sender: NSButton) {
        props.com2audio.toggle()
    }
    
    @objc func nav1Changed(_ sender: NSButton) {
        props.nav1audio.toggle()
    }
    
    @objc func nav2Changed(_ sender: NSButton) {
        props.nav2audio.toggle()
    }
    
    @objc func dmeChanged(_ sender: NSButton) {
        props.dmeAudio.toggle()
    }
    
    @objc func mkrChanged(_ sender: NSButton) {
        props.mkrAudio.toggle()
    }
    
    @objc func com1MicPressed(_ sender: NSButton) {
        props.comSelection = .com1
    }
    
    @objc func com2MicPressed(_ sender: NSButton) {
        props.comSelection = .com2
    }
    
    func updateNSTouchBar(_ touchBar: NSTouchBar) {
        if let s = touchBar.item(forIdentifier: .speedbrake) as? NSSliderTouchBarItem {
            s.doubleValue = Double(props.speedbrake)
        }
        
        if let t = touchBar.item(forIdentifier: .throttle) as? NSSliderTouchBarItem {
            t.doubleValue = Double(props.throttle)
        }
        
        if let p = touchBar.item(forIdentifier: .pitch) as? NSSliderTouchBarItem {
            p.doubleValue = Double(props.pitch)
        }
        
        if let m = touchBar.item(forIdentifier: .mixture) as? NSSliderTouchBarItem {
            m.doubleValue = Double(props.mixture)
        }
        
        if let f = touchBar.item(forIdentifier: .flaps) as? NSSliderTouchBarItem {
            f.doubleValue = Double(props.flaps)
        }
        
        if let g = touchBar.item(forIdentifier: .gear) as? NSButtonTouchBarItem {
            switch props.gear {
            case .down:
                g.bezelColor = .systemGreen
            case .up:
                g.bezelColor = .controlColor
            }
        }
        
        if let ss = touchBar.item(forIdentifier: .simSpeed) as? NSPickerTouchBarItem {
            switch props.simSpeed {
            case .pause:
                ss.selectedIndex = 0
            case .x1:
                ss.selectedIndex = 1
            case .x2:
                ss.selectedIndex = 2
            }
        }
        
        if let c = touchBar.item(forIdentifier: .camera) as? NSPickerTouchBarItem {
            switch props.camera {
            case .cockpit:
                c.selectedIndex = 0
            case .chase:
                c.selectedIndex = 1
            case .circle:
                c.selectedIndex = 2
            case .hud:
                c.selectedIndex = 3
            case .linearSpot:
                c.selectedIndex = 4
            case .runway:
                c.selectedIndex = 5
            case .stillSpot:
                c.selectedIndex = 6
            case .tower:
                c.selectedIndex = 7
            }
        }
        
        if let b = touchBar.item(forIdentifier: .parkingBrake) as? NSButtonTouchBarItem {
            if props.parkingBrake {
                b.bezelColor = .systemRed
            } else {
                b.bezelColor = .controlColor
            }
        }
        
        if let l = touchBar.item(forIdentifier: .lights) as? NSPopoverTouchBarItem {
            let lightsBar = l.popoverTouchBar
            
            if let beaconButton = lightsBar.item(forIdentifier: .beaconLight) as? NSButtonTouchBarItem {
                beaconButton.bezelColor = lightsBezelColor(props.beaconLights)
            }
            
            if let landingButton = lightsBar.item(forIdentifier: .landingLights) as? NSButtonTouchBarItem {
                landingButton.bezelColor = lightsBezelColor(props.landingLights)
            }
            
            if let navigationButton = lightsBar.item(forIdentifier: .navigationLights) as? NSButtonTouchBarItem {
                navigationButton.bezelColor = lightsBezelColor(props.navigationLights)
            }
            
            if let strobeButton = lightsBar.item(forIdentifier: .strobeLights) as? NSButtonTouchBarItem {
                strobeButton.bezelColor = lightsBezelColor(props.strobeLights)
            }
            
            if let taxiButton = lightsBar.item(forIdentifier: .taxiLight) as? NSButtonTouchBarItem {
                taxiButton.bezelColor = lightsBezelColor(props.taxiLight)
            }
        }
        
        if let r = touchBar.item(forIdentifier: .radios) as? NSPopoverTouchBarItem {
            let radiosBar = r.popoverTouchBar
            
            if let com1Button = radiosBar.item(forIdentifier: .com1) as? NSButtonTouchBarItem {
                com1Button.bezelColor = radiosBezelColor(props.com1audio)
            }
            
            if let com2Button = radiosBar.item(forIdentifier: .com2) as? NSButtonTouchBarItem {
                com2Button.bezelColor = radiosBezelColor(props.com2audio)
            }
            
            if let nav1Button = radiosBar.item(forIdentifier: .nav1) as? NSButtonTouchBarItem {
                nav1Button.bezelColor = radiosBezelColor(props.nav1audio)
            }
            
            if let nav2Button = radiosBar.item(forIdentifier: .nav2) as? NSButtonTouchBarItem {
                nav2Button.bezelColor = radiosBezelColor(props.nav2audio)
            }
            
            if let dmeButton = radiosBar.item(forIdentifier: .dme) as? NSButtonTouchBarItem {
                dmeButton.bezelColor = radiosBezelColor(props.dmeAudio)
            }
            
            if let mkrButton = radiosBar.item(forIdentifier: .mkr) as? NSButtonTouchBarItem {
                mkrButton.bezelColor = radiosBezelColor(props.mkrAudio)
            }
            
            if let com1MicButton = radiosBar.item(forIdentifier: .com1Mic) as? NSButtonTouchBarItem,
               let com2MicButton = radiosBar.item(forIdentifier: .com2Mic) as? NSButtonTouchBarItem {
                switch props.comSelection {
                case .com1:
                    com1MicButton.bezelColor = .systemGreen
                    com2MicButton.bezelColor = .controlColor
                case .com2:
                    com1MicButton.bezelColor = .controlColor
                    com2MicButton.bezelColor = .systemGreen
                }
            }
        }
    }
}

fileprivate func lightsBezelColor(_ isOn: Bool) -> NSColor {
    if isOn {
        return .systemYellow
    } else {
        return .controlColor
    }
}

fileprivate func radiosBezelColor(_ isOn: Bool) -> NSColor {
    if isOn {
        return .systemGreen
    } else {
        return .controlColor
    }
}
