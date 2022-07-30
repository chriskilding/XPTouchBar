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
    
    @Published private(set) var parkingBrake: Bool = true
    
    @Published private(set) var gear: Gear = .down
    
    @Published private(set) var landingLights: Bool = true
    
    @Published private(set) var strobeLights: Bool = true
    
    @Published private(set) var taxiLight: Bool = true
    
    @Published private(set) var beaconLights: Bool = true
    
    @Published private(set) var navigationLights: Bool = true
    
    @Published private(set) var camera: Camera = .cockpit
        
    @Published var com1power: Bool = true {
        didSet {
            let dref = DREF(dataref: .Com1Power, value: com1power.floatValue)
            self.send(dref)
        }
    }
    
    @Published private(set) var com1audio: Bool = true
    
    @Published var com2power: Bool = true {
        didSet {
            let dref = DREF(dataref: .Com2Power, value: com2power.floatValue)
            self.send(dref)
        }
    }
    
    @Published private(set) var com2audio: Bool = false
    
    @Published var nav1power: Bool = true {
        didSet {
            let dref = DREF(dataref: .Nav1Power, value: nav1power.floatValue)
            self.send(dref)
        }
    }
    
    @Published private(set) var nav1audio: Bool = false
    
    @Published var nav2power: Bool = true {
        didSet {
            let dref = DREF(dataref: .Nav2Power, value: nav2power.floatValue)
            self.send(dref)
        }
    }
    
    @Published private(set) var nav2audio: Bool = false
    
    @Published private(set) var dmeAudio: Bool = false
    
    @Published private(set) var comSelection: ComSelection = .com1 {
        didSet {
            // Set the corresponding COM receive button states
            // TODO remove once receiving from RREF subscription
            switch comSelection {
            case .com1:
                self.com1audio = true
                self.com2audio = false
            case .com2:
                self.com1audio = false
                self.com2audio = true
            }
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
    
    func toggleYoke() {
        let cmnd = CMND(command: .ToggleYoke)
        self.send(cmnd)
    }
    
    func toggleCom1Audio() {
        let cmnd = CMND(command: .MonitorAudioCom1)
        self.send(cmnd)
        
        self.com1audio.toggle()
    }
    
    func com1Mic() {
        let cmnd = CMND(command: .TransmitAudioCom1)
        self.send(cmnd)
        
        self.comSelection = .com1
    }
    
    func toggleCom2Audio() {
        let cmnd = CMND(command: .MonitorAudioCom2)
        self.send(cmnd)
        
        self.com2audio.toggle()
    }
    
    func com2Mic() {
        let cmnd = CMND(command: .TransmitAudioCom2)
        self.send(cmnd)
        
        self.comSelection = .com2
    }
    
    func toggleNav1Audio() {
        let cmnd = CMND(command: .MonitorAudioNav1)
        self.send(cmnd)
        
        self.nav1audio.toggle()
    }
    
    func toggleNav2Audio() {
        let cmnd = CMND(command: .MonitorAudioNav2)
        self.send(cmnd)
        
        self.nav2audio.toggle()
    }
    
    func toggleDmeAudio() {
        let cmnd = CMND(command: .MonitorAudioDme)
        self.send(cmnd)
        
        self.dmeAudio.toggle()
    }
    
    func toggleLandingGear() {
        let cmnd = CMND(command: .LandingGearToggle)
        self.send(cmnd)
        
        // Update local state
        // TODO remove once using RREF subscriptions
        self.gear.toggle()
    }
    
    func toggleParkingBrake() {
        let cmnd = CMND(command: .BrakesToggleMax)
        self.send(cmnd)
        
        self.parkingBrake.toggle()
    }
    
    func toggleBeaconLights() {
        let cmnd = CMND(command: .BeaconLightsToggle)
        self.send(cmnd)
        
        self.beaconLights.toggle()
    }
    
    func toggleLandingLights() {
        let cmnd = CMND(command: .LandingLightsToggle)
        self.send(cmnd)
        
        self.landingLights.toggle()
    }
    
    func toggleNavLights() {
        let cmnd = CMND(command: .NavLightsToggle)
        self.send(cmnd)
        
        self.navigationLights.toggle()
    }
    
    func toggleStrobeLights() {
        let cmnd = CMND(command: .StrobeLightsToggle)
        self.send(cmnd)
        
        self.strobeLights.toggle()
    }
    
    func toggleTaxiLights() {
        let cmnd = CMND(command: .TaxiLightsToggle)
        self.send(cmnd)
        
        self.taxiLight.toggle()
    }
    
    func cameraChase() {
        let cmnd = CMND(command: .Chase)
        self.send(cmnd)
        
        self.camera = .chase
    }
    
    func cameraCircle() {
        let cmnd = CMND(command: .Circle)
        self.send(cmnd)
        
        self.camera = .circle
    }
    
    func cameraCockpit() {
        let cmnd = CMND(command: .ThreeDCockpit)
        self.send(cmnd)
        
        self.camera = .cockpit
    }
    
    func cameraHud() {
        let cmnd = CMND(command: .ForwardWithHud)
        self.send(cmnd)
        
        self.camera = .hud
    }
    
    func cameraLinearSpot() {
        let cmnd = CMND(command: .LinearSpot)
        self.send(cmnd)
        
        self.camera = .linearSpot
    }
    
    func cameraStillSpot() {
        let cmnd = CMND(command: .StillSpot)
        self.send(cmnd)
        
        self.camera = .stillSpot
    }
    
    func cameraRunway() {
        let cmnd = CMND(command: .Runway)
        self.send(cmnd)
        
        self.camera = .runway
    }
    
    func cameraTower() {
        let cmnd = CMND(command: .Tower)
        self.send(cmnd)
        
        self.camera = .tower
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
