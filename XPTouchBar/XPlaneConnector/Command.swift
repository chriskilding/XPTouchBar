import Foundation

/// X-Plane commands
enum Command {
    /// Toggle the map window
    case MapShowCurrent
}

extension Command: CustomStringConvertible {
    var description: String {
        switch self {
        case .MapShowCurrent:
            return "sim/map/show_current"
        }
    }
}
