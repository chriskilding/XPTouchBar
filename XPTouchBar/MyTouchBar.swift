import Foundation
import AppKit
import SwiftUI

public struct MyTouchBar: NSTouchBarRepresentable {
    
    @Binding var throttle: Double
    @Binding var pitch: Double
    @Binding var mixture: Double
    @Binding var flaps: Double
    @Binding var gear: Gear
    @Binding var parkingBrake: ParkingBrake
    
    func makeNSTouchBar(context: Context) -> NSTouchBar {
        let touchBar = NSTouchBar()
        touchBar.customizationIdentifier = .xpTouchBar
        touchBar.defaultItemIdentifiers = [.throttle, .mixture, .flaps]
        touchBar.customizationAllowedItemIdentifiers = [.throttle, .pitch, .mixture, .flaps, .gear, .parkingBrake]
        return touchBar
    }
    
    func makeNSTouchBarItem(makeItemForIdentifier identifier: NSTouchBarItem.Identifier, context: Context) -> NSTouchBarItem? {
        switch identifier {
        case .throttle:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = "T"
            sliderTouchBarItem.customizationLabel = "Throttle"
            sliderTouchBarItem.slider.trackFillColor = .white
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.slider.target = context.coordinator
            sliderTouchBarItem.slider.action = #selector(Coordinator.throttleChanged(_:))
            return sliderTouchBarItem
        case .pitch:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = "P"
            sliderTouchBarItem.customizationLabel = "Propeller Pitch"
            sliderTouchBarItem.slider.trackFillColor = .blue
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.slider.target = context.coordinator
            sliderTouchBarItem.slider.action = #selector(Coordinator.pitchChanged(_:))
            return sliderTouchBarItem
        case .mixture:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = "M"
            sliderTouchBarItem.customizationLabel = "Mixture"
            sliderTouchBarItem.slider.trackFillColor = .red
            sliderTouchBarItem.slider.minValue = 0
            sliderTouchBarItem.slider.maxValue = 1
            sliderTouchBarItem.slider.target = context.coordinator
            sliderTouchBarItem.slider.action = #selector(Coordinator.mixtureChanged(_:))
            return sliderTouchBarItem
        case .flaps:
            let sliderTouchBarItem = NSSliderTouchBarItem(identifier: identifier)
            sliderTouchBarItem.label = "F"
            sliderTouchBarItem.customizationLabel = "Flaps"
            sliderTouchBarItem.slider.trackFillColor = .green
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
        default:
            return nil
        }
    }
    
    // SwiftUI -> AppKit updates
    func updateNSTouchBar(_ touchBar: NSTouchBar, context: Context) {
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
        
        if let g = touchBar.item(forIdentifier: .gear) as? NSButtonTouchBarItem {
            switch gear {
            case .down:
                g.bezelColor = .systemBlue
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
    
    @Binding var throttle: Double
    @Binding var pitch: Double
    @Binding var mixture: Double
    @Binding var flaps: Double
    @Binding var gear: Gear
    @Binding var parkingBrake: ParkingBrake
    
    func body(content: Content) -> some View {
        let representable = MyTouchBar(throttle: $throttle, pitch: $pitch, mixture: $mixture, flaps: $flaps, gear: $gear, parkingBrake: $parkingBrake)
        return NSTouchBarViewControllerRepresentable<Content, MyTouchBar>(content: {content}, representable: representable)
    }
}

extension View {
    func myTouchBar(throttle: Binding<Double>, pitch: Binding<Double>, mixture: Binding<Double>, flaps: Binding<Double>, gear: Binding<Gear>, parkingBrake: Binding<ParkingBrake>) -> some View {
        self.modifier(MyTouchBarModifier(throttle: throttle, pitch: pitch, mixture: mixture, flaps: flaps, gear: gear, parkingBrake: parkingBrake))
    }
}
