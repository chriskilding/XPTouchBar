import Foundation
import AppKit

enum Brightness {
    case min
    case mid
    case max
}

extension Brightness {
    var next: Brightness {
        switch self {
        case .min:
            return .mid
        case .mid:
            return .max
        case .max:
            return .min
        }
    }
    
    var color: NSColor {
        switch self {
        case .min:
            return .controlColor
        case .mid:
            let base = NSColor.systemYellow.usingColorSpace(.deviceRGB)!
            return NSColor(calibratedHue: base.hueComponent, saturation: base.saturationComponent, brightness: 0.6 * base.brightnessComponent, alpha: base.alphaComponent)
        case .max:
            return .systemYellow
        }
    }
}

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
