import Foundation

/// X-Plane commands
enum Command {
    /// Toggle the map window
    case MapShowCurrent
    
    case GliderAllRelease
    
    case GliderTowLeft
    case GliderTowStraight
    case GliderTowRight
}

extension Command: CustomStringConvertible {
    var description: String {
        switch self {
        case .MapShowCurrent:
            return "sim/map/show_current"
        case .GliderAllRelease:
            return "sim/flight_controls/glider_all_release"
        case .GliderTowLeft:
            return "sim/flight_controls/glider_tow_left"
        case .GliderTowStraight:
            return "sim/flight_controls/glider_tow_straight"
        case .GliderTowRight:
            return "sim/flight_controls/glider_tow_right"
        }
    }
}
