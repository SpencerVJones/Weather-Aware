//  WeatherConditionBadge.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

import Foundation
import SwiftUI

struct WeatherConditionBadge: View {
    let condition: String
    let temperature: Double
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: iconForCondition)
                .font(.caption)
                .foregroundColor(colorForCondition)
            
            Text(condition.capitalized)
                .font(.caption)
                .fontWeight(.medium)
            
            Text("\(Int(temperature))°")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(colorForCondition.opacity(0.1))
        .cornerRadius(8)
    }
    
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
            return "sun.max.fill"
        }
    }
    
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
            return .orange
        }
    }
}

// MARK: PREVIEW
#Preview {
    WeatherConditionBadge(
        condition: "Rainy",
        temperature: 18
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
