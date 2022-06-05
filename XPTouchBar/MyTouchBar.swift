import AppKit

class MyTouchBar: NSObject, NSTouchBarDelegate {
    
    var props: XPlaneConnector!
    
    func makeTouchBar() -> NSTouchBar {
        let touchBar = NSTouchBar()
        touchBar.customizationIdentifier = .xpTouchBar
        touchBar.defaultItemIdentifiers = [.throttle, .mixture, .flaps]
        touchBar.customizationAllowedItemIdentifiers = [.throttle, .pitch, .mixture, .flaps, .gear, .parkingBrake, .speedbrake, .simSpeed, .lights, .flexibleSpace]
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
            let simSpeedImage = NSImage(systemSymbolName: "playpause.fill", accessibilityDescription: "Sim Speed")!
            let toggle = NSButtonTouchBarItem(identifier: identifier, image: simSpeedImage, target: self, action: #selector(Self.simSpeedChanged(_:)))
            toggle.customizationLabel = "Simulation Speed"
            return toggle
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
            popover.collapsedRepresentationImage = NSImage(systemSymbolName: "lightbulb.fill", accessibilityDescription: "Lights")
            popover.popoverTouchBar.customizationIdentifier = .lightsBar
            popover.popoverTouchBar.defaultItemIdentifiers = [.beaconLight, .landingLights, .navigationLights, .strobeLights, .taxiLight]
            // This method will also construct the items of the popover touchbar
            popover.popoverTouchBar.delegate = touchBar.delegate!
            return popover
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
    
    @objc func simSpeedChanged(_ sender: NSButton) {
        props.simSpeed = props.simSpeed.opposite
    }
    
    @objc func gearChanged(_ sender: NSButton) {
        props.gear = props.gear.opposite
    }
    
    @objc func parkingBrakeChanged(_ sender: NSButton) {
        props.parkingBrake = !props.parkingBrake
    }
    
    @objc func beaconChanged(_ sender: NSButton) {
        props.beaconLights = !props.beaconLights
    }
    
    @objc func landingChanged(_ sender: NSButton) {
        props.landingLights = !props.landingLights
    }
    
    @objc func navigationChanged(_ sender: NSButton) {
        props.navigationLights = !props.navigationLights
    }
    
    @objc func taxiChanged(_ sender: NSButton) {
        props.taxiLight = !props.taxiLight
    }
    
    @objc func strobeChanged(_ sender: NSButton) {
        props.strobeLights = !props.strobeLights
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
        
        if let ss = touchBar.item(forIdentifier: .simSpeed) as? NSButtonTouchBarItem {
            switch props.simSpeed {
            case .pause:
                ss.image = NSImage(systemSymbolName: "play.fill", accessibilityDescription: "Play")
            case .x1:
                ss.image = NSImage(systemSymbolName: "pause.fill", accessibilityDescription: "Pause")
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
                beaconButton.bezelColor = bezelColor(props.beaconLights)
            }
            
            if let landingButton = lightsBar.item(forIdentifier: .landingLights) as? NSButtonTouchBarItem {
                landingButton.bezelColor = bezelColor(props.landingLights)
            }
            
            if let navigationButton = lightsBar.item(forIdentifier: .navigationLights) as? NSButtonTouchBarItem {
                navigationButton.bezelColor = bezelColor(props.navigationLights)
            }
            
            if let strobeButton = lightsBar.item(forIdentifier: .strobeLights) as? NSButtonTouchBarItem {
                strobeButton.bezelColor = bezelColor(props.strobeLights)
            }
            
            if let taxiButton = lightsBar.item(forIdentifier: .taxiLight) as? NSButtonTouchBarItem {
                taxiButton.bezelColor  = bezelColor(props.taxiLight)
            }
        }
    }
}

fileprivate func bezelColor(_ isOn: Bool) -> NSColor {
    if isOn {
        return .systemYellow
    } else {
        return .controlColor
    }
}
