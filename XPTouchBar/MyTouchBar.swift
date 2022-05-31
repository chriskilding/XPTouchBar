import Foundation
import AppKit
import SwiftUI

public struct MyTouchBar: NSTouchBarRepresentable {
    
    @Binding var speedbrake: Double
    @Binding var throttle: Double
    @Binding var pitch: Double
    @Binding var mixture: Double
    @Binding var flaps: Double
    @Binding var gear: Gear
    @Binding var parkingBrake: ParkingBrake
    @Binding var simSpeed: SimSpeed
    @Binding var beaconLights: Bool
    @Binding var landingLights: Bool
    @Binding var navigationLights: Bool
    @Binding var strobeLights: Bool
    @Binding var taxiLight: Bool
    @Binding var cockpitLights: Brightness
    @Binding var instrumentBrightness: Brightness
    
    func makeNSTouchBar(context: Context) -> NSTouchBar {
        let touchBar = NSTouchBar()
        touchBar.customizationIdentifier = .xpTouchBar
        touchBar.defaultItemIdentifiers = [.throttle, .mixture, .flaps]
        touchBar.customizationAllowedItemIdentifiers = [.throttle, .pitch, .mixture, .flaps, .gear, .parkingBrake, .speedbrake, .simSpeed, .lights]
        return touchBar
    }
    
