import Foundation
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
    
    @Published var parkingBrake: ParkingBrake = .on {
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
    
    @Published var cockpitLights: Brightness = .min {
        didSet {
            let dref = DREF(dataref: .CockpitLights, value: cockpitLights.floatValue)
            self.send(dref)
        }
    }
    
    @Published var instrumentBrightness: Brightness = .max {
        didSet {
            let dref = DREF(dataref: .InstrumentBrightness, value: instrumentBrightness.floatValue)
            self.send(dref)
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
    
    func subscribe(to dataref: Dataref, frequency: Int) {
        let rref = RREF(frequency: frequency, id: dataref.id, dataref: dataref)
        send(rref)
    }
    
    func unsubscribe(from dataref: Dataref) {
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
    
    func restart() {
        stop()
        start()
    }
    
    func send(_ dataConvertible: CustomDataConvertible) {
        let data = dataConvertible.dataValue
        send(data)
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

extension ParkingBrake: CustomFloatConvertible {
    var floatValue: Float {
        switch self {
        case .on:
            return 1
        case .off:
            return 0
        }
    }
}

extension SimSpeed: CustomFloatConvertible {
    var floatValue: Float {
        switch self {
        case .pause:
            return 0
        case .x1:
            return 1
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
