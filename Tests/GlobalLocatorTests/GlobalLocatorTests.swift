    import XCTest
    @testable import GlobalLocator

    final class GlobalLocatorTests: XCTestCase {
        func testCodeFor() {
            XCTAssertEqual(globalLocator.codeFor(longitude: -180, latitude: -90), "0 0")
            XCTAssertEqual(globalLocator.codeFor(longitude: 0, latitude: 0), "H H")
            XCTAssertEqual(globalLocator.codeFor(longitude: 180, latitude: 90), "ZZZZZ ZZZZZ")
            XCTAssertEqual(globalLocator.codeFor(longitude: 31.39999999999999, latitude: 30.099999999999994), "KLH00 N0GZZ") // Cairo, Egypt
            XCTAssertEqual(globalLocator.codeFor(longitude: -77.03533333333331, latitude: 38.889444444444436), "8KDBH PGFDH") // Washington DC
            XCTAssertEqual(globalLocator.codeFor(longitude: 77.39999999999998 , latitude: 28.69999999999999), "PFGZZ MRGZZ") // Delhi, India
            XCTAssertEqual(globalLocator.codeFor(longitude: -73.8, latitude: 40.69999999999999), "8TGZZ PRGZZ") // New York
            XCTAssertEqual(globalLocator.codeFor(longitude: 116.4, latitude: 39.89999999999998), "SNZZZ PMGZZ") // Beijing, China
            XCTAssertEqual(globalLocator.codeFor(longitude: -118.2, latitude: 34.099999999999994), "54GZZ NNH00") // Los Angeles
            XCTAssertEqual(globalLocator.codeFor(longitude1: -118.434, latitude1: 33.917,
                                                 longitude2: -117.963, latitude2: 34.292), "54 NN")
            XCTAssertEqual(globalLocator.codeFor(longitude1: 119.971, latitude1: 30.110,
                                                 longitude2: 120.434, latitude2: 30.501), "T0 N1")
        }
    }
