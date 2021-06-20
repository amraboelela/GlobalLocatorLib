    import XCTest
    import CoreLocation
    import MapKit
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
            XCTAssertEqual(globalLocator.codeFor(location1: CLLocationCoordinate2D(latitude: 37.250, longitude: -122.002),
                                                 location2: CLLocationCoordinate2D(latitude: 37.420, longitude: -121.797)),
                           "4T P6")
        }
        
        func testCodeForRegion() {
            // Los Angeles
            var latitude1 = 33.917
            var longitude1 = -118.434
            var latitude2 = 34.292
            var longitude2 = -117.963
            XCTAssertEqual(globalLocator.codeFor(
                region: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: (latitude1 + latitude2) / 2, longitude: (longitude1 + longitude2) / 2),
                    span: MKCoordinateSpan(latitudeDelta: abs(latitude2 - latitude1), longitudeDelta: abs(longitude2 - longitude1)
                    )
                )
            ),
            "54 NN")
            // Beijing, China
            latitude1 = 30.110
            longitude1 = 119.971
            latitude2 = 30.501
            longitude2 = 120.434
            XCTAssertEqual(globalLocator.codeFor(
                region: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: (latitude1 + latitude2) / 2, longitude: (longitude1 + longitude2) / 2),
                    span: MKCoordinateSpan(latitudeDelta: abs(latitude2 - latitude1), longitudeDelta: abs(longitude2 - longitude1)
                    )
                )
            ),
            "T0 N1")
            // Cairo, Egypt
            latitude1 = 29.913
            longitude1 = 31.169
            latitude2 = 30.302
            longitude2 = 31.638
            XCTAssertEqual(globalLocator.codeFor(
                region: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: (latitude1 + latitude2) / 2, longitude: (longitude1 + longitude2) / 2),
                    span: MKCoordinateSpan(latitudeDelta: abs(latitude2 - latitude1), longitudeDelta: abs(longitude2 - longitude1)
                    )
                )
            ),
            "KL N0")
            latitude1 = 24.336
            longitude1 = -76.612
            latitude2 = 24.377
            longitude2 = -76.563
            XCTAssertEqual(globalLocator.codeFor(
                region: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: (latitude1 + latitude2) / 2, longitude: (longitude1 + longitude2) / 2),
                    span: MKCoordinateSpan(latitudeDelta: abs(latitude2 - latitude1), longitudeDelta: abs(longitude2 - longitude1)
                    )
                )
            ),
            "8LH M1R")
            // Johnny Depp's Private Island zoom 1
            latitude1 = 24.344
            longitude1 = -76.596
            latitude2 = 24.367
            longitude2 = -76.572
            XCTAssertEqual(globalLocator.codeFor(
                region: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: (latitude1 + latitude2) / 2, longitude: (longitude1 + longitude2) / 2),
                    span: MKCoordinateSpan(latitudeDelta: abs(latitude2 - latitude1), longitudeDelta: abs(longitude2 - longitude1)
                    )
                )
            ),
            "8LJ M1R")
            // Johnny Depp's Private Island zoom 2
            latitude1 = 24.350
            longitude1 = -76.588
            latitude2 = 24.362
            longitude2 = -76.576
            XCTAssertEqual(globalLocator.codeFor(
                region: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: (latitude1 + latitude2) / 2, longitude: (longitude1 + longitude2) / 2),
                    span: MKCoordinateSpan(latitudeDelta: abs(latitude2 - latitude1), longitudeDelta: abs(longitude2 - longitude1)
                    )
                )
            ),
            "8LJ M1R")
            // State of Florida
            latitude1 = 25.055
            longitude1 = -85.275
            latitude2 = 31.042
            longitude2 = -78.694
            XCTAssertEqual(globalLocator.codeFor(
                region: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: (latitude1 + latitude2) / 2, longitude: (longitude1 + longitude2) / 2),
                    span: MKCoordinateSpan(latitudeDelta: abs(latitude2 - latitude1), longitudeDelta: abs(longitude2 - longitude1)
                    )
                )
            ),
            "8 M")
            // State of California
            latitude1 = 33.229
            longitude1 = -124.362
            latitude2 = 42.520
            longitude2 = -117.814
            XCTAssertEqual(globalLocator.codeFor(
                region: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: (latitude1 + latitude2) / 2, longitude: (longitude1 + longitude2) / 2),
                    span: MKCoordinateSpan(latitudeDelta: abs(latitude2 - latitude1), longitudeDelta: abs(longitude2 - longitude1)
                    )
                )
            ),
            "4 P")
            // City of San Jose, CA
            latitude1 = 37.309
            longitude1 = -121.914
            latitude2 = 37.357
            longitude2 = -121.857
            XCTAssertEqual(globalLocator.codeFor(
                region: MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: (latitude1 + latitude2) / 2, longitude: (longitude1 + longitude2) / 2),
                    span: MKCoordinateSpan(latitudeDelta: abs(latitude2 - latitude1), longitudeDelta: abs(longitude2 - longitude1)
                    )
                )
            ),
            "4T P6")
        }
        
        func testLocationForCode() {
            var location = globalLocator.locationFor(code: "0 0")
            XCTAssertEqual(location.latitude, -87)
            XCTAssertEqual(location.longitude, -174)
            location = globalLocator.locationFor(code: "H H")
            XCTAssertEqual(location.latitude, 3)
            XCTAssertEqual(location.longitude, 6)
            location = globalLocator.locationFor(code: "h h")
            XCTAssertEqual(location.latitude, 3)
            XCTAssertEqual(location.longitude, 6)
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
            XCTAssertEqual(span.longitudeDelta, 12.0)
            span = globalLocator.spanFor(code: "4 p")
            XCTAssertEqual(span.latitudeDelta, 12.0)
            XCTAssertEqual(span.longitudeDelta, 12.0)
            span = globalLocator.spanFor(code: "4T P6")
            XCTAssertEqual(span.latitudeDelta, 0.8)
            XCTAssertEqual(span.longitudeDelta, 0.8)
            span = globalLocator.spanFor(code: "4T8 P6M")
            XCTAssertEqual(span.latitudeDelta, 0.04, accuracy: 0.0001)
            XCTAssertEqual(span.longitudeDelta, 0.04, accuracy: 0.0001)
            span = globalLocator.spanFor(code: "8KDB PGFD")
            XCTAssertEqual(span.latitudeDelta, 0.001777, accuracy: 0.000001)
            XCTAssertEqual(span.longitudeDelta, 0.001777, accuracy: 0.000001)
            span = globalLocator.spanFor(code: "54GZZ NNH00")
            XCTAssertEqual(span.latitudeDelta, 0.00007407, accuracy: 0.0000001)
            XCTAssertEqual(span.longitudeDelta, 0.00007407, accuracy: 0.0000001)
        }
        
        func testLocationSpanRegion() {
            var gl = "GZ RK"
            var region = MKCoordinateRegion(center: globalLocator.locationFor(code: gl), span: globalLocator.spanFor(code: gl))
            var currentGL = globalLocator.codeFor(region: region)
            XCTAssertEqual(gl, currentGL)
            
            gl = "Gz rk"
            region = MKCoordinateRegion(center: globalLocator.locationFor(code: gl), span: globalLocator.spanFor(code: gl))
            currentGL = globalLocator.codeFor(region: region)
            XCTAssertEqual(gl.uppercased(), currentGL)
            
            gl = "4xjh p6q8"
            region = MKCoordinateRegion(center: globalLocator.locationFor(code: gl), span: globalLocator.spanFor(code: gl))
            currentGL = globalLocator.codeFor(region: region)
            XCTAssertEqual(gl.uppercased(), currentGL)
            
            gl = "4xj p6q"
            region = MKCoordinateRegion(center: globalLocator.locationFor(code: gl), span: globalLocator.spanFor(code: gl))
            currentGL = globalLocator.codeFor(region: region)
            XCTAssertEqual(gl.uppercased(), currentGL)
        }
        
        func testIsGLCode() {
            XCTAssertEqual(globalLocator.isGLCode(text: "test"), false)
            XCTAssertEqual(globalLocator.isGLCode(text: "test TEST"), false)
            XCTAssertEqual(globalLocator.isGLCode(text: "tst TST"), true)
            XCTAssertEqual(globalLocator.isGLCode(text: "TST TST"), true)
            XCTAssertEqual(globalLocator.isGLCode(text: "123 1234"), false)
            XCTAssertEqual(globalLocator.isGLCode(text: "4xj p6q"), true)
        }
        
        func testIsAddress() {
            XCTAssertEqual(globalLocator.isAddress(text: "test"), false)
            XCTAssertEqual(globalLocator.isAddress(text: "123 1234"), true)
            XCTAssertEqual(globalLocator.isAddress(text: "4xj p6q"), false)
            XCTAssertEqual(globalLocator.isAddress(text: "Merced CA"), false)
            XCTAssertEqual(globalLocator.isAddress(text: "1090 Alison St, Los Angeles  CA"), true)
        }
        
        func testRegionForQuery() {
            let startRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
            var expectation = XCTestExpectation(description: "Got query results for Munich")
            globalLocator.regionFor(query: "Munich", fromRegion: startRegion) { result in
                XCTAssertEqual(result.center.longitude, 11.575182, accuracy: 0.01)
                XCTAssertEqual(result.span.latitudeDelta, 0.1, accuracy: 0.01)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 2.0)
            expectation = XCTestExpectation(description: "Got query results for Lake Tahoe address")
            globalLocator.regionFor(query: "4080 Lake Tahoe Blvd, South Lake Tahoe, CA", fromRegion: startRegion) { result in
                XCTAssertEqual(result.center.longitude, -119.9427048, accuracy: 0.01)
                XCTAssertEqual(result.span.latitudeDelta, 0.01, accuracy: 0.01)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 2.0)
        }
    }
