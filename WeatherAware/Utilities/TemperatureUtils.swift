//  TemperatureUtils.swift
//  WeatherAware
//  Created by Spencer Jones on 8/15/25

/*
This utility struct provides helper functions for working with temperatures.
It includes methods for formatting temperatures and temperature ranges for display,
converting between Celsius and Fahrenheit, and generating human-readable
descriptions of temperature ranges.
*/

import Foundation

struct TemperatureUtils {
    // Format a single temperature value as a string with a degree symbol and Fahrenheit unit
    /// - Parameter temp: Temperature in Fahrenheit
    /// - Returns: Formatted string, e.g., "72°F"
    static func formatTemperature(_ temp: Double) -> String {
        return "\(Int(temp.rounded()))°F"
    }
    
    /// Format a temperature range as a string with a degree symbol and Fahrenheit unit
    /// - Parameters:
    ///   - min: Minimum temperature in Fahrenheit
    ///   - max: Maximum temperature in Fahrenheit
    /// - Returns: Formatted range string, e.g., "68° - 75°F"
    static func formatTemperatureRange(_ min: Double, _ max: Double) -> String {
        return "\(Int(min.rounded()))° - \(Int(max.rounded()))°F"
    }
    
    // Provide a human-readable description of the temperature
    /// - Parameter temp: Temperature in Fahrenheit
    /// - Returns: String description such as "Cold", "Warm", or "Hot"
    static func temperatureDescription(_ temp: Double) -> String {
        switch temp {
        case ..<32: // Below freezing
            return "Freezing"
        case 32..<50: // 32-49°F
            return "Cold"
        case 50..<68: // 50-67°F
            return "Cool"
        case 68..<77: // 68-76°F
            return "Comfortable"
        case 77..<86: // 77-85°F
            return "Warm"
        case 86..<95: // 86-94°F
            return "Hot"
        default: // 95°F+
            return "Very Hot"
        }
    }
    
    // Convert a temperature from Celsius to Fahrenheit
    /// - Parameter celsius: Temperature in Celsius
    /// - Returns: Temperature in Fahrenheit
    static func celsiusToFahrenheit(_ celsius: Double) -> Double {
        return (celsius * 9/5) + 32
    }
    
    // Convert a temperature from Fahrenheit to Celsius
    /// - Parameter fahrenheit: Temperature in Fahrenheit
    /// - Returns: Temperature in Celsius
    static func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * 5/9
    }
}
