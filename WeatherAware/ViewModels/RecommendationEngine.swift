//  RecommendationEngine.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

import Foundation

class RecommendationEngine: ObservableObject {
    @Published var currentRecommendation: OutfitRecommendation?
    @Published var weeklyRecommendations: [WeeklyRecommendation] = []
    
    private let wardrobeManager: WardrobeManager
    
    init(wardrobeManager: WardrobeManager) {
        self.wardrobeManager = wardrobeManager
    }
    
    func generateRecommendation(for weather: OneCallWeatherData) {
        let temperature = weather.current.temp
        let weatherCondition = weather.current.weather.first?.description ?? "Clear"
        let weatherMain = weather.current.weather.first?.main ?? "Clear"
        
        let suitableItems = wardrobeManager.clothingItems.filter { item in
            item.isSuitableFor(temperature: temperature) && item.isSuitableFor(weather: weatherMain)
        }
        
        let recommendation = createOptimalOutfit(
            from: suitableItems,
            temperature: temperature,
            weatherCondition: weatherCondition
        )
        
        DispatchQueue.main.async {
            self.currentRecommendation = recommendation
        }
    }
    
    func generateWeeklyRecommendations(for weather: OneCallWeatherData) {
        var recommendations: [WeeklyRecommendation] = []
        
        for (index, dailyWeather) in weather.daily.enumerated() {
            let date = Date().addingTimeInterval(TimeInterval(index * 86400)) // Add days
            let temperature = dailyWeather.temp.day
            let weatherCondition = dailyWeather.weather.first?.description ?? "Clear"
            let weatherMain = dailyWeather.weather.first?.main ?? "Clear"
            
            let suitableItems = wardrobeManager.clothingItems.filter { item in
                item.isSuitableFor(temperature: temperature) && item.isSuitableFor(weather: weatherMain)
            }
            
            let recommendation = createOptimalOutfit(
                from: suitableItems,
                temperature: temperature,
                weatherCondition: weatherCondition,
                date: date
            )
            
            recommendations.append(WeeklyRecommendation(
                date: date,
                weather: dailyWeather,
                recommendation: recommendation
            ))
        }
        
        DispatchQueue.main.async {
            self.weeklyRecommendations = recommendations
        }
    }
    
    private func createOptimalOutfit(
        from items: [ClothingItem],
        temperature: Double,
        weatherCondition: String,
        date: Date = Date()
    ) -> OutfitRecommendation? {
        
        guard !items.isEmpty else { return nil }
        
        var outfit: [ClothingItem] = []
        var confidence: Double = 0.8
        
        // Select one item from each essential category
        let categories: [ClothingItem.ClothingType] = [.top, .bottom, .shoes]
        
        for category in categories {
            let categoryItems = items.filter { $0.type == category }
            if let bestItem = selectBestItem(from: categoryItems, temperature: temperature) {
                outfit.append(bestItem)
            } else {
                confidence -= 0.2 // Reduce confidence if essential item is missing
            }
        }
        
        // Add outerwear if temperature is low or weather is harsh
        if temperature < 15 || weatherCondition.lowercased().contains("rain") || weatherCondition.lowercased().contains("snow") {
            let outerwearItems = items.filter { $0.type == .outerwear }
            if let outerwear = selectBestItem(from: outerwearItems, temperature: temperature) {
                outfit.append(outerwear)
                confidence += 0.1
            } else {
                confidence -= 0.1
            }
        }
        
        // Add accessories if appropriate
        let accessories = items.filter { $0.type == .accessory }
        if !accessories.isEmpty, let accessory = accessories.randomElement() {
            outfit.append(accessory)
            confidence += 0.05
        }
        
        // Ensure confidence is within bounds
        confidence = max(0.3, min(1.0, confidence))
        
        guard !outfit.isEmpty else { return nil }
        
        return OutfitRecommendation(
            items: outfit,
            weatherCondition: weatherCondition,
            temperature: temperature,
            confidence: confidence,
            date: date
        )
    }
    
    private func selectBestItem(from items: [ClothingItem], temperature: Double) -> ClothingItem? {
        guard !items.isEmpty else { return nil }
        
        // Score items based on temperature range fit
        let scoredItems = items.map { item -> (item: ClothingItem, score: Double) in
            let tempRange = item.maxTemp - item.minTemp
            let tempCenter = (item.minTemp + item.maxTemp) / 2
            let distanceFromCenter = abs(temperature - tempCenter)
            
            // Prefer items with smaller distance from center and reasonable range
            let score = 1.0 / (1.0 + distanceFromCenter) + (tempRange > 20 ? 0.1 : 0.2)
            
            return (item, score)
        }
        
        return scoredItems.max(by: { $0.score < $1.score })?.item
    }
}
