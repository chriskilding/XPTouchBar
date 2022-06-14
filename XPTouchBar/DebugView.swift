import SwiftUI

struct DebugView: View {
    
    @EnvironmentObject var props: XPlaneConnector
    
    fileprivate var entries: [Entry] {
        return [
            Entry(dataref: Dataref.SpeedbrakeRatio, value: props.speedbrake),
            Entry(dataref: Dataref.ThrottleRatioAll, value: props.throttle),
            Entry(dataref: Dataref.PropRatioAll, value: props.pitch),
            Entry(dataref: Dataref.MixtureRatioAll, value: props.mixture),
            Entry(dataref: Dataref.FlapRatio, value: props.flaps),
            Entry(dataref: Dataref.BeaconOn, value: props.beaconLights),
            Entry(dataref: Dataref.GearHandleDown, value: props.gear),
            Entry(dataref: Dataref.ParkingBrakeRatio, value: props.parkingBrake),
            Entry(dataref: Dataref.SimSpeed, value: props.simSpeed),
            Entry(dataref: Dataref.LandingLightsOn, value: props.landingLights),
            Entry(dataref: Dataref.NavigationLightsOn, value: props.navigationLights),
            Entry(dataref: Dataref.StrobeLightsOn, value: props.strobeLights),
            Entry(dataref: Dataref.TaxiLightOn, value: props.taxiLight),
            Entry(dataref: Dataref.ViewType, value: props.camera)
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
