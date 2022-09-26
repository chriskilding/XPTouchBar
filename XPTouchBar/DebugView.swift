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
            Entry(dataref: Dataref.ViewType, value: props.camera),
            Entry(dataref: Dataref.Com1Power, value: props.com1power),
            Entry(dataref: Dataref.AudioSelectionCom1, value: props.com1audio),
            Entry(dataref: Dataref.Com2Power, value: props.com2power),
            Entry(dataref: Dataref.AudioSelectionCom2, value: props.com2audio),
            Entry(dataref: Dataref.Nav1Power, value: props.nav1power),
            Entry(dataref: Dataref.AudioSelectionNav1, value: props.nav1audio),
            Entry(dataref: Dataref.Nav2Power, value: props.nav2power),
            Entry(dataref: Dataref.AudioSelectionNav2, value: props.nav2audio),
            Entry(dataref: Dataref.AudioComSelection, value: props.comSelection),
            Entry(dataref: Dataref.AudioDmeEnabled, value: props.dmeAudio),
            Entry(dataref: Dataref.AudioMarkerEnabled, value: props.mkrAudio),
            Entry(dataref: Dataref.HideYoke, value: props.hideYoke)
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
