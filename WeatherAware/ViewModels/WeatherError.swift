//  WeatherError.swift
//  WeatherAware
//  Created by Spencer Jones on 8/18/25

import Foundation

enum WeatherError: LocalizedError {
    case invalidURL
    case cityNotFound
    case networkError
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .cityNotFound:
            return "City not found"
        case .networkError:
            return "Network error occurred"
        case .decodingError:
            return "Failed to decode weather data"
        }
    }
}
