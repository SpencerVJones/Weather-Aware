//  WeatherType.swift
//  WeatherAware
//  Created by Spencer Jones on 8/14/25

import Foundation
import SwiftUICore

extension ClothingItem.WeatherType {
    func iconForWeatherType() -> String {
        switch self {
        case .sunny: return "sun.max"
        case .cloudy: return "cloud"
        case .rainy: return "cloud.rain"
        case .snowy: return "cloud.snow"
        case .windy: return "wind"
        }
    }
    
    func colorForWeatherType() -> Color {
        switch self {
        case .sunny: return .yellow
        case .cloudy: return .gray
        case .rainy: return .blue
        case .snowy: return .white
        case .windy: return .cyan
        }
    }
}
