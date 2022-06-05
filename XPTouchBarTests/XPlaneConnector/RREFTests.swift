import XCTest
@testable import XPTouchBar

class RREFTests: XCTestCase {

    func testDataLength() throws {
        let rref = RREF(frequency: 1, id: 1, dataref: .ThrottleRatioAll)
        let data = rref.dataValue
        XCTAssertEqual(data.count, 413)
    }

}
