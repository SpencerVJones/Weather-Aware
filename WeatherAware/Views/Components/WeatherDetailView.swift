//  WeatherDetailView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/12/25

/*
A small vertical stack view displaying a single weather detail.
Shows an icon, a title, and a value. Typically used inside a row of multiple weather details.
*/

import Foundation
import SwiftUI

struct WeatherDetailView: View {
    let icon: String // SF Symbol icon representing the weather detail (e.g., thermometer, wind)
    let title: String // Title of the weather detail (e.g., "Temperature", "Humidity")
    let value: String // Value of the detail as a string (e.g., "22°", "55%")
    
    var body: some View {
        VStack(spacing: 4) {
            // Icon for the weather detail
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.weatherBlue)
            
            // Title text displayed below the icon
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
            
            // Value text displayed below the title
            Text(value)
                .font(.caption)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - PREVIEW
#Preview {
    // Preview a single weather detail with icon, title, and value
    WeatherDetailView(
        icon: "thermometer.medium",
        title: "Temperature",
        value: "22°F"
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
