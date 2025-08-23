//
//  IconHelpers.swift
//  WeatherAware
//
//  Created by Spencer Jones on 8/22/25.
//

import Foundation
import SwiftUI

func iconForClothingType(_ type: ClothingItem.ClothingType) -> String {
    switch type {
    case .top: return "tshirt.fill"
    case .bottom: return "rectangle.fill"
    case .outerwear: return "jacket"
    case .shoes: return "shoe.2.fill"
    case .accessory: return "eyeglasses"
    }
}

func colorForClothingType(_ type: ClothingItem.ClothingType) -> Color {
    switch type {
    case .top: return .blue
    case .bottom: return .purple
    case .outerwear: return .green
    case .shoes: return .brown
    case .accessory: return .orange
    }
}

func iconForWeatherType(_ weather: ClothingItem.WeatherType) -> String {
    switch weather {
    case .sunny: return "sun.max.fill"
    case .cloudy: return "cloud.fill"
    case .rainy: return "cloud.rain.fill"
    case .snowy: return "snow"
    case .windy: return "wind"
    }
}

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
