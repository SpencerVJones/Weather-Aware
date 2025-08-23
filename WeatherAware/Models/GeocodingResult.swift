//  GeocodingResult.swift
//  WeatherAware
//  Created by Spencer Jones on 8/10/25

import Foundation

struct GeocodingResult: Codable {
    let name: String
    let localNames: [String: String]?
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    
    enum CodingKeys: String, CodingKey {
        case name, lat, lon, country, state
        case localNames = "local_names"
    }
}
