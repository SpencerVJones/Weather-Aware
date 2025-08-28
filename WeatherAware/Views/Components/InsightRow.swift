//  InsightRow.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

/*
Represents a single row in the app's insights or weather summary view.
Displays a system icon, descriptive text, and applies a color for the icon.
Useful for presenting quick weather insights such as temperature, wind, or UV index.
*/

import Foundation
import SwiftUI

// A view representing a single insight row with an icon, text, and color
struct InsightRow: View {
    // MARK: - Properties
    let icon: String // SF Symbol name for the icon
    let text: String // Descriptive text for the insight
    let color: Color // Color applied to the icon
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 12) {
            // Icon on the left side
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 20)
            
            // Insight text
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer() // Push content to the left
        }
    }
}

// MARK: - Preview
#Preview {
    InsightRow(
        icon: "thermometer.medium",
        text: "Temperature is moderate today",
        color: .blue
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
