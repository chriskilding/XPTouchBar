import XCTest
@testable import XPTouchBar

class DREFTests: XCTestCase {

    func testDataLength() throws {
        let dref = DREF(dataref: .PropRatioAll, value: 1)
        let data = dref.dataValue
        XCTAssertEqual(data.count, 509)
    }
}
