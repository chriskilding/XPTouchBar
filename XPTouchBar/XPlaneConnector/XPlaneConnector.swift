import SwiftUI
import Network

class XPlaneConnector: ObservableObject {
    
    @Published var throttle: Float = 0 {
        didSet {
            let dref = DREF(dataref: .ThrottleRatioAll, value: throttle)
            self.send(dref)
        }
    }
    
    @Published var pitch: Float = 1 {
        didSet {
            let dref = DREF(dataref: .PropRatioAll, value: pitch)
            self.send(dref)
        }
    }
    
    @Published var mixture: Float = 1 {
        didSet {
            let dref = DREF(dataref: .MixtureRatioAll, value: mixture)
            self.send(dref)
        }
    }
    
    @Published var flaps: Float = 0 {
        didSet {
            let dref = DREF(dataref: .FlapRatio, value: flaps)
            self.send(dref)
        }
    }
    
    @Published var gear: Gear = .down {
        didSet {
            let dref = DREF(dataref: .GearHandleDown, value: gear.floatValue)
            self.send(dref)
        }
    }
    
    @Published var parkingBrake: Bool = true {
        didSet {
            let dref = DREF(dataref: .ParkingBrakeRatio, value: parkingBrake.floatValue)
            self.send(dref)
        }
    }
    
    @Published var speedbrake: Float = 0 {
        didSet {
            let dref = DREF(dataref: .SpeedbrakeRatio, value: speedbrake)
            self.send(dref)
        }
    }
    
    @Published var simSpeed: SimSpeed = .x1 {
        didSet {
            let dref = DREF(dataref: .SimSpeed, value: simSpeed.floatValue)
            self.send(dref)
        }
    }
    
    @Published var landingLights: Bool = true {
        didSet {
            let dref = DREF(dataref: .LandingLightsOn, value: landingLights.floatValue)
            self.send(dref)
        }
    }
    
    @Published var strobeLights: Bool = true {
        didSet {
            let dref = DREF(dataref: .StrobeLightsOn, value: strobeLights.floatValue)
            self.send(dref)
        }
    }
    
    @Published var taxiLight: Bool = true {
        didSet {
            let dref = DREF(dataref: .TaxiLightOn, value: taxiLight.floatValue)
            self.send(dref)
        }
    }
    
    @Published var beaconLights: Bool = true {
        didSet {
            let dref = DREF(dataref: .BeaconOn, value: beaconLights.floatValue)
            self.send(dref)
        }
    }
    
    @Published var navigationLights: Bool = true {
        didSet {
            let dref = DREF(dataref: .NavigationLightsOn, value: navigationLights.floatValue)
            self.send(dref)
        }
    }
    
    @Published var hideYoke: Bool = false {
        didSet {
            let dref = DREF(dataref: .HideYoke, value: hideYoke.floatValue)
            self.send(dref)
        }
    }
    
    @Published var com1power: Bool = true {
        didSet {
            let dref = DREF(dataref: .Com1Power, value: com1power.floatValue)
            self.send(dref)
        }
    }
    
    @Published var com1audio: Bool = true {
        didSet {
            let dref = DREF(dataref: .AudioSelectionCom1, value: com1audio.floatValue)
            self.send(dref)
        }
    }
    
    @Published var com2power: Bool = true {
        didSet {
            let dref = DREF(dataref: .Com2Power, value: com2power.floatValue)
            self.send(dref)
        }
    }
    
    @Published var com2audio: Bool = false {
        didSet {
            let dref = DREF(dataref: .AudioSelectionCom2, value: com2audio.floatValue)
            self.send(dref)
        }
    }
    
    @Published var nav1power: Bool = true {
        didSet {
            let dref = DREF(dataref: .Nav1Power, value: nav1power.floatValue)
            self.send(dref)
        }
    }
    
    @Published var nav1audio: Bool = false {
        didSet {
            let dref = DREF(dataref: .AudioSelectionNav1, value: nav1audio.floatValue)
            self.send(dref)
        }
    }
    
    @Published var nav2power: Bool = true {
        didSet {
            let dref = DREF(dataref: .Nav2Power, value: nav2power.floatValue)
            self.send(dref)
        }
    }
    
    @Published var nav2audio: Bool = false {
        didSet {
            let dref = DREF(dataref: .AudioSelectionNav2, value: nav2audio.floatValue)
            self.send(dref)
        }
    }
    
    @Published var dmeAudio: Bool = false {
        didSet {
            let dref = DREF(dataref: .AudioDmeEnabled, value: dmeAudio.floatValue)
            self.send(dref)
        }
    }
    
    @Published var mkrAudio: Bool = true {
        didSet {
            let dref = DREF(dataref: .AudioMarkerEnabled, value: mkrAudio.floatValue)
            self.send(dref)
        }
    }
    
    @Published var comSelection: ComSelection = .com1 {
        didSet {
            // Set the corresponding COM receive button states
            switch comSelection {
            case .com1:
                self.com1audio = true
                self.com2audio = false
            case .com2:
                self.com1audio = false
                self.com2audio = true
            }
            
            let dref = DREF(dataref: .AudioComSelection, value: comSelection.floatValue)
            self.send(dref)
        }
    }
    
