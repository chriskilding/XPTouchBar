import SwiftUI

struct DebugView: View {
    
    @Binding var speedbrake: Float
    @Binding var throttle: Float
    @Binding var pitch: Float
    @Binding var mixture: Float
    @Binding var flaps: Float
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
    
    fileprivate var entries: [Entry] {
        return [
            Entry(dataref: Dataref.SpeedbrakeRatio, value: speedbrake),
            Entry(dataref: Dataref.ThrottleRatioAll, value: throttle),
            Entry(dataref: Dataref.PropRatioAll, value: pitch),
            Entry(dataref: Dataref.MixtureRatioAll, value: mixture),
            Entry(dataref: Dataref.FlapRatio, value: flaps),
            Entry(dataref: Dataref.BeaconOn, value: beaconLights),
            Entry(dataref: Dataref.GearHandleDown, value: gear),
            Entry(dataref: Dataref.ParkingBrakeRatio, value: parkingBrake),
            Entry(dataref: Dataref.SimSpeed, value: simSpeed),
            Entry(dataref: Dataref.LandingLightsOn, value: landingLights),
            Entry(dataref: Dataref.NavigationLightsOn, value: navigationLights),
            Entry(dataref: Dataref.StrobeLightsOn, value: strobeLights),
            Entry(dataref: Dataref.TaxiLightOn, value: taxiLight),
            Entry(dataref: Dataref.CockpitLights, value: cockpitLights),
            Entry(dataref: Dataref.InstrumentBrightness, value: instrumentBrightness)
        ].sorted(using: sortOrder)
    }
    
    @State private var sortOrder = [KeyPathComparator(\Entry.dataref)]
    
    var body: some View {
        Table(entries, sortOrder: $sortOrder) {
            TableColumn("Dataref", value: \.dataref)
            TableColumn("Value", value: \.value)
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView(speedbrake: .constant(0), throttle: .constant(0), pitch: .constant(1), mixture: .constant(1), flaps: .constant(0), gear: .constant(.down), parkingBrake: .constant(.on), simSpeed: .constant(.x1), beaconLights: .constant(true), landingLights: .constant(true), navigationLights: .constant(true), strobeLights: .constant(true), taxiLight: .constant(true), cockpitLights: .constant(.min), instrumentBrightness: .constant(.max))
    }
}

fileprivate struct Entry: Identifiable {
    let dataref: String
    let value: String
    let id = UUID()
    
    init(dataref: CustomStringConvertible, value: Float) {
        self.dataref = dataref.description
        self.value = "\(value)"
    }
    
    init(dataref: CustomStringConvertible, value: CustomFloatConvertible) {
        self.dataref = dataref.description
        self.value = "\(value.floatValue)"
    }
}
