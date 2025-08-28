//  WeatherConditionBadge.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

/*
A small badge displaying a weather condition with an icon and temperature.
The icon and background color adapt based on the weather condition.
*/

import Foundation
import SwiftUI

struct WeatherConditionBadge: View {
    let condition: String // The textual description of the weather condition (e.g., "Rainy", "Cloudy")
    let temperature: Double // Current temperature to display in the badge
    
    var body: some View {
        HStack(spacing: 6) {
            // Icon representing the weather condition
            Image(systemName: iconForCondition)
                .font(.caption)
                .foregroundColor(colorForCondition)
            
            // Weather condition text
            Text(condition.capitalized)
                .font(.caption)
                .fontWeight(.medium)
            
            // Temperature text
            Text("\(Int(temperature))°")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(colorForCondition.opacity(0.1))
        .cornerRadius(8)
    }
    
    // MARK: - Icon Selection
    // Returns a system icon string based on the weather condition
    private var iconForCondition: String {
        let lowercased = condition.lowercased()
        if lowercased.contains("rain") {
            return "cloud.rain.fill"
        } else if lowercased.contains("snow") {
            return "snow"
        } else if lowercased.contains("cloud") {
            return "cloud.fill"
        } else if lowercased.contains("wind") {
            return "wind"
        } else {
            return "sun.max.fill" // Default icon for sunny/clear conditions
        }
    }
    
    // MARK: - Color Selection
    // Returns a color associated with the weather condition
    private var colorForCondition: Color {
        let lowercased = condition.lowercased()
        if lowercased.contains("rain") {
            return .blue
        } else if lowercased.contains("snow") {
            return .cyan
        } else if lowercased.contains("cloud") {
            return .gray
        } else if lowercased.contains("wind") {
            return .green
        } else {
            return .orange // Default color for sunny/clear conditions
        }
    }
}

// MARK: - PREVIEW
#Preview {
    // Preview a sample badge for a rainy day at 18°
    WeatherConditionBadge(
        condition: "Rainy",
        temperature: 18
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
