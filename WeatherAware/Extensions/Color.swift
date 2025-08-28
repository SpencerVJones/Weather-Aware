//  Color.swift
//  WeatherAware
//  Created by Spencer Jones on 8/16/25

/*
This file contains custom Color extensions used throughout the WeatherAware app.
*/

import Foundation
import SwiftUI

extension Color {
    // MARK: - App-specific colors
    static let weatherBlue = Color(red: 0.2, green: 0.6, blue: 0.9) // Custom blue color used throughout the WeatherAware app for consistency
    static let weatherGray = Color(red: 0.5, green: 0.5, blue: 0.5) // Custom gray color used for subtle UI elements and backgrounds
    static let weatherOrange = Color(red: 1.0, green: 0.6, blue: 0.2) // Custom orange color used for highlights and warnings
    
    // MARK: - Clothing type colors
    // Returns a color associated with a specific clothing type
    /// - Parameter type: ClothingItem.ClothingType enum value
    /// - Returns: Color representing the clothing type for UI display
    static func clothingColor(for type: ClothingItem.ClothingType) -> Color {
        switch type {
        case .top: return .blue
        case .bottom: return .purple
        case .outerwear: return .green
        case .shoes: return .brown
        case .accessory: return .orange
        }
    }
    
    // MARK: - Weather condition colors
    // Returns a color associated with a weather condition string
    /// - Parameter condition: Weather condition string (e.g., "Rainy", "Sunny")
    /// - Returns: Color representing the weather condition for UI display
    static func weatherConditionColor(for condition: String) -> Color {
        let lowercased = condition.lowercased()
        if lowercased.contains("rain") {
            return .blue
        } else if lowercased.contains("snow") {
            return .cyan
        } else if lowercased.contains("cloud") {
            return .gray
        } else if lowercased.contains("wind") {
            return .green
        } else {
            return .orange
        }
    }
}
