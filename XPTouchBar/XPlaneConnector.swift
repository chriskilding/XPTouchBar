import Foundation
import SwiftUI
import Network
import Combine

class XPlaneConnector: ObservableObject {
    
    @Published var throttle: Double = 0 {
        didSet {
            let dref = DREF(dataref: .ThrottleRatioAll, value: Float(throttle))
            let datagram = dref.data
            self.send(datagram)
        }
    }
    
    @Published var pitch: Double = 1 {
        didSet {
            let dref = DREF(dataref: .PropRatioAll, value: Float(pitch))
            let datagram = dref.data
            self.send(datagram)
        }
    }
    
    @Published var mixture: Double = 1 {
        didSet {
            let dref = DREF(dataref: .MixtureRatioAll, value: Float(mixture))
            let datagram = dref.data
            self.send(datagram)
        }
    }
    
    @Published var flaps: Double = 0 {
        didSet {
            let dref = DREF(dataref: .FlapRatio, value: Float(flaps))
            let datagram = dref.data
            self.send(datagram)
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
            let datagram = dref.data
            self.send(datagram)
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
            let datagram = dref.data
            self.send(datagram)
        }
    }
    
    @Published var speedbrake: Double = 0 {
        didSet {
            let dref = DREF(dataref: .SpeedbrakeRatio, value: Float(speedbrake))
            let datagram = dref.data
            self.send(datagram)
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
            let datagram = dref.data
            self.send(datagram)
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
    
    // FIXME make the setter private
    @Published var isConnected: Bool = false
    
    private var connection: NWConnection? = nil
    
    func restart() {
        stop()
        start()
    }
    
    func start() {
        let h = NWEndpoint.Host(host)
        let p = NWEndpoint.Port(integerLiteral: NWEndpoint.Port.IntegerLiteralType(port))
        connection = NWConnection(host: h, port: p, using: .udp)
        connection?.start(queue: .global())
        isConnected = true
    }
    
    func stop() {
        isConnected = false
        connection?.cancel()
    }

    func subscribe(to dataref: Dataref, handler: @escaping (Double) -> Void) {
        let id = dataref.id
        let rref = RREF(frequency: 60, id: id, dataref: dataref)
        let datagram = rref.data
        send(datagram)
    }
    
    func unsubscribe(from dataref: Dataref) {
        let id = dataref.id
        let rref = RREF(frequency: 0, id: id, dataref: dataref)
        let datagram = rref.data
        send(datagram)
    }
    
    func send(_ data: Data) {
        if let c = connection,
           c.state == .ready {
            c.send(content: data, completion: .idempotent)
        }
    }
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
        withUnsafeBytes(of: int) {
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
        }
    }
}
