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
            
            // Los Angeles
            XCTAssertEqual(globalLocator.codeFor(longitude1: -118.434, latitude1: 33.917,
                                                 longitude2: -117.963, latitude2: 34.292), "54 NN")
            // Beijing, China
            XCTAssertEqual(globalLocator.codeFor(longitude1: 119.971, latitude1: 30.110,
                                                 longitude2: 120.434, latitude2: 30.501), "T0 N1")
            // Cairo, Egypt
            XCTAssertEqual(globalLocator.codeFor(longitude1: 31.169, latitude1: 29.913,
                                                 longitude2: 31.638, latitude2: 30.302), "KL N0")
            // Johnny Depp's Private Island
            XCTAssertEqual(globalLocator.codeFor(longitude1: -76.612, latitude1: 24.336,
                                                 longitude2: -76.563, latitude2: 24.377), "8LH M1R")
            // Johnny Depp's Private Island zoom 1
            XCTAssertEqual(globalLocator.codeFor(longitude1: -76.596, latitude1: 24.344,
                                                 longitude2: -76.572, latitude2: 24.367), "8LJ M1R")
            // Johnny Depp's Private Island zoom 2
            XCTAssertEqual(globalLocator.codeFor(longitude1: -76.588, latitude1: 24.350,
                                                 longitude2: -76.576, latitude2: 24.362), "8LJ M1R")
            // State of Florida
            XCTAssertEqual(globalLocator.codeFor(longitude1: -85.275, latitude1: 25.055,
                                                 longitude2: -78.694, latitude2: 31.042), "8 M")
            // State of California
            XCTAssertEqual(globalLocator.codeFor(longitude1: -124.362, latitude1: 33.229,
                                                 longitude2: -117.814, latitude2: 42.520), "4 P")
        }
    }
