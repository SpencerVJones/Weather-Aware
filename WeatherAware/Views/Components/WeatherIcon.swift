//  WeatherIcon.swift
//  WeatherAware
//  Created by Spencer Jones on 8/15/25

/*
Displays an SF Symbol representing the current weather condition.
Maps OpenWeatherMap icon codes to system icons and assigns appropriate colors.
*/

import Foundation
import SwiftUI

struct WeatherIcon: View {
    let iconCode: String // OpenWeatherMap icon code
    let size: CGFloat // Size of the icon
    
    var body: some View {
        Image(systemName: systemIconForWeatherCode(iconCode)) // Select SF Symbol based on iconCode
            .font(.system(size: size)) // Set the icon size
            .foregroundColor(colorForWeatherCode(iconCode)) // Set the color based on weather condition
    }
    
    // MARK: - Icon Mapping
    // Maps OpenWeatherMap icon codes to SF Symbols
    private func systemIconForWeatherCode(_ code: String) -> String {
        switch code {
        case "01d", "01n": return "sun.max.fill" // Clear sky
        case "02d", "02n": return "cloud.sun.fill" // Few clouds
        case "03d", "03n": return "cloud.fill" // Scattered clouds
        case "04d", "04n": return "smoke.fill" // Broken/overcast clouds
        case "09d", "09n": return "cloud.drizzle.fill" // Shower rain
        case "10d": return "cloud.sun.rain.fill" // Rain during day
        case "10n": return "cloud.moon.rain.fill" // Rain at night
        case "11d", "11n": return "cloud.bolt.fill" // Thunderstorm
        case "13d", "13n": return "snow" // Snow
        case "50d", "50n": return "cloud.fog.fill" // Mist/fog
        default: return "sun.max.fill" // Default icon for unknown codes
        }
    }
    
    // MARK: - Color Mapping
    // Returns a color appropriate for the weather condition
    private func colorForWeatherCode(_ code: String) -> Color {
        switch code {
        case "01d", "01n": return .yellow // Clear sky
        case "02d", "02n": return .orange // Few clouds
        case "03d", "03n", "04d", "04n": return .gray // Cloudy
        case "09d", "09n", "10d", "10n": return .blue // Rain
        case "11d", "11n": return .purple // Thunderstorm
        case "13d", "13n": return .cyan // Snow
        case "50d", "50n": return .gray // Fog/mist
        default: return .yellow // Default color
        }
    }
}

// MARK: - PREVIEW
#Preview {
    // Preview a clear day weather icon at 40pt size
    WeatherIcon(iconCode: "01d", size: 40)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
