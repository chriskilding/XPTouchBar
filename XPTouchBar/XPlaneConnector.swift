import Foundation
import SwiftUI
import Network
import Combine

class XPlaneConnector: ObservableObject {
    
    @Published var throttle: Double = 0 {
        didSet {
            let dref = DREF(dataref: .ThrottleRatioAll, value: Float(throttle))
            self.send(dref.data)
        }
    }
    
    @Published var pitch: Double = 1 {
        didSet {
            let dref = DREF(dataref: .PropRatioAll, value: Float(pitch))
            self.send(dref.data)
        }
    }
    
    @Published var mixture: Double = 1 {
        didSet {
            let dref = DREF(dataref: .MixtureRatioAll, value: Float(mixture))
            self.send(dref.data)
        }
    }
    
    @Published var flaps: Double = 0 {
        didSet {
            let dref = DREF(dataref: .FlapRatio, value: Float(flaps))
            self.send(dref.data)
        }
    }
    
    @Published var gear: Gear = .down {
        didSet {
            let value: Float
            switch gear {
            case .up:
                value = 0
            case .down:
                value = 1
            }
            let dref = DREF(dataref: .GearHandleDown, value: value)
            self.send(dref.data)
        }
    }
    
    @Published var parkingBrake: ParkingBrake = .on {
        didSet {
            let value: Float
            switch parkingBrake {
            case .on:
                value = 1
            case .off:
                value = 0
            }
            let dref = DREF(dataref: .ParkingBrakeRatio, value: value)
            self.send(dref.data)
        }
    }
    
    @Published var speedbrake: Double = 0 {
        didSet {
            let dref = DREF(dataref: .SpeedbrakeRatio, value: Float(speedbrake))
            self.send(dref.data)
        }
    }
    
    @Published var simSpeed: SimSpeed = .play {
        didSet {
            let value: Float
            switch simSpeed {
            case .play:
                value = 1
            case .pause:
                value = 0
            }
            let dref = DREF(dataref: .SimSpeed, value: value)
            self.send(dref.data)
        }
    }
    
    @Published var landingLights: Bool = true {
        didSet {
            let dref = DREF(dataref: .LandingLightsOn, value: landingLights.floatValue)
            self.send(dref.data)
        }
    }
    
    @Published var strobeLights: Bool = true {
        didSet {
            let dref = DREF(dataref: .StrobeLightsOn, value: strobeLights.floatValue)
            self.send(dref.data)
        }
    }
    
    @Published var taxiLight: Bool = true {
        didSet {
            let dref = DREF(dataref: .TaxiLightOn, value: taxiLight.floatValue)
            self.send(dref.data)
        }
    }
    
    @Published var beaconLights: Bool = true {
        didSet {
            let dref = DREF(dataref: .BeaconOn, value: beaconLights.floatValue)
            self.send(dref.data)
        }
    }
    
    @Published var navigationLights: Bool = true {
        didSet {
            let dref = DREF(dataref: .NavigationLightsOn, value: navigationLights.floatValue)
            self.send(dref.data)
        }
    }
    
    @Published var cockpitLights: Brightness = .min {
        didSet {
            let dref = DREF(dataref: .CockpitLights, value: cockpitLights.floatValue)
            self.send(dref.data)
        }
    }
    
    @Published var instrumentBrightness: Brightness = .max {
        didSet {
            let dref = DREF(dataref: .InstrumentBrightness, value: instrumentBrightness.floatValue)
            self.send(dref.data)
        }
    }
    
    @Published var host: String = "127.0.0.1" {
        didSet {
            restart()
        }
    }
    
    @Published var port: Int = 49000 {
        didSet {
            restart()
        }
    }
    
    func subscribe(to datarefs: [Dataref]) {
        for dataref in datarefs {
            subscribe(to: dataref)
        }
    }
    
    func subscribe(to dataref: Dataref) {
        let id = dataref.id
        let rref = RREF(frequency: 10, id: id, dataref: dataref)
        let datagram = rref.data
        send(datagram)
    }
    
    func unsubscribe(from dataref: Dataref) {
        let id = dataref.id
        let rref = RREF(frequency: 0, id: id, dataref: dataref)
        let datagram = rref.data
        send(datagram)
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
                NSLog("XPlane UDP connection ready")
            default:
                break
            }
        }
        connection?.start(queue: .global())
    }
    
    func stop() {
        connection?.cancel()
    }
    
    func restart() {
        stop()
        start()
    }
    
    func send(_ data: Data) {
        connection?.send(content: data, completion: .idempotent)
    }
}

func udpConnection(host: String, port: Int) -> NWConnection {
    let h = NWEndpoint.Host(host)
    let p = NWEndpoint.Port(integerLiteral: NWEndpoint.Port.IntegerLiteralType(port))
    let params: NWParameters = .udp
    params.allowLocalEndpointReuse = true
    params.allowFastOpen = true
    return NWConnection(host: h, port: p, using: params)
}

protocol CustomDataConvertible {
    var data: Data { get }
}

struct RREF {
    let frequency: Int
    let id: Int
    let dataref: Dataref
}

