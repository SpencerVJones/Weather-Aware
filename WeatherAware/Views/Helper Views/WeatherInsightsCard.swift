//
//  WeatherInsightsCard.swift
//  WeatherAware
//
//  Created by Spencer Jones on 8/22/25.
//

import Foundation
import SwiftUI
struct WeatherInsightsCard: View {
    let weather: OneCallWeatherData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Weather Insights")
                .font(.headline)
                .fontWeight(.semibold)
            
            VStack(spacing: 8) {
                if weather.current.temp < 10 {
                    InsightRow(
                        icon: "snowflake",
                        text: "It's quite cold today. Consider layering and warm outerwear.",
                        color: .blue
                    )
                } else if weather.current.temp > 25 {
                    InsightRow(
                        icon: "sun.max.fill",
                        text: "It's warm today. Light, breathable clothing recommended.",
                        color: .orange
                    )
                }
                
                if weather.current.humidity > 70 {
                    InsightRow(
                        icon: "humidity.fill",
                        text: "High humidity detected. Choose moisture-wicking fabrics.",
                        color: .cyan
                    )
                }
                
                if weather.current.windSpeed > 5 {
                    InsightRow(
                        icon: "wind",
                        text: "It's windy today. A windbreaker might be helpful.",
                        color: .green
                    )
                }
                
                if let precipitationChance = weather.daily.first?.pop, precipitationChance > 0.3 {
                    InsightRow(
                        icon: "cloud.rain.fill",
                        text: "High chance of precipitation. Don't forget an umbrella!",
                        color: .gray
                    )
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

// MARK: PREVIEW
#Preview {
    // Mock current weather
    let mockCurrent = OneCallWeatherData.Current(
        dt: Int(Date().timeIntervalSince1970),
        sunrise: nil,
        sunset: nil,
        temp: 28,                 // warm for insight test
        feelsLike: 30,
        pressure: 1012,
        humidity: 75,             // high humidity
        dewPoint: 22,
        uvi: 6,
        clouds: 20,
        visibility: 10000,
        windSpeed: 6,             // windy
        windDeg: 180,
        windGust: nil,
        weather: [
            OneCallWeatherData.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")
        ]
    )

    // Mock daily weather
    let mockDaily = [
        OneCallWeatherData.Daily(
            dt: Int(Date().timeIntervalSince1970),
            sunrise: 0,
            sunset: 0,
            moonrise: 0,
            moonset: 0,
            moonPhase: 0.5,
            summary: "Clear sky",
            temp: OneCallWeatherData.Daily.Temp(day: 28, min: 20, max: 30, night: 22, eve: 27, morn: 20),
            feelsLike: OneCallWeatherData.Daily.FeelsLike(day: 30, night: 22, eve: 28, morn: 20),
            pressure: 1012,
            humidity: 75,
            dewPoint: 22,
            windSpeed: 6,
            windDeg: 180,
            windGust: nil,
            weather: [OneCallWeatherData.Weather(id: 500, main: "Rain", description: "light rain", icon: "10d")],
            clouds: 20,
            pop: 0.6,              // high precipitation chance
            uvi: 6
        )
    ]

    // Mock OneCallWeatherData
    let mockWeather = OneCallWeatherData(
        lat: 37.7749,
        lon: -122.4194,
        timezone: "PST",
        timezoneOffset: -28800,
        current: mockCurrent,
        hourly: nil,
        daily: mockDaily
    )

    WeatherInsightsCard(weather: mockWeather)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
