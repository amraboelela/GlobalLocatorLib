    import XCTest
    import CoreLocation
    import MapKit
    @testable import GlobalLocatorLib

    final class GlobalLocatorLibTests: XCTestCase {
        func testCodeForLocation() {
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location: CLLocationCoordinate2D(latitude: -90, longitude: -180)),
                "00"
            )
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location: CLLocationCoordinate2D(latitude: 0, longitude: 0)
                ),
                "GG"
            )
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location:
                        CLLocationCoordinate2D(
                            latitude: 90,
                            longitude: 180
                        )
                ),
                "ZZZZZZZZZZ"
            )
            // Los Angeles
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location:
                        CLLocationCoordinate2D(
                            latitude: 34.099999999999994,
                            longitude: -118.2
                        )
                ),
                "5QF1TZ5QHW"
            )
            // Washington DC
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location:
                        CLLocationCoordinate2D(
                            latitude: 38.889444444444436,
                            longitude: -77.03533333333331
                        )
                ),
                "9Q4XW72KAD"
            )
            // New York
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location:
                        CLLocationCoordinate2D(
                            latitude: 40.69999999999999,
                            longitude: -73.8
                        )
                ),
                "9RE72HH6XN"
            )
            // London
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location:
                        CLLocationCoordinate2D(
                            latitude: 51.507222,
                            longitude: -0.1275
                        )
                ),
                "FTZ5M0CKMA"
            )
            // Cairo, Egypt
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location:
                        CLLocationCoordinate2D(
                            latitude: 30.099999999999994,
                            longitude: 31.39999999999999
                        )
                ),
                "JNTBA73H46"
            )
            // Delhi, India
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location:
                        CLLocationCoordinate2D(
                            latitude: 28.69999999999999,
                            longitude: 77.39999999999998
                        )
                ),
                "QNW3583NUK"
            )
            // Beijing, China
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location:
                        CLLocationCoordinate2D(
                            latitude: 39.89999999999998,
                            longitude: 116.4
                        )
                ),
                "URB22ZZJJB"
            )
        }
        
        func testCodeForLocation1Location2() {
            // California
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location1: CLLocationCoordinate2D(latitude: 33.229, longitude: -124.362),
                    location2: CLLocationCoordinate2D(latitude: 42.520, longitude: -117.814)),
                "5Q"
            )
            // San Jose
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location1: CLLocationCoordinate2D(latitude: 37.250, longitude: -122.002),
                    location2: CLLocationCoordinate2D(latitude: 37.420, longitude: -121.797)),
                "5Q5M"
            )
            // Los Angeles
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location1: CLLocationCoordinate2D(latitude: 33.917, longitude: -118.434),
                    location2: CLLocationCoordinate2D(latitude: 34.292, longitude: -117.963)
                ),
                "5QF2"
            )
            // Florida
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location1: CLLocationCoordinate2D(latitude: 25.055, longitude: -85.275),
                    location2: CLLocationCoordinate2D(latitude: 31.042, longitude: -78.694)),
                "8M"
            )
            // Johnny Depp's Private Island
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location1: CLLocationCoordinate2D(latitude: 24.336, longitude: -76.612),
                    location2: CLLocationCoordinate2D(latitude: 24.377, longitude: -76.563)),
                "9M6A4H"
            )
            // Johnny Depp's Private Island zoom 1
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location1: CLLocationCoordinate2D(latitude: 24.344, longitude: -76.596),
                    location2: CLLocationCoordinate2D(latitude: 24.367, longitude: -76.572)),
                "9M6A5H"
            )
            // Johnny Depp's Private Island zoom 2
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location1: CLLocationCoordinate2D(latitude: 24.350, longitude: -76.588),
                    location2: CLLocationCoordinate2D(latitude: 24.362, longitude: -76.576)),
                "9M6A5H"
            )
            // Cairo, Egypt
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location1: CLLocationCoordinate2D(latitude: 29.913, longitude: 31.169),
                    location2: CLLocationCoordinate2D(latitude: 30.302, longitude: 31.638)),
                "JNTB"
            )
            // Beijing, China
            XCTAssertEqual(
                globalLocatorLib.codeFor(
                    location1: CLLocationCoordinate2D(latitude: 30.110, longitude: 119.971),
                    location2: CLLocationCoordinate2D(latitude: 30.501, longitude: 120.434)),
                "UNNC"
            )
        }
        
        static func regionFrom(
            latitude1: Double,
            longitude1: Double,
            latitude2: Double,
            longitude2: Double
        ) -> MKCoordinateRegion {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: (latitude1 + latitude2) / 2, longitude: (longitude1 + longitude2) / 2),
                span: MKCoordinateSpan(latitudeDelta: abs(latitude2 - latitude1), longitudeDelta: abs(longitude2 - longitude1)
                )
            )
        }
        
        let californiaRegion = regionFrom(
            latitude1: 33.229,
            longitude1: -124.362,
            latitude2: 42.520,
            longitude2: -117.814
        )
        let sanJoseRegion = regionFrom(
            latitude1: 37.309,
            longitude1: -121.914,
            latitude2: 37.357,
            longitude2: -121.857
        )
        let losAngelesRegion = regionFrom(
            latitude1: 33.917,
            longitude1: -118.434,
            latitude2: 34.292,
            longitude2: -117.963
        )
        let floridaRegion = regionFrom(
            latitude1: 25.055,
            longitude1: -85.275,
            latitude2: 31.042,
            longitude2: -78.694
        )
        
        let johnnyDeppRegion = regionFrom(
            latitude1: 24.336,
            longitude1: -76.612,
            latitude2: 24.377,
            longitude2: -76.563
        )
        let johnnyDeppZ1Region = regionFrom(
            latitude1: 24.344,
            longitude1: -76.596,
            latitude2: 24.367,
            longitude2: -76.572
        )
        let johnnyDeppZ2Region = regionFrom(
            latitude1: 24.350,
            longitude1: -76.588,
            latitude2: 24.362,
            longitude2: -76.576
        )
        let cairoRegion = regionFrom(
            latitude1: 29.913,
            longitude1: 31.169,
            latitude2: 30.302,
            longitude2: 31.638
        )
        let beijingRegion = regionFrom(
            latitude1: 30.110,
            longitude1: 119.971,
            latitude2: 30.501,
            longitude2: 120.434
        )
        
        func testCodeForRegion() {
            XCTAssertEqual(globalLocatorLib.codeFor(region: californiaRegion), "5Q")
            XCTAssertEqual(globalLocatorLib.codeFor(region: sanJoseRegion), "5Q5M9C")
            XCTAssertEqual(globalLocatorLib.codeFor(region: losAngelesRegion), "5QF2")
            XCTAssertEqual(globalLocatorLib.codeFor(region: floridaRegion), "8M")
            XCTAssertEqual(globalLocatorLib.codeFor(region: johnnyDeppRegion), "9M6A4H")
            XCTAssertEqual(globalLocatorLib.codeFor(region: johnnyDeppZ1Region), "9M6A5H")
            XCTAssertEqual(globalLocatorLib.codeFor(region: johnnyDeppZ2Region), "9M6A5H")
            XCTAssertEqual(globalLocatorLib.codeFor(region: cairoRegion), "JNTB")
            XCTAssertEqual(globalLocatorLib.codeFor(region: beijingRegion), "UNNC")
        }
        
        func testLocationForCode() {
            var location = globalLocatorLib.locationFor(code: "00")
            XCTAssertEqual(location.latitude, -87.1875)
            XCTAssertEqual(location.longitude, -174.375)
            location = globalLocatorLib.locationFor(code: "HH")
            XCTAssertEqual(location.latitude, 8.4375)
            XCTAssertEqual(location.longitude, 16.875)
            location = globalLocatorLib.locationFor(code: "hh")
            XCTAssertEqual(location.latitude, 8.4375)
            XCTAssertEqual(location.longitude, 16.875)
            location = globalLocatorLib.locationFor(code: "ZZZZZZZZZZ")
            XCTAssertEqual(location.latitude, 90, accuracy: 0.0001)
            XCTAssertEqual(location.longitude, 180, accuracy: 0.0001)
            // San Jose
            location = globalLocatorLib.locationFor(code: "5Q5M")
            XCTAssertEqual(location.latitude, 37.353515625, accuracy: 0.0001)
            XCTAssertEqual(location.longitude, -121.81640625, accuracy: 0.0001)
            // Washington DC
            location = globalLocatorLib.locationFor(code: "9Q4XW72KAD")
            XCTAssertEqual(location.latitude, 38.88944238424301, accuracy: 0.0001)
            XCTAssertEqual(location.longitude, -77.03533351421356, accuracy: 0.0001)
            // New York
            location = globalLocatorLib.locationFor(code: "9RE72JJ6XQ")
            XCTAssertEqual(location.latitude, 40.70549637079239, accuracy: 0.0001)
            XCTAssertEqual(location.longitude, -73.79965603351593, accuracy: 0.0001)
            // Cairo, Egypt
            location = globalLocatorLib.locationFor(code: "JNTB")
            XCTAssertEqual(location.latitude, 30.146484375, accuracy: 0.0001)
            XCTAssertEqual(location.longitude, 31.46484375, accuracy: 0.0001)
            // Delhi, India
            location = globalLocatorLib.locationFor(code: "QNW3583NUK")
            XCTAssertEqual(location.latitude, 28.699998557567596, accuracy: 0.0001)
            XCTAssertEqual(location.longitude, 77.3999959230423, accuracy: 0.0001)
            // Beijing, China
            location = globalLocatorLib.locationFor(code: "UNNC")
            XCTAssertEqual(location.latitude, 30.322265625, accuracy: 0.0001)
            XCTAssertEqual(location.longitude, 120.05859375, accuracy: 0.0001)
        }
        
        func testSpanForCode() {
            var span = globalLocatorLib.spanFor(code: "5Q")
            XCTAssertEqual(span.latitudeDelta, 11.25)
            XCTAssertEqual(span.longitudeDelta, 22.5)
            span = globalLocatorLib.spanFor(code: "5q")
            XCTAssertEqual(span.latitudeDelta, 11.25)
            XCTAssertEqual(span.longitudeDelta, 22.5)
            span = globalLocatorLib.spanFor(code: "5TQ6")
            XCTAssertEqual(span.latitudeDelta, 0.52734375)
            XCTAssertEqual(span.longitudeDelta, 1.0546875)
            span = globalLocatorLib.spanFor(code: "4T8Q6M")
            XCTAssertEqual(span.latitudeDelta, 0.02197265625, accuracy: 0.0001)
            XCTAssertEqual(span.longitudeDelta, 0.0439453125, accuracy: 0.0001)
            span = globalLocatorLib.spanFor(code: "8KDBQGFD")
            XCTAssertEqual(span.latitudeDelta, 0.0008583068, accuracy: 0.000001)
            XCTAssertEqual(span.longitudeDelta, 0.00171661376953125, accuracy: 0.000001)
            span = globalLocatorLib.spanFor(code: "54GZZNNH00")
            XCTAssertEqual(span.latitudeDelta, 0.000032186508, accuracy: 0.0000001)
            XCTAssertEqual(span.longitudeDelta, 0.00006437301, accuracy: 0.0000001)
        }
        
        func testLocationSpanRegion() {
            var gl = "GZZH"
            var region = MKCoordinateRegion(
                center: globalLocatorLib.locationFor(code: gl),
                span: globalLocatorLib.spanFor(code: gl)
            )
            var currentGL = globalLocatorLib.codeFor(region: region)
            XCTAssertEqual(gl, currentGL)
            
            gl = "GZzh"
            region = MKCoordinateRegion(
                center: globalLocatorLib.locationFor(code: gl),
                span: globalLocatorLib.spanFor(code: gl)
            )
            currentGL = globalLocatorLib.codeFor(region: region)
            XCTAssertEqual(gl.uppercased(), currentGL)
            
            gl = "4XXJJhhh"
            region = MKCoordinateRegion(
                center: globalLocatorLib.locationFor(code: gl),
                span: globalLocatorLib.spanFor(code: gl)
            )
            currentGL = globalLocatorLib.codeFor(region: region)
            XCTAssertEqual(gl.uppercased(), currentGL)
            
            gl = "4XXJJH"
            region = MKCoordinateRegion(
                center: globalLocatorLib.locationFor(code: gl),
                span: globalLocatorLib.spanFor(code: gl)
            )
            currentGL = globalLocatorLib.codeFor(region: region)
            XCTAssertEqual(gl.uppercased(), currentGL)
        }
        
        func testIsGLCode() {
            XCTAssertEqual(globalLocatorLib.isGLCode(text: "test"), true)
            XCTAssertEqual(globalLocatorLib.isGLCode(text: "test TEST"), false)
            XCTAssertEqual(globalLocatorLib.isGLCode(text: "tstTST"), true)
            XCTAssertEqual(globalLocatorLib.isGLCode(text: "TSTTST"), true)
            XCTAssertEqual(globalLocatorLib.isGLCode(text: "1231234"), false)
            XCTAssertEqual(globalLocatorLib.isGLCode(text: "4xjp6q"), false)
            XCTAssertEqual(globalLocatorLib.isGLCode(text: "4xja6q"), true)
        }
        
        func testIsAddress() {
            XCTAssertEqual(globalLocatorLib.isAddress(text: "test"), false)
            XCTAssertEqual(globalLocatorLib.isAddress(text: "123 1234"), true)
            XCTAssertEqual(globalLocatorLib.isAddress(text: "4xj p6q"), false)
            XCTAssertEqual(globalLocatorLib.isAddress(text: "Merced CA"), false)
            XCTAssertEqual(globalLocatorLib.isAddress(text: "1090 Alison St, Los Angeles  CA"), true)
        }
        
        func testRegionForQuery() {
            let startRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
            var expectation = XCTestExpectation(description: "Got query results for Munich")
            globalLocatorLib.regionFor(query: "Munich", fromRegion: startRegion) { matchingItem, resultRegion in
                XCTAssertNotNil(matchingItem)
                XCTAssertEqual(resultRegion.center.longitude, 11.575182, accuracy: 0.01)
                XCTAssertEqual(resultRegion.span.latitudeDelta, 0.1, accuracy: 0.001)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 2.0)
            expectation = XCTestExpectation(description: "Got query results for Lake Tahoe address")
            globalLocatorLib.regionFor(query: "4080 Lake Tahoe Blvd, South Lake Tahoe, CA", fromRegion: startRegion) { matchingItem, resultRegion in
                XCTAssertNotNil(matchingItem)
                XCTAssertEqual(resultRegion.center.longitude, -119.9427048, accuracy: 0.001)
                XCTAssertEqual(resultRegion.span.latitudeDelta, 0.003, accuracy: 0.001)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 2.0)
            expectation = XCTestExpectation(description: "Got query results for not found address")
            globalLocatorLib.regionFor(
                query: "1000 Weird st, NotFound AZ",
                fromRegion: startRegion
            ) { matchingItem, resultRegion in
                XCTAssertNil(matchingItem)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 2.0)
        }
        
        func testMapItemFromCode() {
            var mapItem = globalLocatorLib.mapItemFrom(code: "BBCC")
            XCTAssertEqual(
                Double(mapItem.placemark.location?.coordinate.longitude ?? 0),
                -51.85546875,
                accuracy: 0.00001
            )
            XCTAssertEqual(mapItem.name, "BBCC")
            mapItem = globalLocatorLib.mapItemFrom(code: "4VQ6")
            XCTAssertEqual(
                Double(mapItem.placemark.location?.coordinate.longitude ?? 0),
                -127.08984375,
                accuracy: 0.00001
            )
            XCTAssertEqual(mapItem.name, "4VQ6")
        }
        
        func testAnnotationForRegion() {
            var annotation = globalLocatorLib.annotationFor(
                region: californiaRegion,
                mapWidth: 400
            )
            XCTAssertEqual(
                annotation.location.longitude,
                californiaRegion.center.longitude,
                accuracy: 3
            )
            XCTAssertEqual(annotation.span, 687, accuracy: 1)
            
            annotation = globalLocatorLib.annotationFor(region: sanJoseRegion, mapWidth: 400)
            XCTAssertEqual(
                annotation.location.longitude,
                sanJoseRegion.center.longitude,
                accuracy: 1
            )
            XCTAssertEqual(annotation.span, 77, accuracy: 1)
            
            annotation = globalLocatorLib.annotationFor(region: losAngelesRegion, mapWidth: 400)
            XCTAssertEqual(
                annotation.location.longitude,
                losAngelesRegion.center.longitude,
                accuracy: 1
            )
            XCTAssertEqual(annotation.span, 298, accuracy: 1)
            
            annotation = globalLocatorLib.annotationFor(region: floridaRegion, mapWidth: 400)
            XCTAssertEqual(
                annotation.location.longitude,
                floridaRegion.center.longitude,
                accuracy: 3
            )
            XCTAssertEqual(annotation.span, 683, accuracy: 1)
            
            annotation = globalLocatorLib.annotationFor(region: johnnyDeppRegion, mapWidth: 400)
            XCTAssertEqual(
                annotation.location.longitude,
                johnnyDeppRegion.center.longitude,
                accuracy: 1
            )
            XCTAssertEqual(annotation.span, 89, accuracy: 1)
            
            annotation = globalLocatorLib.annotationFor(region: johnnyDeppZ1Region, mapWidth: 400)
            XCTAssertEqual(
                annotation.location.longitude,
                johnnyDeppZ1Region.center.longitude,
                accuracy: 1
            )
            XCTAssertEqual(annotation.span, 183, accuracy: 1)
            
            annotation = globalLocatorLib.annotationFor(region: johnnyDeppZ2Region, mapWidth: 400)
            XCTAssertEqual(
                annotation.location.longitude,
                johnnyDeppZ2Region.center.longitude,
                accuracy: 1
            )
            XCTAssertEqual(annotation.span, 366, accuracy: 1)
            
            annotation = globalLocatorLib.annotationFor(region: cairoRegion, mapWidth: 400)
            XCTAssertEqual(
                annotation.location.longitude,
                cairoRegion.center.longitude,
                accuracy: 1
            )
            XCTAssertEqual(annotation.span, 299, accuracy: 1)
            
            annotation = globalLocatorLib.annotationFor(region: beijingRegion, mapWidth: 400)
            XCTAssertEqual(
                annotation.location.longitude,
                beijingRegion.center.longitude,
                accuracy: 1
            )
            XCTAssertEqual(annotation.span, 303, accuracy: 1)
        }
        
    }