extension RREF: CustomDataConvertible {
    var data: Data {
        let dg = XPDatagramBuilder()

        dg.append("RREF")
        dg.append(self.frequency)
        dg.append(self.id)
        dg.append(self.dataref.description)
        dg.fillTo(count: 413)
        
        return dg.data
    }
}

struct DREF {
    let dataref: Dataref
    let value: Float
}

extension DREF: CustomDataConvertible {
    var data: Data {
        let dg = XPDatagramBuilder()
        
        dg.append("DREF")
        dg.append(self.value)
        dg.append(self.dataref.description)
        dg.fillTo(count: 509)
        
        return dg.data
    }
}

class XPDatagramBuilder {
    var data = Data()
    
    func append(_ str: String) {
        for c in str {
            data.append(c.asciiValue!)
        }
        data.append(0x00)
    }
    
    func append(_ int: Int) {
        /// X-Plane ints are 4 byte
        withUnsafeBytes(of: UInt32(int)) {
            data.append(contentsOf: $0)
        }
    }
    
    func append(_ float: Float) {
        withUnsafeBytes(of: float) {
            data.append(contentsOf: $0)
        }
    }
    
    func fillTo(count: Int, filler: UInt8 = 0x00) {
        for _ in data.count..<count {
            data.append(filler)
        }
    }
}


/// X-Plane datarefs
enum Dataref {
    /// Throttle position of the handle itself – this controls all the handles at once.
    /// Type: float
    /// Writeable: yes
    /// Units: ratio
    /// Since: 930+
    case ThrottleRatioAll
    
    /// Prop handle position, in ratio. This controls all handles at once. NOTE: This is also used for helicopter collective!
    /// Type: float
    /// Writeable: yes
    /// Units: ratio
    /// Since: 1050+
    case PropRatioAll
    
    /// Mixture handle position, this controls all at once.
    /// Type: float
    /// Writeable: yes
    /// Units: ratio
    /// Since: 930+
    case MixtureRatioAll
    
    /// This is the flap HANDLE location, in ratio, where 0.0 is handle fully retracted, and 1.0 is handle fully extended.
    /// Type: float
    /// Writeable: yes
    /// Units: ratio
    /// Since: 900+
    case FlapRatio
    
    /// This is how much the speebrake HANDLE is deflected, in ratio, where 0.0 is fully retracted, 0.5 is halfway down, and 1.0 is fully down, and -0.5 is speedbrakes ARMED.
    /// Type: float
    /// Writeable: yes
    /// Units: ratio
    /// Since: 900+
    case SpeedbrakeRatio
    
    case GearHandleDown
    
    /// This is the overall brake requested by the parking brake button… 0.0 is none, 1.0 is complete.
    /// Type: float
    /// Units: ratio
    /// Since: 900+
    case ParkingBrakeRatio
    
    /// This is the multiplier for real-time…1 = realtime, 2 = 2x, 0 = paused, etc.
    /// Type: int
    /// Units: ratio
    /// Since: 860+
    case SimSpeed
    
    case BeaconOn
    
    case StrobeLightsOn
    
    case LandingLightsOn
    
    case TaxiLightOn
    
    case NavigationLightsOn
    
    /// Cockpit light level
    /// Type: float
    /// Units: ratio
    /// Since: 660+
    case CockpitLights
    
    /// Instrument LED lighting level
    case InstrumentBrightness
}

extension Dataref: CustomStringConvertible {
    /// Dataref string to pass to X-Plane
    var description: String {
        switch self {
        case .ThrottleRatioAll:
            return "sim/cockpit2/engine/actuators/throttle_ratio_all"
        case .PropRatioAll:
            return "sim/cockpit2/engine/actuators/prop_ratio_all"
        case .MixtureRatioAll:
            return "sim/cockpit2/engine/actuators/mixture_ratio_all"
        case .FlapRatio:
            return "sim/cockpit2/controls/flap_ratio"
        case .SpeedbrakeRatio:
            return "sim/cockpit2/controls/speedbrake_ratio"
        case .GearHandleDown:
            return "sim/cockpit2/controls/gear_handle_down"
        case .ParkingBrakeRatio:
            return "sim/cockpit2/controls/parking_brake_ratio"
        case .SimSpeed:
            return "sim/time/sim_speed"
        case .BeaconOn:
            return "sim/cockpit2/switches/beacon_on"
        case .StrobeLightsOn:
            return "sim/cockpit2/switches/strobe_lights_on"
        case .LandingLightsOn:
            return "sim/cockpit2/switches/landing_lights_on"
        case .NavigationLightsOn:
            return "sim/cockpit2/switches/navigation_lights_on"
        case .TaxiLightOn:
            return "sim/cockpit2/switches/taxi_light_on"
        case .CockpitLights:
            return "sim/cockpit/electrical/cockpit_lights"
        case .InstrumentBrightness:
            return "sim/cockpit/electrical/instrument_brightness"
        }
    }
}

extension Dataref {
    /// Unique ID to pass to X-Plane
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
        case .CockpitLights:
            return 14
        case .InstrumentBrightness:
            return 15
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

extension Brightness: CustomFloatConvertible {
    var floatValue: Float {
        switch self {
        case .min:
            return 0
        case .mid:
            return 0.5
        case .max:
            return 1
        }
    }
}


protocol CustomFloatConvertible {
    var floatValue: Float { get }
}
