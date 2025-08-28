//  RecommendationEngine.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

/*
This class generates outfit recommendations based on current weather conditions
and the user's wardrobe. It considers temperature, weather type, and clothing versatility
to compute the optimal set of clothing items and a confidence score for the recommendation.
*/

import Foundation

class RecommendationEngine: ObservableObject {
    // MARK: - Published Properties
    @Published var currentRecommendation: OutfitRecommendation? // The currently generated outfit recommendation
    
    // MARK: - Private Properties
    private let wardrobeManager: WardrobeManager // Reference to the user's wardrobe manager containing clothing items
    
    // MARK: - Initialization
    init(wardrobeManager: WardrobeManager) {
        self.wardrobeManager = wardrobeManager
    }
    
    // MARK: - Public Methods
    // Generates a recommendation based on the current weather data
    /// - Parameter weather: OneCallWeatherData object containing current weather info
    func generateRecommendation(for weather: OneCallWeatherData) {
        let tempF = weather.current.temp // API returns Fahrenheit
        let weatherCondition = weather.current.weather.first?.description ?? "Clear"
        let weatherMain = weather.current.weather.first?.main ?? "Clear"
        
        // Filter wardrobe items suitable for current temperature and weather
        let suitableItems = wardrobeManager.clothingItems.filter { item in
            return tempF >= item.minTemp && tempF <= item.maxTemp && item.isSuitableFor(weather: weatherMain)
        }
        
        // Create the optimal outfit
        let recommendation = createOptimalOutfit(
            from: suitableItems,
            temperature: tempF,
            weatherCondition: weatherCondition
        )
        
        // Update the published property on the main thread
        DispatchQueue.main.async {
            self.currentRecommendation = recommendation
        }
    }
    
    // MARK: - Private Methods
    // Selects the best clothing items from filtered items to create an outfit
    /// - Parameters:
    ///   - items: Array of suitable clothing items
    ///   - temperature: Current temperature in Fahrenheit
    /// - Returns: An OutfitRecommendation or nil if no items are suitable
    private func createOptimalOutfit(from items: [ClothingItem], temperature: Double, weatherCondition: String) -> OutfitRecommendation? {
        guard !items.isEmpty else { return nil }
        var outfit: [ClothingItem] = []
        var confidence: Double = 0.8
        
        let categories: [ClothingItem.ClothingType] = [.top, .bottom, .shoes] // Essential categories to cover
        
        for category in categories {
            let categoryItems = items.filter { $0.type == category }
            if let best = selectBestItem(from: categoryItems, temperature: temperature) {
                outfit.append(best)
            } else { confidence -= 0.2 } // Reduce confidence if missing essential item
        }
        
        // Add outerwear if cold or rainy/snowy
        if temperature < 59 || weatherCondition.lowercased().contains("rain") || weatherCondition.lowercased().contains("snow") {
            let outerwear = items.filter { $0.type == .outerwear }
            if let best = selectBestItem(from: outerwear, temperature: temperature) {
                outfit.append(best)
                confidence += 0.1
            } else { confidence -= 0.1 }
        }
        
        // Optionally add an accessory for variety
        if let accessory = items.filter({ $0.type == .accessory }).randomElement() {
            outfit.append(accessory)
            confidence += 0.05
        }
        
        // Clamp confidence between 0.3 and 1.0
        confidence = max(0.3, min(1.0, confidence))
        guard !outfit.isEmpty else { return nil }
        
        return OutfitRecommendation(items: outfit, weatherCondition: weatherCondition, temperature: temperature, confidence: confidence, date: Date())
    }
    
    // Selects the single best clothing item closest to the current temperature
    /// - Parameters:
    ///   - items: Array of clothing items in a category
    ///   - temperature: Current temperature
    /// - Returns: The item with the closest center temperature
    private func selectBestItem(from items: [ClothingItem], temperature: Double) -> ClothingItem? {
        items.max { item1, item2 in
            let center1 = (item1.minTemp + item1.maxTemp) / 2
            let center2 = (item2.minTemp + item2.maxTemp) / 2
            return abs(temperature - center1) > abs(temperature - center2)
        }
    }
}
