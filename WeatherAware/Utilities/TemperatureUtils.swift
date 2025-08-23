//  TemperatureUtils.swift
//  WeatherAware
//  Created by Spencer Jones on 8/15/25

import Foundation

struct TemperatureUtils {
    static func formatTemperature(_ temp: Double) -> String {
        return "\(Int(temp.rounded()))°"
    }
    
    static func formatTemperatureRange(_ min: Double, _ max: Double) -> String {
        return "\(Int(min.rounded()))° - \(Int(max.rounded()))°"
    }
    
    static func temperatureDescription(_ temp: Double) -> String {
        switch temp {
        case ..<0:
            return "Freezing"
        case 0..<10:
            return "Cold"
        case 10..<20:
            return "Cool"
        case 20..<25:
            return "Comfortable"
        case 25..<30:
            return "Warm"
        case 30..<35:
            return "Hot"
        default:
            return "Very Hot"
        }
    }
    
    static func celsiusToFahrenheit(_ celsius: Double) -> Double {
        return (celsius * 9/5) + 32
    }
    
    static func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * 5/9
    }
}
