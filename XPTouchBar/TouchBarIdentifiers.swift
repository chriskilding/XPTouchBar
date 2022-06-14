import AppKit

extension NSTouchBarItem.Identifier {
    static let speedbrake = NSTouchBarItem.Identifier("XPTouchBar.Speedbrake")
    static let flaps = NSTouchBarItem.Identifier("XPTouchBar.Flaps")
    static let throttle = NSTouchBarItem.Identifier("XPTouchBar.Throttle")
    static let mixture = NSTouchBarItem.Identifier("XPTouchBar.Mixture")
    static let pitch = NSTouchBarItem.Identifier("XPTouchBar.Pitch")
    static let gear = NSTouchBarItem.Identifier("XPTouchBar.Gear")
    static let parkingBrake = NSTouchBarItem.Identifier("XPTouchBar.ParkingBrake")
    static let simSpeed = NSTouchBarItem.Identifier("XPTouchBar.SimSpeed")
    static let lights = NSTouchBarItem.Identifier("XPTouchBar.Lights")
    static let beaconLight = NSTouchBarItem.Identifier("XPTouchBar.Lights.Beacon")
    static let taxiLight = NSTouchBarItem.Identifier("XPTouchBar.Lights.Taxi")
    static let landingLights = NSTouchBarItem.Identifier("XPTouchBar.Lights.Landing")
    static let navigationLights = NSTouchBarItem.Identifier("XPTouchBar.Lights.Navigation")
    static let strobeLights = NSTouchBarItem.Identifier("XPTouchBar.Lights.Strobe")
    static let camera = NSTouchBarItem.Identifier("XPTouchBar.Camera")
}

extension NSTouchBar.CustomizationIdentifier {
    static let xpTouchBar = NSTouchBar.CustomizationIdentifier("XPTouchBar")
    static let lightsBar = NSTouchBar.CustomizationIdentifier("XPTouchBar.Lights")
}
