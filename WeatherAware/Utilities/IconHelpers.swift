//  IconHelpers.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

/*
This file contains helper functions to map clothing types and weather types
or conditions to SF Symbols icons and associated colors. These helpers
are primarily used for displaying appropriate icons in the app's UI.
*/

import Foundation
import SwiftUI

// MARK: - Clothing Type Icons
// Returns an SF Symbol name for a given clothing type.
/// - Parameter type: ClothingItem.ClothingType enum value
/// - Returns: String representing the SF Symbol for the clothing type
func iconForClothingType(_ type: ClothingItem.ClothingType) -> String {
    switch type {
    case .top: return "tshirt.fill"
    case .bottom: return "rectangle.fill"
    case .outerwear: return "jacket"
    case .shoes: return "shoe.2.fill"
    case .accessory: return "eyeglasses"
    }
}

// MARK: - Clothing Type Colors
// Returns a Color for a given clothing type.
/// - Parameter type: ClothingItem.ClothingType enum value
/// - Returns: Color representing the clothing type
func colorForClothingType(_ type: ClothingItem.ClothingType) -> Color {
    switch type {
    case .top: return .blue
    case .bottom: return .purple
    case .outerwear: return .green
    case .shoes: return .brown
    case .accessory: return .orange
    }
}

// MARK: - Weather Type Icons
// Returns an SF Symbol name for a given weather type.
/// - Parameter weather: ClothingItem.WeatherType enum value
/// - Returns: String representing the SF Symbol for the weather type
func iconForWeatherType(_ weather: ClothingItem.WeatherType) -> String {
    switch weather {
    case .sunny: return "sun.max.fill"
    case .cloudy: return "cloud.fill"
    case .rainy: return "cloud.rain.fill"
    case .snowy: return "snow"
    case .windy: return "wind"
    }
}

// MARK: - Weather Condition Icons
// Returns an SF Symbol name based on a weather condition string.
/// - Parameter condition: Weather description string (e.g., "light rain")
/// - Returns: SF Symbol name representing the condition
func iconForWeatherCondition(_ condition: String) -> String {
    let lowercased = condition.lowercased()
    if lowercased.contains("rain") {
        return "cloud.rain.fill"
    } else if lowercased.contains("snow") {
        return "snow"
    } else if lowercased.contains("cloud") {
        return "cloud.fill"
    } else if lowercased.contains("wind") {
        return "wind"
    } else {
        return "sun.max.fill"
    }
}
