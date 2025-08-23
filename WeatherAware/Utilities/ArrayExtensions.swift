//
//  ArrayExtensions.swift
//  WeatherAware
//
//  Created by Spencer Jones on 8/22/25.
//

import Foundation

extension Array where Element == ClothingItem {
    func filtered(by types: Set<ClothingItem.ClothingType>) -> [ClothingItem] {
        guard !types.isEmpty else { return self }
        return filter { types.contains($0.type) }
    }
    
    func suitableForTemperature(_ temp: Double) -> [ClothingItem] {
        return filter { $0.isSuitableFor(temperature: temp) }
    }
    
    func suitableForWeather(_ weather: String) -> [ClothingItem] {
        return filter { $0.isSuitableFor(weather: weather) }
    }
    
    func groupedByType() -> [ClothingItem.ClothingType: [ClothingItem]] {
        return Dictionary(grouping: self) { $0.type }
    }
    
    func sortedByVersatility() -> [ClothingItem] {
        return sorted { $0.suitabilityScore > $1.suitabilityScore }
    }
}
