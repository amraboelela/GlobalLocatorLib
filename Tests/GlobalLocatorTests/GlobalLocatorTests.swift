    import XCTest
    @testable import GlobalLocator

    final class GlobalLocatorTests: XCTestCase {
        func testCodeFor() {
            XCTAssertEqual(globalLocator.codeFor(latitude: -90, longitude: -180), "0 0")
            XCTAssertEqual(globalLocator.codeFor(latitude: 0, longitude: 0), "H H")
            XCTAssertEqual(globalLocator.codeFor(latitude: 90, longitude: 180), "ZZZZZ ZZZZZ")
            XCTAssertEqual(globalLocator.codeFor(latitude: 30.099999999999994, longitude: 31.39999999999999), "KLH00 N0GZZ") // Cairo, Egypt
            XCTAssertEqual(globalLocator.codeFor(latitude: 38.889444444444436, longitude: -77.03533333333331), "8KDBH PGFDH") // Washington DC
            XCTAssertEqual(globalLocator.codeFor(latitude: 28.69999999999999, longitude: 77.39999999999998 ), "PFGZZ MRGZZ") // Delhi, India
            XCTAssertEqual(globalLocator.codeFor(latitude: 40.69999999999999, longitude: -73.8), "8TGZZ PRGZZ") // New York
            XCTAssertEqual(globalLocator.codeFor(latitude: 39.89999999999998, longitude: 116.4), "SNZZZ PMGZZ") // Beijing, China
            XCTAssertEqual(globalLocator.codeFor(latitude: 34.099999999999994, longitude: -118.2), "54GZZ NNH00") // Los Angeles
        }
    }
