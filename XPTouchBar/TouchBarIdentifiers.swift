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
    static let radios = NSTouchBarItem.Identifier("XPTouchBar.Radios")
    static let com1 = NSTouchBarItem.Identifier("XPTouchBar.Radios.COM1")
    static let com2 = NSTouchBarItem.Identifier("XPTouchBar.Radios.COM2")
    static let nav1 = NSTouchBarItem.Identifier("XPTouchBar.Radios.NAV1")
    static let nav2 = NSTouchBarItem.Identifier("XPTouchBar.Radios.NAV2")
    static let dme = NSTouchBarItem.Identifier("XPTouchBar.Radios.DME")
    static let com1Mic = NSTouchBarItem.Identifier("XPTouchBar.Radios.COM1Mic")
    static let com2Mic = NSTouchBarItem.Identifier("XPTouchBar.Radios.COM2Mic")
}

extension NSTouchBar.CustomizationIdentifier {
    static let xpTouchBar = NSTouchBar.CustomizationIdentifier("XPTouchBar")
    static let lightsBar = NSTouchBar.CustomizationIdentifier("XPTouchBar.Lights")
    static let radiosBar = NSTouchBar.CustomizationIdentifier("XPTouchBar.Radios")
}
