import Foundation

/// X-Plane commands
enum Command {
    /// Toggle the map window
    case MapShowCurrent
    
    /// Autopilot altitude select or hold.
    case AutopilotAltitudeHold
    
    /// Autopilot heading-hold.
    case AutopilotHeadingHold
    
    case AutopilotApproach
    
    case AutopilotBackCourse
    
    case AutopilotNav
    
    /// Autopilot vertical speed, at current VSI.
    case AutopilotVerticalSpeed
    
    /// Autopilot VVI down.
    case AutopilotVerticalSpeedDown
    
    /// Autopilot VVI up.
    case AutopilotVerticalSpeedUp
}

extension Command: CustomStringConvertible {
    var description: String {
        switch self {
        case .MapShowCurrent:
            return "sim/map/show_current"
        case .AutopilotAltitudeHold:
            return "sim/autopilot/altitude_hold"
        case .AutopilotHeadingHold:
            return "sim/autopilot/heading"
        case .AutopilotApproach:
            return "sim/autopilot/approach"
        case .AutopilotBackCourse:
            return "sim/autopilot/back_course"
        case .AutopilotNav:
            return "sim/autopilot/NAV"
        case .AutopilotVerticalSpeed:
            return "sim/autopilot/vertical_speed"
        case .AutopilotVerticalSpeedDown:
            return "sim/autopilot/vertical_speed_down"
        case .AutopilotVerticalSpeedUp:
            return "sim/autopilot/vertical_speed_up"
        }
    }
}
