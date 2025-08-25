//  WeatherIcon.swift
//  WeatherAware
//  Created by Spencer Jones on 8/15/25

import Foundation
import SwiftUI

struct WeatherIcon: View {
    let iconCode: String
    let size: CGFloat
    
    var body: some View {
        Image(systemName: systemIconForWeatherCode(iconCode))
            .font(.system(size: size))
            .foregroundColor(colorForWeatherCode(iconCode))
    }
    
    private func systemIconForWeatherCode(_ code: String) -> String {
        // Map OpenWeatherMap icon codes to SF Symbols
        switch code {
        case "01d", "01n": return "sun.max.fill"
        case "02d", "02n": return "cloud.sun.fill"
        case "03d", "03n": return "cloud.fill"
        case "04d", "04n": return "smoke.fill"
        case "09d", "09n": return "cloud.drizzle.fill"
        case "10d": return "cloud.sun.rain.fill"
        case "10n": return "cloud.moon.rain.fill"
        case "11d", "11n": return "cloud.bolt.fill"
        case "13d", "13n": return "snow"
        case "50d", "50n": return "cloud.fog.fill"
        default: return "sun.max.fill"
        }
    }
    
    private func colorForWeatherCode(_ code: String) -> Color {
        switch code {
        case "01d", "01n": return .yellow
        case "02d", "02n": return .orange
        case "03d", "03n", "04d", "04n": return .gray
        case "09d", "09n", "10d", "10n": return .blue
        case "11d", "11n": return .purple
        case "13d", "13n": return .cyan
        case "50d", "50n": return .gray
        default: return .yellow
        }
    }
}

// MARK: PREVIEW
#Preview {
    WeatherIcon(iconCode: "01d", size: 40)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
