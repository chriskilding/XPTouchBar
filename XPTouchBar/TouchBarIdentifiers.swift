import AppKit

extension NSTouchBarItem.Identifier {
    static let flaps = NSTouchBarItem.Identifier("XPTouchBar.Flaps")
    static let throttle = NSTouchBarItem.Identifier("XPTouchBar.Throttle")
    static let mixture = NSTouchBarItem.Identifier("XPTouchBar.Mixture")
    static let pitch = NSTouchBarItem.Identifier("XPTouchBar.Pitch")
    static let gear = NSTouchBarItem.Identifier("XPTouchBar.Gear")
    static let parkingBrake = NSTouchBarItem.Identifier("XPTouchBar.ParkingBrake")
}

extension NSTouchBar.CustomizationIdentifier {
    static let xpTouchBar = NSTouchBar.CustomizationIdentifier("XPTouchBar")
}
