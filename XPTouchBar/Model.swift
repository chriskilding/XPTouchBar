import AppKit

enum Camera {
    case cockpit
    case chase
    case circle
    case hud
    case linearSpot
    case runway
    case stillSpot
    case tower
}

enum SimSpeed {
    case pause
    case x1
    case x2
}

extension SimSpeed: Toggleable {
    mutating func toggle() {
        switch self {
        case .pause:
            self = .x1
        default:
            self = .pause
        }
    }
}

enum Gear {
    case up
    case down
}

extension Gear: Toggleable {
    mutating func toggle() {
        switch self {
        case .up:
            self = .down
        case .down:
            self = .up
        }
    }
}
