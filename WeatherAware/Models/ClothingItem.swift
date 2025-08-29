//  ClothingItem.swift
//  WeatherAware
//  Created by Spencer Jones on 8/14/25

/*
This file contains an extension for the ClothingItem model that provides
additional computed properties to help display and evaluate clothing items
in the app.
*/

import Foundation
import SwiftUI

extension ClothingItem {
    
    
    // Returns a string representing the temperature range suitable for this clothing item.
    var temperatureRangeText: String {
        return "\(Int(minTemp))-\(Int(maxTemp))°C"
    }
    
    // Returns a comma-separated string of weather types suitable for this clothing item.
    var weatherTypesText: String {
        return weatherTypes.map { $0.rawValue }.joined(separator: ", ")
    }
    
    // Computes a suitability score for the clothing item based on versatility.
    /// The score is influenced by temperature range, number of weather types, and layerability.
    /// - Temperature range: wider range increases score (max +0.3)
    /// - Weather types: more types increases score (+0.05 per type)
    /// - Layerable: adds +0.1 if true
    /// - Returns: A value between 0.0 and 1.0 representing versatility
    var suitabilityScore: Double {
        // Base score
        var score = 0.5
        
        // Bonus for wider temperature range
        let tempRange = maxTemp - minTemp
        score += min(tempRange / 40.0, 0.3) // Max 0.3 bonus for range
        
        // Bonus for supporting more weather types
        score += Double(weatherTypes.count) * 0.05
        
        // Bonus for layerable items
        if isLayerable {
            score += 0.1
        }
        
        // Ensure score does not exceed 1.0
        return min(score, 1.0)
    }
}
