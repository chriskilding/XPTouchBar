import XCTest
@testable import XPTouchBar

class BrightnessTests: XCTestCase {

    func testColorMin() throws {
        XCTAssertEqual(Brightness.min.color, NSColor.controlColor)
    }
    
    func testColorMax() throws {
        XCTAssertEqual(Brightness.max.color, NSColor.systemYellow)
    }

}
