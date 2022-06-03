import Foundation
import AppKit

enum SimSpeed {
    case pause
    case x1
}

extension SimSpeed {
    var opposite: SimSpeed {
        switch self {
        case .pause:
            return .x1
        case .x1:
            return .pause
        }
    }
}

enum Gear {
    case up
    case down
}

extension Gear {
    var opposite: Gear {
        switch self {
        case .up:
            return .down
        case .down:
            return .up
        }
    }
}

enum ParkingBrake {
    case on
    case off
}

extension ParkingBrake {
    var opposite: ParkingBrake {
        switch self {
        case .on:
            return .off
        case .off:
            return .on
        }
    }
}
