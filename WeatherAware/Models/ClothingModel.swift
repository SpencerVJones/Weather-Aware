//  ClothingModel.swift
//  WeatherAware
//  Created by Spencer Jones on 8/10/25

/*
Represents a single clothing item with metadata for temperature, weather, occasion, color, and layering.
Conforms to `Codable` for persistence and `Identifiable` for SwiftUI lists.
*/

import Foundation

struct ClothingItem: Codable, Identifiable {
    let id = UUID() // Unique identifier for the item
    var name: String // Name of the clothing item (e.g., "Blue Jacket")
    var type: ClothingType // Type of clothing (top, bottom, outerwear, shoes, accessory)
    var minTemp: Double // Minimum suitable temperature for the item
    var maxTemp: Double // Maximum suitable temperature for the item
    var weatherTypes: [WeatherType] // Weather types this clothing item is suitable for (e.g., sunny, rainy)
    var occasion: Occasion // Occasion the item is intended for (e.g., casual, formal)
    var color: String // Color of the item
    var isLayerable: Bool // Whether the item can be layered with others
    
    // Optional image data for the clothing item (stored as JPEG/PNG)
    var imageData: Data? = nil
    
    // MARK: - ClothingType Enum
    // Types of clothing
    enum ClothingType: String, CaseIterable, Codable {
        case top = "Top"
        case bottom = "Bottom"
        case outerwear = "Outerwear"
        case shoes = "Shoes"
        case accessory = "Accessory"
    }
    
    // MARK: - WeatherType Enum
    // Weather conditions that an item can be suitable for
    enum WeatherType: String, CaseIterable, Codable {
        case sunny = "Sunny"
        case cloudy = "Cloudy"
        case rainy = "Rainy"
        case snowy = "Snowy"
        case windy = "Windy"
    }
    
    // MARK: - Occasion Enum
    // Occasions the clothing item can be used for
    enum Occasion: String, CaseIterable, Codable {
        case casual = "Casual"
        case work = "Work"
        case formal = "Formal"
        case sport = "Sport"
        case any = "Any"
    }
    
    // MARK: - Computed Properties / Methods
    // Check if the item is suitable for a given temperature
    /// - Parameter temperature: Temperature in °C
    /// - Returns: `true` if temperature is within minTemp and maxTemp
    func isSuitableFor(temperature: Double) -> Bool {
        return temperature >= minTemp && temperature <= maxTemp
    }
    
    // Check if the item is suitable for a given weather condition
    /// - Parameter weather: Weather condition string (e.g., "Rainy")
    /// - Returns: `true` if item supports the mapped weather type
    func isSuitableFor(weather: String) -> Bool {
        let weatherType = mapWeatherCondition(weather)
        return weatherTypes.contains(weatherType)
    }
    
    // Map a weather description string to a WeatherType enum
    /// - Parameter condition: Weather description string (e.g., "light rain")
    /// - Returns: Corresponding WeatherType
    private func mapWeatherCondition(_ condition: String) -> WeatherType {
        let lowercased = condition.lowercased()
        if lowercased.contains("rain") || lowercased.contains("drizzle") {
            return .rainy
        } else if lowercased.contains("snow") {
            return .snowy
        } else if lowercased.contains("wind") {
            return .windy
        } else if lowercased.contains("cloud") {
            return .cloudy
        } else {
            return .sunny
        }
    }
}