    @Published var camera: Camera = .cockpit {
        didSet {
            let dref = DREF(dataref: .ViewType, value: camera.floatValue)
            self.send(dref)
        }
    }
    
    @AppStorage("host") var host: String = "127.0.0.1" {
        didSet {
            restart()
        }
    }
    
    @AppStorage("port") var port: Int = 49000 {
        didSet {
            restart()
        }
    }
    
    private func subscribe(to dataref: Dataref, frequency: Int) {
        let rref = RREF(frequency: frequency, id: dataref.id, dataref: dataref)
        send(rref)
    }
    
    private func unsubscribe(from dataref: Dataref) {
        let rref = RREF(frequency: 0, id: dataref.id, dataref: dataref)
        send(rref)
    }
    
    private var connection: NWConnection? = nil
    
    deinit {
        connection?.cancel()
    }
    
    func start() {
        connection = udpConnection(host: host, port: port)
        connection?.stateUpdateHandler = { newState in
            switch newState {
            case .ready:
                NSLog("X-Plane UDP connection ready")
            case .cancelled:
                NSLog("X-Plane UDP connection cancelled")
            default:
                break
            }
        }
        connection?.start(queue: .global())
    }
    
    func stop() {
        connection?.cancel()
    }
    
    /// Toggles the map window. Presented as a function rather than a variable, because this drives a CMND not a DREF.
    func toggleMap() {
        let cmnd = CMND(command: .MapShowCurrent)
        self.send(cmnd)
    }
    
    private func restart() {
        stop()
        start()
    }
    
    private func send(_ dataConvertible: CustomDataConvertible) {
        let data = dataConvertible.dataValue
        send(data)
    }
    
    private func send(_ data: Data) {
        connection?.send(content: data, completion: .idempotent)
    }
}

fileprivate func udpConnection(host: String, port: Int) -> NWConnection {
    let h = NWEndpoint.Host(host)
    let p = NWEndpoint.Port(integerLiteral: NWEndpoint.Port.IntegerLiteralType(port))
    let params: NWParameters = .udp
    params.allowLocalEndpointReuse = true
    params.allowFastOpen = true
    return NWConnection(host: h, port: p, using: params)
}

fileprivate extension Dataref {
    /// Arbitrary unique IDs to pass to X-Plane
    var id: Int {
        switch self {
        case .ThrottleRatioAll:
            return 1
        case .PropRatioAll:
            return 2
        case .MixtureRatioAll:
            return 3
        case .FlapRatio:
            return 4
        case .SpeedbrakeRatio:
            return 5
        case .GearHandleDown:
            return 6
        case .ParkingBrakeRatio:
            return 7
        case .SimSpeed:
            return 8
        case .LandingLightsOn:
            return 9
        case .StrobeLightsOn:
            return 10
        case .TaxiLightOn:
            return 11
        case .BeaconOn:
            return 12
        case .NavigationLightsOn:
            return 13
        case .HideYoke:
            return 14
        case .ViewType:
            return 15
        case .Com1Power:
            return 16
        case .Com2Power:
            return 17
        case .Nav1Power:
            return 18
        case .Nav2Power:
            return 19
        case .AudioSelectionCom1:
            return 20
        case .AudioSelectionCom2:
            return 21
        case .AudioSelectionNav1:
            return 22
        case .AudioSelectionNav2:
            return 23
        case .AudioDmeEnabled:
            return 24
        case .AudioComSelection:
            return 25
        case .AudioMarkerEnabled:
            return 26
        }
    }
}

extension Bool: CustomFloatConvertible {
    var floatValue: Float {
        if self == true {
            return 1
        }
        return 0
    }
}

extension SimSpeed: CustomFloatConvertible {
    var floatValue: Float {
        switch self {
        case .pause:
            return 0
        case .x1:
            return 1
        case .x2:
            return 2
        }
    }
}

extension Gear: CustomFloatConvertible {
    var floatValue: Float {
        switch self {
        case .up:
            return 0
        case .down:
            return 1
        }
    }
}

extension ComSelection: CustomFloatConvertible {
    var floatValue: Float {
        switch self {
        case .com1:
            return 6
        case .com2:
            return 7
        }
    }
}

extension Camera: CustomFloatConvertible {
    /// The X-Plane 7+ values for the camera angles
    /// Taken from https://www.xsquawkbox.net/xpsdk/mediawiki/Sim/graphics/view/view_type
    /// WARNING: this likely corresponds to an internal X-Plane enum, so the values may change between X-Plane versions
    var floatValue: Float {
        switch self {
        case .cockpit:
            return 1026
        case .chase:
            return 1017
        case .circle:
            return 1018
        case .hud:
            return 1023
        case .linearSpot:
            return 1021
        case .stillSpot:
            return 1020
        case .tower:
            return 1014
        case .runway:
            return 1015
        }
    }
}
