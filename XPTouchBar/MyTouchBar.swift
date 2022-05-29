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
    
    func makeNSTouchBar(context: Context) -> NSTouchBar {
        let touchBar = NSTouchBar()
        touchBar.customizationIdentifier = .xpTouchBar
        touchBar.defaultItemIdentifiers = [.throttle, .mixture, .flaps]
        touchBar.customizationAllowedItemIdentifiers = [.throttle, .pitch, .mixture, .flaps, .gear, .parkingBrake, .speedbrake, .simSpeed]
        return touchBar
    }
    
    func makeNSTouchBarItem(makeItemForIdentifier identifier: NSTouchBarItem.Identifier, context: Context) -> NSTouchBarItem? {
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
                g.bezelColor = .darkGray
            }
        }
        
        if let b = touchBar.item(forIdentifier: .parkingBrake) as? NSButtonTouchBarItem {
            switch parkingBrake {
            case .on:
                b.bezelColor = .systemRed
            case .off:
                b.bezelColor = .darkGray
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
    
    func body(content: Content) -> some View {
        let representable = MyTouchBar(speedbrake: $speedbrake, throttle: $throttle, pitch: $pitch, mixture: $mixture, flaps: $flaps, gear: $gear, parkingBrake: $parkingBrake, simSpeed: $simSpeed)
        return NSTouchBarViewControllerRepresentable<Content, MyTouchBar>(content: {content}, representable: representable)
    }
}

extension View {
    func myTouchBar(speedbrake: Binding<Double>, throttle: Binding<Double>, pitch: Binding<Double>, mixture: Binding<Double>, flaps: Binding<Double>, gear: Binding<Gear>, parkingBrake: Binding<ParkingBrake>, simSpeed: Binding<SimSpeed>) -> some View {
        self.modifier(MyTouchBarModifier(speedbrake: speedbrake, throttle: throttle, pitch: pitch, mixture: mixture, flaps: flaps, gear: gear, parkingBrake: parkingBrake, simSpeed: simSpeed))
    }
}
