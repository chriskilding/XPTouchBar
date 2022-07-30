import Foundation

/// X-Plane commands
enum Command {
    /// Toggle the map window
    case MapShowCurrent
    
    case LandingGearToggle
    
    case BeaconLightsToggle
    
    case LandingLightsToggle
    
    case NavLightsToggle
    
    case StrobeLightsToggle
    
    case TaxiLightsToggle
    
    case ToggleYoke
    
    case MonitorAudioCom1
    
    case MonitorAudioCom2
    
    case MonitorAudioNav1
    
    case MonitorAudioNav2
    
    case MonitorAudioDme
    
    case TransmitAudioCom1
    
    case TransmitAudioCom2
    
    case LinearSpot
    
    case StillSpot
    
    case Runway
    
    case Tower
    
    case Chase
    
    case Circle
    
    case ThreeDCockpit
    
    case ForwardWithHud
    
    /// Used as a proxy for the parking brake
    case BrakesToggleMax
}

extension Command: CustomStringConvertible {
    var description: String {
        switch self {
        case .MapShowCurrent:
            return "sim/map/show_current"
        case .LandingGearToggle:
            return "sim/flight_controls/landing_gear_toggle"
        case .BeaconLightsToggle:
            return "sim/lights/beacon_lights_toggle"
        case .LandingLightsToggle:
            return "sim/lights/landing_lights_toggle"
        case .NavLightsToggle:
            return "sim/lights/nav_lights_toggle"
        case .StrobeLightsToggle:
            return "sim/lights/strobe_lights_toggle"
        case .TaxiLightsToggle:
            return "sim/lights/taxi_lights_toggle"
        case .ToggleYoke:
            return "sim/operation/toggle_yoke"
        case .MonitorAudioCom1:
            return "sim/audio_panel/monitor_audio_com1"
        case .MonitorAudioCom2:
            return "sim/audio_panel/monitor_audio_com2"
        case .MonitorAudioNav1:
            return "sim/audio_panel/monitor_audio_nav1"
        case .MonitorAudioNav2:
            return "sim/audio_panel/monitor_audio_nav2"
        case .MonitorAudioDme:
            return "sim/audio_panel/monitor_audio_dme"
        case .LinearSpot:
            return "sim/view/linear_spot"
        case .StillSpot:
            return "sim/view/still_spot"
        case .Runway:
            return "sim/view/runway"
        case .Tower:
            return "sim/view/tower"
        case .Chase:
            return "sim/view/chase"
        case .Circle:
            return "sim/view/circle"
        case .ThreeDCockpit:
            return "sim/view/3d_cockpit_cmnd_look"
        case .ForwardWithHud:
            return "sim/view/forward_with_hud"
        case .TransmitAudioCom1:
            return "sim/audio_panel/transmit_audio_com1"
        case .TransmitAudioCom2:
            return "sim/audio_panel/transmit_audio_com2"
        case .BrakesToggleMax:
            return "sim/flight_controls/brakes_toggle_max"
        }
    }
}
