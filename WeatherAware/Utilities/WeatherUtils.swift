//  WeatherUtils.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

/*
This utility struct provides helper functions to interpret and describe weather-related values.
It includes functions for UV index, wind speed, humidity, and precipitation probability,
converting numeric values into human-readable descriptions and corresponding colors for UI display.
*/

import Foundation
import SwiftUI

struct WeatherUtils {
    // Converts a UV index value into a descriptive string.
    /// - Parameter uvIndex: UV index value (0+)
    /// - Returns: A string describing the UV risk: "Low", "Moderate", "High", "Very High", or "Extreme"
    static func uvIndexDescription(_ uvIndex: Double) -> String {
        switch uvIndex {
        case 0..<3:
            return "Low"
        case 3..<6:
            return "Moderate"
        case 6..<8:
            return "High"
        case 8..<11:
            return "Very High"
        default:
            return "Extreme"
        }
    }
    
    // Maps a UV index value to a color for display in the UI.
    /// - Parameter uvIndex: UV index value (0+)
    /// - Returns: A Color representing the UV risk level
    static func uvIndexColor(_ uvIndex: Double) -> Color {
        switch uvIndex {
        case 0..<3:
            return .green
        case 3..<6:
            return .yellow
        case 6..<8:
            return .orange
        case 8..<11:
            return .red
        default:
            return .purple
        }
    }
    
    // Provides a descriptive string for wind speed in mph.
    /// - Parameter speed: Wind speed
    /// - Returns: String description such as "Calm", "Light breeze", "Moderate breeze", etc.
    static func windSpeedDescription(_ speed: Double) -> String {
        switch speed {
        case 0..<1:
            return "Calm"
        case 1..<4:
            return "Light breeze"
        case 4..<8:
            return "Moderate breeze"
        case 8..<12:
            return "Fresh breeze"
        case 12..<17:
            return "Strong breeze"
        case 17..<25:
            return "Gale"
        default:
            return "Storm"
        }
    }
    
    // Provides a descriptive string for relative humidity percentage.
    /// - Parameter humidity: Humidity percentage (0-100)
    /// - Returns: String description such as "Dry", "Comfortable", "Humid", "Very humid"
    static func humidityDescription(_ humidity: Int) -> String {
        switch humidity {
        case 0..<30:
            return "Dry"
        case 30..<60:
            return "Comfortable"
        case 60..<80:
            return "Humid"
        default:
            return "Very humid"
        }
    }
    
    // Provides a descriptive string for probability of precipitation.
    /// - Parameter pop: Probability of precipitation (0.0-1.0)
    /// - Returns: String description such as "No rain expected", "Light chance of rain", etc.
    static func precipitationDescription(_ pop: Double) -> String {
        switch pop {
        case 0..<0.1:
            return "No rain expected"
        case 0.1..<0.3:
            return "Light chance of rain"
        case 0.3..<0.6:
            return "Moderate chance of rain"
        case 0.6..<0.8:
            return "High chance of rain"
        default:
            return "Rain very likely"
        }
    }
}
