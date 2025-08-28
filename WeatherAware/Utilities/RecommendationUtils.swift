//  RecommendationUtils.swift
//  WeatherAware
//  Created by Spencer Jones on 8/15/25

/*
This file provides utility functions for generating clothing recommendations
based on weather conditions, temperature, and the user's wardrobe.
It includes methods to calculate confidence scores for outfit suitability,
determine if layering is needed, and generate helpful outfit tips.
*/

import Foundation

struct RecommendationUtils {
    // MARK: - Confidence Calculation
    // Calculates a confidence score for a proposed outfit based on temperature,
    // weather condition, and essential clothing coverage.
    /// - Parameters:
    ///   - items: Array of ClothingItem to evaluate
    ///   - temperature: Current temperature in Fahrenheit
    ///   - weatherCondition: Weather description string (e.g., "rainy")
    /// - Returns: Confidence score between 0.0 and 1.0
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
    
    // MARK: - Layering Recommendation
    // Determines whether the user should layer their clothing.
    /// - Parameters:
    ///   - temperature: Current temperature in Fahrenheit
    ///   - windSpeed: Current wind speed in m/s
    ///   - items: Array of ClothingItem
    /// - Returns: True if layering is recommended, false otherwise
    static func shouldRecommendLayering(
        temperature: Double,
        windSpeed: Double,
        items: [ClothingItem]
    ) -> Bool {
        let layerableItems = items.filter { $0.isLayerable }
        // Recommend layering if more than one layerable item and it's cold or windy
        return layerableItems.count > 1 && (temperature < 59 || windSpeed > 5)
    }
    
    // MARK: - Outfit Tips
    // Generates human-readable outfit tips based on clothing items and weather.
    /// - Parameters:
    ///   - items: Array of ClothingItem
    ///   - weather: Current weather data from OneCallWeatherData
    /// - Returns: Array of tips as strings
    static func generateOutfitTips(
        for items: [ClothingItem],
        weather: OneCallWeatherData.Current
    ) -> [String] {
        var tips: [String] = []
        
        // Temperature-based tips (in Fahrenheit)
        if weather.temp < 50 {  // Changed from 10°C to 50°F
            tips.append("Layer up! It's quite cold today.")
        } else if weather.temp > 77 {  // Changed from 25°C to 77°F
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
