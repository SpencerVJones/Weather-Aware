//  Color.swift
//  WeatherAware
//  Created by Spencer Jones on 8/16/25

import Foundation
import SwiftUICore

extension Color {
    static let weatherBlue = Color(red: 0.2, green: 0.6, blue: 0.9)
    static let weatherGray = Color(red: 0.5, green: 0.5, blue: 0.5)
    static let weatherOrange = Color(red: 1.0, green: 0.6, blue: 0.2)
    
    // Clothing type colors
    static func clothingColor(for type: ClothingItem.ClothingType) -> Color {
        switch type {
        case .top: return .blue
        case .bottom: return .purple
        case .outerwear: return .green
        case .shoes: return .brown
        case .accessory: return .orange
        }
    }
    
    // Weather condition colors
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
