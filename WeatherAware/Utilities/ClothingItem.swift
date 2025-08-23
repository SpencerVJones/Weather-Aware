//  ClothingItem.swift
//  WeatherAware
//  Created by Spencer Jones on 8/14/25

import Foundation
import SwiftUICore

extension ClothingItem {
    var temperatureRangeText: String {
        return "\(Int(minTemp))-\(Int(maxTemp))°C"
    }
    
    var weatherTypesText: String {
        return weatherTypes.map { $0.rawValue }.joined(separator: ", ")
    }
    
    var suitabilityScore: Double {
        // Base score
        var score = 0.5
        
        // Wider temperature range = more versatile
        let tempRange = maxTemp - minTemp
        score += min(tempRange / 40.0, 0.3) // Max 0.3 bonus for range
        
        // More weather types = more versatile
        score += Double(weatherTypes.count) * 0.05
        
        // Layerable items are more versatile
        if isLayerable {
            score += 0.1
        }
        
        return min(score, 1.0)
    }
}
