//  WeatherError.swift
//  WeatherAware
//  Created by Spencer Jones on 8/18/25

/*
Defines an enum representing possible errors that can occur when fetching or
processing weather data. Conforms to LocalizedError to provide user-friendly
error descriptions.
*/

import Foundation

// Enum representing errors that may occur in weather-related network or data operations
enum WeatherError: LocalizedError {
    case invalidURL // Error when the API URL is invalid
    case cityNotFound // Error when the specified city cannot be found
    case networkError // Error when a network request fails
    case decodingError // Error when decoding weather data from the API fails
    
    // Provides a user-friendly description of each error
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
