    import XCTest
    @testable import UniversalLocator

    final class UniversalLocatorTests: XCTestCase {
        func testExample() {
            XCTAssertEqual(universalLocator.codeFor(latitude: -180, longitude: -90), "0 0")
            XCTAssertEqual(universalLocator.codeFor(latitude: 0, longitude: 0), "H H")
            XCTAssertEqual(universalLocator.codeFor(latitude: 180, longitude: 90), "ZZZZZ ZZZZZ")
            XCTAssertEqual(universalLocator.codeFor(latitude: 50.46944444444445, longitude: -104.68244444444444), "688SH RDBDG")
            //XCTAssertEqual(universalLocator.codeFor(latitude: 30.099999999999994, logitude: 31.39999999999999), "KLH00 N0GZZ")
        }
    }
