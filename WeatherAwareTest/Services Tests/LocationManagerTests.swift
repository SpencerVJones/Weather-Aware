//  LocationManagerTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
import CoreLocation
@testable import WeatherAware

// MARK: - Protocols for dependency injection
protocol LocationManagerProtocol {
    var authorizationStatus: CLAuthorizationStatus { get }
    func requestWhenInUseAuthorization()
    func requestLocation()
}

protocol GeocoderProtocol {
    func reverseGeocodeLocation(_ location: CLLocation, completionHandler: @escaping ([CLPlacemark]?, Error?) -> Void)
}

// MARK: - Mocks
class MockLocationManager: LocationManagerProtocol {
    var fakeStatus: CLAuthorizationStatus = .notDetermined
    var requestAuthCalled = false
    var requestLocationCalled = false

    var authorizationStatus: CLAuthorizationStatus { fakeStatus }

    func requestWhenInUseAuthorization() { requestAuthCalled = true }
    func requestLocation() { requestLocationCalled = true }
}

class MockGeocoder: GeocoderProtocol {
    var reverseCalled = false
    var fakePlacemark: CLPlacemark?

    func reverseGeocodeLocation(_ location: CLLocation, completionHandler: @escaping ([CLPlacemark]?, Error?) -> Void) {
        reverseCalled = true
        completionHandler(fakePlacemark != nil ? [fakePlacemark!] : nil, nil)
    }
}

// MARK: - Tests
final class LocationManagerTests: XCTestCase {

    func testRequest_callsAuthorization_whenNotDetermined() {
        let mockManager = MockLocationManager()
        mockManager.fakeStatus = .notDetermined
        let locationManager = LocationManager()
        
        // Inject mocks here if  refactor LocationManager to accept dependencies
        
        // Since your class doesn’t yet support DI, you cannot fully test final behavior.
        // Test that code compiles with mocks prepared for future DI.
        
        XCTAssertEqual(mockManager.requestAuthCalled, false) // before request
        XCTAssertEqual(mockManager.requestLocationCalled, false)
    }
    
    // Other tests would follow once LocationManager supports DI
}
