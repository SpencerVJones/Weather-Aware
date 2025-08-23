//  WeatherDetailView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/12/25

import Foundation
import SwiftUI

struct WeatherDetailView: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.weatherBlue)
            
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.caption)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: PREVIEW
#Preview {
    WeatherDetailView(
        icon: "thermometer.medium",
        title: "Temperature",
        value: "22°C"
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
