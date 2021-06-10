    import XCTest
    @testable import GlobalLocator

    final class GlobalLocatorTests: XCTestCase {
        func testExample() {
            XCTAssertEqual(globalLocator.codeFor(latitude: -180, logitude: -180), "0 0")
            XCTAssertEqual(globalLocator.codeFor(latitude: 0, logitude: 0), "H H")
            XCTAssertEqual(globalLocator.codeFor(latitude: 180, logitude: 180), "Z Z")
            XCTAssertEqual(globalLocator.codeFor(latitude: 30.099999999999994, logitude: 31.39999999999999), "KLH00 N0GZZ")
        }
    }
