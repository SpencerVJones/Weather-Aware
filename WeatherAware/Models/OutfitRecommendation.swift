//  OutfitRecommendation.swift
//  WeatherAware
//  Created by Spencer Jones on 8/10/25

import Foundation

struct OutfitRecommendation {
    let items: [ClothingItem]
    let weatherCondition: String
    let temperature: Double
    let confidence: Double
    let date: Date
    
    init(items: [ClothingItem], weatherCondition: String, temperature: Double, confidence: Double, date: Date = Date()) {
        self.items = items
        self.weatherCondition = weatherCondition
        self.temperature = temperature
        self.confidence = confidence
        self.date = date
    }
}

