//  GeocodingResult.swift
//  WeatherAware
//  Created by Spencer Jones on 8/10/25

/*
Represents a location result returned by a geocoding API.
Stores the place name, optional localized names, coordinates, country, and optional state.
*/

import Foundation

struct GeocodingResult: Codable {
    let name: String // Name of the location (e.g., "San Francisco")
    let localNames: [String: String]? // Dictionary of localized names keyed by language code (e.g., ["en": "San Francisco", "es": "San Francisco"])
    let lat: Double // Latitude of the location
    let lon: Double // Longitude of the location
    let country: String // Country code of the location (e.g., "US")
    let state: String? // Optional state or region (e.g., "California")
    
    // MARK: - Coding Keys
    // Maps JSON keys to Swift property names, handling snake_case for `local_names`
    enum CodingKeys: String, CodingKey {
        case name, lat, lon, country, state
        case localNames = "local_names" // Map JSON "local_names" to `localNames`
    }
}
