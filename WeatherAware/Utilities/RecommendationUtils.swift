//  RecommendationUtils.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

import Foundation

struct RecommendationUtils {
    static func calculateConfidence(
        for items: [ClothingItem],
        temperature: Double,
        weatherCondition: String
    ) -> Double {
        guard !items.isEmpty else { return 0.0 }
        
        var totalScore = 0.0
        let requiredTypes: Set<ClothingItem.ClothingType> = [.top, .bottom, .shoes]
        let availableTypes = Set(items.map { $0.type })
        
        // Base confidence from having essential items
        let essentialCoverage = Double(requiredTypes.intersection(availableTypes).count) / Double(requiredTypes.count)
        totalScore += essentialCoverage * 0.5
        
        // Temperature suitability
        let tempSuitableCount = items.filter { $0.isSuitableFor(temperature: temperature) }.count
        let tempScore = Double(tempSuitableCount) / Double(items.count)
        totalScore += tempScore * 0.3
        
        // Weather suitability
        let weatherSuitableCount = items.filter { $0.isSuitableFor(weather: weatherCondition) }.count
        let weatherScore = Double(weatherSuitableCount) / Double(items.count)
        totalScore += weatherScore * 0.2
        
        return min(1.0, totalScore)
    }
    
    static func shouldRecommendLayering(
        temperature: Double,
        windSpeed: Double,
        items: [ClothingItem]
    ) -> Bool {
        let layerableItems = items.filter { $0.isLayerable }
        return layerableItems.count > 1 && (temperature < 15 || windSpeed > 5)
    }
    
    static func generateOutfitTips(
        for items: [ClothingItem],
        weather: OneCallWeatherData.Current
    ) -> [String] {
        var tips: [String] = []
        
        // Temperature-based tips
        if weather.temp < 10 {
            tips.append("Layer up! It's quite cold today.")
        } else if weather.temp > 25 {
            tips.append("Stay cool with breathable fabrics.")
        }
        
        // Weather condition tips
        if let condition = weather.weather.first?.main.lowercased() {
            if condition.contains("rain") {
                tips.append("Don't forget an umbrella or rain jacket!")
            } else if condition.contains("snow") {
                tips.append("Waterproof footwear recommended.")
            }
        }
        
        // Wind tips
        if weather.windSpeed > 5 {
            tips.append("It's windy - consider a windbreaker.")
        }
        
        // UV tips
        if weather.uvi > 6 {
            tips.append("High UV index - wear sunglasses and sunscreen.")
        }
        
        // Humidity tips
        if weather.humidity > 70 {
            tips.append("High humidity - choose moisture-wicking materials.")
        }
        
        return tips
    }
}
