//  LocationManager.swift
//  WeatherAware
//  Created by Spencer Jones on 8/24/25

/*
This class manages location services using CoreLocation.
It requests user authorization, retrieves the current location,
and reverse-geocodes the location into a city name.
 
Published properties allow SwiftUI views to reactively update when
the location or authorization status changes.
*/

import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // MARK: - Published Properties
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined // The current authorization status for location services
    @Published var lastLocation: CLLocation? // The last known location of the user
    @Published var cityName: String? // The resolved city name from the last known location
    
    // MARK: - Private Properties
    private let manager = CLLocationManager() // Core Location manager instance
    private let geocoder = CLGeocoder() // Geocoder for converting coordinates into human-readable locations
    
    // MARK: - Initialization
    override init() {
        super.init()
        manager.delegate = self
    }
    
    // MARK: - Public Methods
    // Requests location authorization or retrieves the location if already authorized
    func request() {
        if authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            manager.requestLocation()
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    // Called when the authorization status changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            manager.requestLocation()
        }
    }
    
    // Called when new location data is available
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else { return }
        lastLocation = loc
        
        // Reverse-geocode the location to determine the city name
        geocoder.reverseGeocodeLocation(loc) { [weak self] placemarks, _ in
            guard let self else { return }
            self.cityName = placemarks?.first?.locality
        }
    }
    
    // Called if location updates fail
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error:", error)
    }
}
