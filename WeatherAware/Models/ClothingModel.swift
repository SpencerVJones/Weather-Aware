//  ClothingModel.swift
//  WeatherAware
//  Created by Spencer Jones on 8/10/25

import Foundation

struct ClothingItem: Codable, Identifiable {
    let id = UUID()
    var name: String
    var type: ClothingType
    var minTemp: Double
    var maxTemp: Double
    var weatherTypes: [WeatherType]
    var occasion: Occasion
    var color: String
    var isLayerable: Bool
    
    enum ClothingType: String, CaseIterable, Codable {
        case top = "Top"
        case bottom = "Bottom"
        case outerwear = "Outerwear"
        case shoes = "Shoes"
        case accessory = "Accessory"
    }
    
    enum WeatherType: String, CaseIterable, Codable {
        case sunny = "Sunny"
        case cloudy = "Cloudy"
        case rainy = "Rainy"
        case snowy = "Snowy"
        case windy = "Windy"
    }
    
    enum Occasion: String, CaseIterable, Codable {
        case casual = "Casual"
        case work = "Work"
        case formal = "Formal"
        case sport = "Sport"
        case any = "Any"
    }
    
    // Computed property to check if item is suitable for temperature
    func isSuitableFor(temperature: Double) -> Bool {
        return temperature >= minTemp && temperature <= maxTemp
    }
    
    // Computed property to check if item is suitable for weather
    func isSuitableFor(weather: String) -> Bool {
        let weatherType = mapWeatherCondition(weather)
        return weatherTypes.contains(weatherType)
    }
    
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
