import Foundation

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
    
    /// Switch, 0 or 1.
    /// Units: boolean
    /// Since: 900+
    case BeaconOn
    
    /// Switch, 0 or 1.
    /// Units: boolean
    /// Since: 900+
    case StrobeLightsOn
    
    /// Switch, 0 or 1. This affects the first landing light.
    /// Units: boolean
    /// Since: 900+
    case LandingLightsOn
    
    /// Switch, 0 or 1.
    /// Units: boolean
    /// Since: 900+
    case TaxiLightOn
    
    /// Switch, 0 or 1.
    /// Units: boolean
    /// Since: 900+
    case NavigationLightsOn
    
    /// Cockpit light level
    /// Type: float
    /// Units: ratio
    /// Since: 660+
    case CockpitLights
    
    /// Instrument LED lighting level
    /// Type: float
    /// Units: ratio
    /// Since: 762+
    case InstrumentBrightness
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
        case .BeaconOn:
            return "sim/cockpit2/switches/beacon_on"
        case .StrobeLightsOn:
            return "sim/cockpit2/switches/strobe_lights_on"
        case .LandingLightsOn:
            return "sim/cockpit2/switches/landing_lights_on"
        case .NavigationLightsOn:
            return "sim/cockpit2/switches/navigation_lights_on"
        case .TaxiLightOn:
            return "sim/cockpit2/switches/taxi_light_on"
        case .CockpitLights:
            return "sim/cockpit/electrical/cockpit_lights"
        case .InstrumentBrightness:
            return "sim/cockpit/electrical/instrument_brightness"
        }
    }
}
