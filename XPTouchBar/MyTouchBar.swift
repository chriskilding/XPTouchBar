import Foundation
import AppKit
import SwiftUI

public struct MyTouchBar: NSTouchBarRepresentable {

    
    @Binding var throttle: Double
    @Binding var pitch: Double
    @Binding var mixture: Double
    @Binding var flaps: Double
    
    func makeNSTouchBar(context: Context) -> NSTouchBar {
        let touchBar = NSTouchBar()
        touchBar.customizationIdentifier = .xpTouchBar
        touchBar.defaultItemIdentifiers = [.throttle, .pitch, .mixture]
        touchBar.customizationAllowedItemIdentifiers = [.throttle, .pitch, .mixture, .flaps]
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
            sliderTouchBarItem.customizationLabel = "Pitch"
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
            let formatter = NumberFormatter()
            formatter.format = "Flaps "
            
            let stepperTouchBarItem = NSStepperTouchBarItem(identifier: .flaps, formatter: formatter)
            stepperTouchBarItem.minValue = 0
            stepperTouchBarItem.maxValue = 30
            stepperTouchBarItem.increment = 10
            stepperTouchBarItem.customizationLabel = "Flaps"
            stepperTouchBarItem.target = context.coordinator
            stepperTouchBarItem.action = #selector(Coordinator.flapsChanged(_:))
            return stepperTouchBarItem
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
        
        if let f = touchBar.item(forIdentifier: .flaps) as? NSStepperTouchBarItem {
            f.value = flaps
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
        
        @objc func flapsChanged(_ sender: NSStepperTouchBarItem) {
            parent.flaps = sender.value
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
    
    func body(content: Content) -> some View {
        let representable = MyTouchBar(throttle: $throttle, pitch: $pitch, mixture: $mixture, flaps: $flaps)
        return NSTouchBarViewControllerRepresentable<Content, MyTouchBar>(content: {content}, representable: representable)
    }
}

extension View {
    public func myTouchBar(throttle: Binding<Double>, pitch: Binding<Double>, mixture: Binding<Double>, flaps: Binding<Double>) -> some View {
        self.modifier(MyTouchBarModifier(throttle: throttle, pitch: pitch, mixture: mixture, flaps: flaps))
    }
}
