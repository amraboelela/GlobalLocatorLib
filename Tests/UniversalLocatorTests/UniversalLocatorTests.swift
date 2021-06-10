    import XCTest
    @testable import UniversalLocator

    final class UniversalLocatorTests: XCTestCase {
        func testExample() {
            XCTAssertEqual(universalLocator.codeFor(latitude: -180, logitude: -180), "0 0")
            XCTAssertEqual(universalLocator.codeFor(latitude: 0, logitude: 0), "H H")
            XCTAssertEqual(universalLocator.codeFor(latitude: 180, logitude: 180), "Z Z")
            XCTAssertEqual(universalLocator.codeFor(latitude: 30.099999999999994, logitude: 31.39999999999999), "KLH00 N0GZZ")
        }
    }
