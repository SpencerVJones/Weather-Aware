//  OutfitRecommendation.swift
//  WeatherAware
//  Created by Spencer Jones on 8/10/25

/*
Represents a recommended outfit based on weather conditions.
Includes the clothing items, the weather description, temperature, confidence score, and the date of recommendation.
*/

import Foundation

struct OutfitRecommendation {
    let items: [ClothingItem] // Array of clothing items included in the recommendation
    let weatherCondition: String // Weather condition description (e.g., "Sunny", "Rainy")
    let temperature: Double // Temperature for which the recommendation is suitable
    let confidence: Double // Confidence score of the recommendation (0.0–1.0)
    let date: Date // Date when the recommendation was generated
    
    // MARK: - Initializer
    // Initialize an OutfitRecommendation
    /// - Parameters:
    ///   - items: Array of ClothingItem objects
    ///   - weatherCondition: Weather description string
    ///   - temperature: Temperature in °C
    ///   - confidence: Confidence level (0–1)
    ///   - date: Date of the recommendation (default is current date)
    init(items: [ClothingItem], weatherCondition: String, temperature: Double, confidence: Double, date: Date = Date()) {
        self.items = items
        self.weatherCondition = weatherCondition
        self.temperature = temperature
        self.confidence = confidence
        self.date = date
    }
}
