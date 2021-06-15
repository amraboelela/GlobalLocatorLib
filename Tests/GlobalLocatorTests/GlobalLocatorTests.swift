    import XCTest
    @testable import GlobalLocator

    final class GlobalLocatorTests: XCTestCase {
        func testCodeForLocation() {
            XCTAssertEqual(globalLocator.codeFor(location: CLLocationCoordinate2D(latitude: -90, longitude: -180)),
                           "0 0")
            XCTAssertEqual(globalLocator.codeFor(location: CLLocationCoordinate2D(latitude: 0, longitude: 0)),
                           "H H")
            XCTAssertEqual(globalLocator.codeFor(location: CLLocationCoordinate2D(latitude: 90, longitude: 180)),
                           "ZZZZZ ZZZZZ")
            XCTAssertEqual(globalLocator.codeFor(location: CLLocationCoordinate2D(latitude: 30.099999999999994, longitude: 31.39999999999999)),
                           "KLH00 N0GZZ") // Cairo, Egypt
            XCTAssertEqual(globalLocator.codeFor(location: CLLocationCoordinate2D(latitude: 38.889444444444436, longitude: -77.03533333333331)),
                           "8KDBH PGFDH") // Washington DC
            XCTAssertEqual(globalLocator.codeFor(location: CLLocationCoordinate2D(latitude: 28.69999999999999, longitude: 77.39999999999998)),
                           "PFGZZ MRGZZ") // Delhi, India
            XCTAssertEqual(globalLocator.codeFor(location: CLLocationCoordinate2D(latitude: 40.69999999999999, longitude: -73.8)),
                           "8TGZZ PRGZZ") // New York
            XCTAssertEqual(globalLocator.codeFor(location: CLLocationCoordinate2D(latitude: 39.89999999999998, longitude: 116.4)),
                           "SNZZZ PMGZZ") // Beijing, China
            XCTAssertEqual(globalLocator.codeFor(location: CLLocationCoordinate2D(latitude: 34.099999999999994, longitude: -118.2)),
                           "54GZZ NNH00") // Los Angeles
            XCTAssertEqual(globalLocator.codeFor(location: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
                           "GZNF3 RKJ2G") // London
            
        }
        
        func testCodeForLocation1Location2() {
            // Los Angeles
            XCTAssertEqual(globalLocator.codeFor(location1: CLLocationCoordinate2D(latitude: 33.917, longitude: -118.434),
                                                 location2: CLLocationCoordinate2D(latitude: 34.292, longitude: -117.963)),
                           "54 NN")
            // Beijing, China
            XCTAssertEqual(globalLocator.codeFor(location1: CLLocationCoordinate2D(latitude: 30.110, longitude: 119.971),
                                                 location2: CLLocationCoordinate2D(latitude: 30.501, longitude: 120.434)),
                           "T0 N1")
            // Cairo, Egypt
            XCTAssertEqual(globalLocator.codeFor(location1: CLLocationCoordinate2D(latitude: 29.913, longitude: 31.169),
                                                 location2: CLLocationCoordinate2D(latitude: 30.302, longitude: 31.638)),
                           "KL N0")
            // Johnny Depp's Private Island
            XCTAssertEqual(globalLocator.codeFor(location1: CLLocationCoordinate2D(latitude: 24.336, longitude: -76.612),
                                                 location2: CLLocationCoordinate2D(latitude: 24.377, longitude: -76.563)),
                           "8LH M1R")
            // Johnny Depp's Private Island zoom 1
            XCTAssertEqual(globalLocator.codeFor(location1: CLLocationCoordinate2D(latitude: 24.344, longitude: -76.596),
                                                 location2: CLLocationCoordinate2D(latitude: 24.367, longitude: -76.572)),
                           "8LJ M1R")
            // Johnny Depp's Private Island zoom 2
            XCTAssertEqual(globalLocator.codeFor(location1: CLLocationCoordinate2D(latitude: 24.350, longitude: -76.588),
                                                 location2: CLLocationCoordinate2D(latitude: 24.362, longitude: -76.576)),
                           "8LJ M1R")
            // State of Florida
            XCTAssertEqual(globalLocator.codeFor(location1: CLLocationCoordinate2D(latitude: 25.055, longitude: -85.275),
                                                 location2: CLLocationCoordinate2D(latitude: 31.042, longitude: -78.694)),
                           "8 M")
            // State of California
            XCTAssertEqual(globalLocator.codeFor(location1: CLLocationCoordinate2D(latitude: 33.229, longitude: -124.362),
                                                 location2: CLLocationCoordinate2D(latitude: 42.520, longitude: -117.814)),
                           "4 P")
            // City of San Jose, CA
            XCTAssertEqual(globalLocator.codeFor(location1: CLLocationCoordinate2D(latitude: 37.309, longitude: -121.914),
                                                 location2: CLLocationCoordinate2D(latitude: 37.357, longitude: -121.857)),
                           "4T8 P6M")
        }
        
        func testLocationForCode() {
            var location = globalLocator.locationFor(code: "0 0")
            XCTAssertEqual(location.latitude, -90)
            XCTAssertEqual(location.longitude, -180)
            location = globalLocator.locationFor(code: "H H")
            XCTAssertEqual(location.latitude, 0)
            XCTAssertEqual(location.longitude, 0)
            location = globalLocator.locationFor(code: "ZZZZZ ZZZZZ")
            XCTAssertEqual(location.latitude, 90, accuracy: 0.0001)
            XCTAssertEqual(location.longitude, 180, accuracy: 0.0001)
            // Cairo, Egypt
            location = globalLocator.locationFor(code: "KLH00 N0GZZ")
            XCTAssertEqual(location.latitude, 30.099999999999994, accuracy: 0.0001)
            XCTAssertEqual(location.longitude, 31.39999999999999, accuracy: 0.0001)
            // Washington DC
            location = globalLocator.locationFor(code: "8KDBH PGFDH")
            XCTAssertEqual(location.latitude, 38.889444444444436, accuracy: 0.0001)
            XCTAssertEqual(location.longitude, -77.03533333333331, accuracy: 0.0001)
            // Delhi, India
            location = globalLocator.locationFor(code: "PFGZZ MRGZZ")
            XCTAssertEqual(location.latitude, 28.69999999999999, accuracy: 0.0001)
            XCTAssertEqual(location.longitude, 77.39999999999998, accuracy: 0.0001)
            // New York
            location = globalLocator.locationFor(code: "8TGZZ PRGZZ")
            XCTAssertEqual(location.latitude, 40.69999999999999, accuracy: 0.0001)
            XCTAssertEqual(location.longitude, -73.8, accuracy: 0.0001)
            // Beijing, China
            location = globalLocator.locationFor(code: "SNZZZ PMGZZ")
            XCTAssertEqual(location.latitude, 39.89999999999998, accuracy: 0.0001)
            XCTAssertEqual(location.longitude, 116.4, accuracy: 0.0001)
            // Los Angeles
            location = globalLocator.locationFor(code: "54GZZ NNH00")
            XCTAssertEqual(location.latitude, 34.099999999999994, accuracy: 0.0001)
            XCTAssertEqual(location.longitude, -118.2, accuracy: 0.0001)
        }
        
        func testSpanForCode() {
            var span = globalLocator.spanFor(code: "4 P")
            XCTAssertEqual(span.latitudeDelta, 12.0)
            XCTAssertEqual(span.longitudeDelta, 24.0)
            span = globalLocator.spanFor(code: "4T P6")
            XCTAssertEqual(span.latitudeDelta, 0.4)
            XCTAssertEqual(span.longitudeDelta, 0.8)
            span = globalLocator.spanFor(code: "4T8 P6M")
            XCTAssertEqual(span.latitudeDelta, 0.0133, accuracy: 0.0001)
            XCTAssertEqual(span.longitudeDelta, 0.0266, accuracy: 0.0001)
            span = globalLocator.spanFor(code: "8KDB PGFD")
            XCTAssertEqual(span.latitudeDelta, 0.000444, accuracy: 0.000001)
            XCTAssertEqual(span.longitudeDelta, 0.000888, accuracy: 0.000001)
            span = globalLocator.spanFor(code: "54GZZ NNH00")
            XCTAssertEqual(span.latitudeDelta, 0.0000148, accuracy: 0.0000001)
            XCTAssertEqual(span.longitudeDelta, 0.0000296, accuracy: 0.0000001)
        }
    }
