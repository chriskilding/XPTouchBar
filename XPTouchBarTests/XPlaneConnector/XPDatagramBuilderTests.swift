import XCTest
@testable import XPTouchBar

class XPDatagramBuilderTests: XCTestCase {

    func testAppendFloat() {
        let builder = XPDatagramBuilder()
        builder.append(1)
        XCTAssertEqual(builder.data, Data([0x00, 0x00, 128, 63]))
    }
    
    func testAppendString() {
        let builder = XPDatagramBuilder()
        builder.append("AB")
        XCTAssertEqual(builder.data, Data([0x41, 0x42, 0x00]))
    }
    
    func testFillTo() throws {
        let builder = XPDatagramBuilder()
        builder.fillTo(count: 4)
        XCTAssertEqual(builder.data, Data([0x00, 0x00, 0x00, 0x00]))
    }
    
    func testFillToWithFiller() throws {
        let builder = XPDatagramBuilder()
        builder.fillTo(count: 4, filler: 0x02)
        XCTAssertEqual(builder.data, Data([0x02, 0x02, 0x02, 0x02]))
    }

}
