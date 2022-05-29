import Foundation
import AppKit

enum Gear {
    case up
    case down
}

extension Gear: CustomStringConvertible {
    var description: String {
        switch self {
        case .up:
            return "Up"
        case .down:
            return "Down"
        }
    }
}

enum ParkingBrake {
    case on
    case off
}

extension ParkingBrake: CustomStringConvertible {
    var description: String {
        switch self {
        case .on:
            return "On"
        case .off:
            return "Off"
        }
    }
}

protocol Control {
    static var color: NSColor { get }
    static var name: String { get }
    static var symbol: String { get }
}

struct Speedbrake: Control {
    static let color: NSColor = .systemMint
    static let name: String = "Speedbrake"
    static let symbol: String = "S"
}

struct Pitch: Control {
    static let color: NSColor = .systemBlue
    static let name: String = "Pitch"
    static let symbol: String = "P"
}

struct Mixture: Control {
    static let color: NSColor = .systemRed
    static let name: String = "Mixture"
    static let symbol: String = "M"
}

struct Flaps: Control {
    static let color: NSColor = .systemGreen
    static let name: String = "Flaps"
    static let symbol: String = "F"
}

struct Throttle: Control {
    static let color: NSColor = .white
    static let name: String = "Throttle"
    static let symbol: String = "T"
}
