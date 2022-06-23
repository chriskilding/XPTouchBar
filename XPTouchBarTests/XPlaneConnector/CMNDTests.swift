import XCTest
@testable import XPTouchBar

class CMNDTests: XCTestCase {

    func testDataLength() throws {
        let command = Command.MapShowCurrent
        
        let cmnd = CMND(command: command)
        let data = cmnd.dataValue
        
        XCTAssertEqual(data.count, 4 + command.description.lengthOfBytes(using: .utf8))
    }
}