    func makeNSTouchBarItem(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier, context: Context) -> NSTouchBarItem? {
        switch identifier {
        case .speedbrake:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = Speedbrake.symbol
            sliderTouchBarItem.customizationLabel = Speedbrake.name
            sliderTouchBarItem.slider.trackFillColor = Speedbrake.color
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.slider.target = context.coordinator
            sliderTouchBarItem.slider.action = #selector(Coordinator.speedbrakeChanged(_:))
            return sliderTouchBarItem
        case .throttle:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = Throttle.symbol
            sliderTouchBarItem.customizationLabel = Throttle.name
            sliderTouchBarItem.slider.trackFillColor = Throttle.color
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.slider.target = context.coordinator
            sliderTouchBarItem.slider.action = #selector(Coordinator.throttleChanged(_:))
            return sliderTouchBarItem
        case .pitch:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = Pitch.symbol
            sliderTouchBarItem.customizationLabel = Pitch.name
            sliderTouchBarItem.slider.trackFillColor = Pitch.color
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.slider.target = context.coordinator
            sliderTouchBarItem.slider.action = #selector(Coordinator.pitchChanged(_:))
            return sliderTouchBarItem
        case .mixture:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = Mixture.symbol
            sliderTouchBarItem.customizationLabel = Mixture.name
            sliderTouchBarItem.slider.trackFillColor = Mixture.color
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.slider.target = context.coordinator
            sliderTouchBarItem.slider.action = #selector(Coordinator.mixtureChanged(_:))
            return sliderTouchBarItem
        case .flaps:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = Flaps.symbol
            sliderTouchBarItem.customizationLabel = Flaps.name
            sliderTouchBarItem.slider.trackFillColor = Flaps.color
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.slider.target = context.coordinator
            sliderTouchBarItem.slider.action = #selector(Coordinator.flapsChanged(_:))
            return sliderTouchBarItem
        case .gear:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Gear", target: context.coordinator, action: #selector(Coordinator.gearChanged(_:)))
            toggle.customizationLabel = "Landing Gear"
            return toggle
        case .parkingBrake:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Park", target: context.coordinator, action: #selector(Coordinator.parkingBrakeChanged(_:)))
            toggle.customizationLabel = "Parking Brake"
            return toggle
        case .simSpeed:
            let pauseImage = NSImage(systemSymbolName: "pause.fill", accessibilityDescription: "Pause")!
            let toggle = NSButtonTouchBarItem(identifier: identifier, image: pauseImage, target: context.coordinator, action: #selector(Coordinator.simSpeedChanged(_:)))
            toggle.customizationLabel = "Sim Speed"
            return toggle
        case .beaconLight:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Beacon", target: context.coordinator, action: #selector(Coordinator.beaconChanged(_:)))
            toggle.customizationLabel = "Beacon Light"
            return toggle
        case .landingLights:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Land", target: context.coordinator, action: #selector(Coordinator.landingChanged(_:)))
            toggle.customizationLabel = "Landing Lights"
            return toggle
        case .navigationLights:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Nav", target: context.coordinator, action: #selector(Coordinator.navigationChanged(_:)))
            toggle.customizationLabel = "Navigation Lights"
            return toggle
        case.taxiLight:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Taxi", target: context.coordinator, action: #selector(Coordinator.taxiChanged(_:)))
            toggle.customizationLabel = "Taxi Light"
            return toggle
        case .strobeLights:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Strobe", target: context.coordinator, action: #selector(Coordinator.strobeChanged(_:)))
            toggle.customizationLabel = "Strobe Lights"
            return toggle
        case .cockpitLights:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Cockpit", target: context.coordinator, action: #selector(Coordinator.cockpitLightsChanged(_:)))
            toggle.customizationLabel = "Cockpit Lights"
            return toggle
        case .instrumentBrightness:
            let toggle = NSButtonTouchBarItem(identifier: identifier, title: "Inst", target: context.coordinator, action: #selector(Coordinator.instrumentBrightnessChanged(_:)))
            toggle.customizationLabel = "Instrument Brightness"
            return toggle
        case .lights:
            let popover = NSPopoverTouchBarItem(identifier: identifier)
            popover.customizationLabel = "Lights"
            popover.collapsedRepresentationImage = NSImage(systemSymbolName: "lightbulb.fill", accessibilityDescription: "Lights")
            popover.popoverTouchBar.customizationIdentifier = .lightsBar
            popover.popoverTouchBar.defaultItemIdentifiers = [.beaconLight, .landingLights, .navigationLights, .strobeLights, .taxiLight, .flexibleSpace, .cockpitLights, .instrumentBrightness]
            popover.popoverTouchBar.delegate = touchBar.delegate!
            return popover
        default:
            return nil
        }
    }
    
    // SwiftUI -> AppKit updates
    func updateNSTouchBar(_ touchBar: NSTouchBar, context: Context) {
        if let s = touchBar.item(forIdentifier: .speedbrake) as? NSSliderTouchBarItem {
            s.doubleValue = speedbrake
        }
        
        if let t = touchBar.item(forIdentifier: .throttle) as? NSSliderTouchBarItem {
            t.doubleValue = throttle
        }
        
        if let p = touchBar.item(forIdentifier: .pitch) as? NSSliderTouchBarItem {
            p.doubleValue = pitch
        }
        
        if let m = touchBar.item(forIdentifier: .mixture) as? NSSliderTouchBarItem {
            m.doubleValue = mixture
        }
        
        if let f = touchBar.item(forIdentifier: .flaps) as? NSSliderTouchBarItem {
            f.doubleValue = flaps
        }
        
        if let sims = touchBar.item(forIdentifier: .simSpeed) as? NSButtonTouchBarItem {
            switch simSpeed {
            case .play:
                sims.image = NSImage(systemSymbolName: "pause.fill", accessibilityDescription: "Pause")
            case .pause:
                sims.image = NSImage(systemSymbolName: "play.fill", accessibilityDescription: "Play")
            }
        }
        
        if let g = touchBar.item(forIdentifier: .gear) as? NSButtonTouchBarItem {
            switch gear {
            case .down:
                g.bezelColor = .systemGray
            case .up:
                g.bezelColor = .controlColor
            }
        }
        
        if let b = touchBar.item(forIdentifier: .parkingBrake) as? NSButtonTouchBarItem {
            switch parkingBrake {
            case .on:
                b.bezelColor = .systemRed
            case .off:
                b.bezelColor = .controlColor
            }
        }
        
        if let l = touchBar.item(forIdentifier: .lights) as? NSPopoverTouchBarItem {
            let lightsBar = l.popoverTouchBar
            
            if let beaconButton = lightsBar.item(forIdentifier: .beaconLight) as? NSButtonTouchBarItem {
                if beaconLights {
                    beaconButton.bezelColor = .systemYellow
                } else {
                    beaconButton.bezelColor = .controlColor
                }
            }
            
            if let landingButton = lightsBar.item(forIdentifier: .landingLights) as? NSButtonTouchBarItem {
                if landingLights {
                    landingButton.bezelColor = .systemYellow
                } else {
                    landingButton.bezelColor = .controlColor
                }
            }
            
            if let navigationButton = lightsBar.item(forIdentifier: .navigationLights) as? NSButtonTouchBarItem {
                if navigationLights {
                    navigationButton.bezelColor = .systemYellow
                } else {
                    navigationButton.bezelColor = .controlColor
                }
            }
            
            if let strobeButton = lightsBar.item(forIdentifier: .strobeLights) as? NSButtonTouchBarItem {
                if strobeLights {
                    strobeButton.bezelColor = .systemYellow
                } else {
                    strobeButton.bezelColor = .controlColor
                }
            }
            
            if let taxiButton = lightsBar.item(forIdentifier: .taxiLight) as? NSButtonTouchBarItem {
                if taxiLight {
                    taxiButton.bezelColor = .systemYellow
                } else {
                    taxiButton.bezelColor = .controlColor
                }
            }
            
            if let cockpitLightsButton = lightsBar.item(forIdentifier: .cockpitLights) as? NSButtonTouchBarItem {
                cockpitLightsButton.bezelColor = cockpitLights.color
            }
            
            if let instrumentBrightnessButton = lightsBar.item(forIdentifier: .instrumentBrightness) as? NSButtonTouchBarItem {
                instrumentBrightnessButton.bezelColor = instrumentBrightness.color
            }
        }
    }
    
    static func dismantleNSTouchBar(_ touchBar: NSTouchBar, coordinator: Coordinator) {
        // optional
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    public class Coordinator: NSObject {
        var parent: MyTouchBar
        
        init(_ parent: MyTouchBar) {
            self.parent = parent
        }
        
        // AppKit -> SwiftUI updates
        
        @objc func throttleChanged(_ sender: NSSlider) {
            parent.throttle = sender.doubleValue
        }
        
        @objc func pitchChanged(_ sender: NSSlider) {
            parent.pitch = sender.doubleValue
        }
        
        @objc func mixtureChanged(_ sender: NSSlider) {
            parent.mixture = sender.doubleValue
        }
        
        @objc func flapsChanged(_ sender: NSSlider) {
            parent.flaps = sender.doubleValue
        }
        
        @objc func speedbrakeChanged(_ sender: NSSlider) {
            parent.speedbrake = sender.doubleValue
        }
        
        @objc func simSpeedChanged(_ sender: NSButton) {
            switch parent.simSpeed {
            case .pause:
                parent.simSpeed = .play
            case .play:
                parent.simSpeed = .pause
            }
        }
        
        @objc func gearChanged(_ sender: NSButton) {
            switch parent.gear {
            case .up:
                parent.gear = .down
            case .down:
                parent.gear = .up
            }
        }
        
        @objc func parkingBrakeChanged(_ sender: NSButton) {
            switch parent.parkingBrake {
            case .off:
                parent.parkingBrake = .on
            case .on:
                parent.parkingBrake = .off
            }
        }
        
        @objc func beaconChanged(_ sender: NSButton) {
            parent.beaconLights = !parent.beaconLights
        }
        
        @objc func landingChanged(_ sender: NSButton) {
            parent.landingLights = !parent.landingLights
        }
        
        @objc func navigationChanged(_ sender: NSButton) {
            parent.navigationLights = !parent.navigationLights
        }
        
        @objc func taxiChanged(_ sender: NSButton) {
            parent.taxiLight = !parent.taxiLight
        }
        
        @objc func strobeChanged(_ sender: NSButton) {
            parent.strobeLights = !parent.strobeLights
        }
        
        @objc func cockpitLightsChanged(_ sender: NSButton) {
            parent.cockpitLights = parent.cockpitLights.next
        }
        
        @objc func instrumentBrightnessChanged(_ sender: NSButton) {
            parent.instrumentBrightness = parent.instrumentBrightness.next
        }
    }
}

//
// Glue code
//

struct MyTouchBarModifier: ViewModifier {
    
    @Binding var speedbrake: Double
    @Binding var throttle: Double
    @Binding var pitch: Double
    @Binding var mixture: Double
    @Binding var flaps: Double
    @Binding var gear: Gear
    @Binding var parkingBrake: ParkingBrake
    @Binding var simSpeed: SimSpeed
    @Binding var beaconLights: Bool
    @Binding var landingLights: Bool
    @Binding var navigationLights: Bool
    @Binding var strobeLights: Bool
    @Binding var taxiLight: Bool
    @Binding var cockpitLights: Brightness
    @Binding var instrumentBrightness: Brightness
    
    func body(content: Content) -> some View {
        let representable = MyTouchBar(speedbrake: $speedbrake, throttle: $throttle, pitch: $pitch, mixture: $mixture, flaps: $flaps, gear: $gear, parkingBrake: $parkingBrake, simSpeed: $simSpeed, beaconLights: $beaconLights, landingLights: $landingLights, navigationLights: $navigationLights, strobeLights: $strobeLights, taxiLight: $taxiLight, cockpitLights: $cockpitLights, instrumentBrightness: $instrumentBrightness)
        return NSTouchBarViewControllerRepresentable<Content, MyTouchBar>(content: {content}, representable: representable)
    }
}

extension View {
    func myTouchBar(speedbrake: Binding<Double>, throttle: Binding<Double>, pitch: Binding<Double>, mixture: Binding<Double>, flaps: Binding<Double>, gear: Binding<Gear>, parkingBrake: Binding<ParkingBrake>, simSpeed: Binding<SimSpeed>, beaconLights: Binding<Bool>, landingLights: Binding<Bool>, navigationLights: Binding<Bool>, strobeLights: Binding<Bool>, taxiLight: Binding<Bool>, cockpitLights: Binding<Brightness>, instrumentBrightness: Binding<Brightness>) -> some View {
        self.modifier(MyTouchBarModifier(speedbrake: speedbrake, throttle: throttle, pitch: pitch, mixture: mixture, flaps: flaps, gear: gear, parkingBrake: parkingBrake, simSpeed: simSpeed, beaconLights: beaconLights, landingLights: landingLights, navigationLights: navigationLights, strobeLights: strobeLights, taxiLight: taxiLight, cockpitLights: cockpitLights, instrumentBrightness: instrumentBrightness))
    }
}

