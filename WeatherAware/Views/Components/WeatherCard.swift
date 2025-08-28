//  WeatherCard.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

/*
A card view displaying current weather information along with key weather details like temperature range, humidity, wind speed, and UV index.
*/

import Foundation
import SwiftUI

struct WeatherCard: View {
    let weather: OneCallWeatherData // Weather data for the card
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // MARK: - Header: Current Weather
            HStack {
                // Left side: Weather description
                VStack(alignment: .leading, spacing: 4) {
                    Text("Current Weather")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    // Show first weather description, capitalized
                    Text(weather.current.weather.first?.description.capitalized ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Right side: Temperature and "feels like"
                VStack(alignment: .trailing, spacing: 4) {
                    Text(TemperatureUtils.formatTemperature(weather.current.temp))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Feels \(TemperatureUtils.formatTemperature(weather.current.feelsLike))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Divider()
            
            // MARK: - Weather Details Row
            HStack(spacing: 20) {
                // Temperature range for the day
                WeatherDetailView(
                    icon: "thermometer.medium",
                    title: "Range",
                    value: TemperatureUtils.formatTemperatureRange(
                        weather.daily.first?.temp.min ?? weather.current.temp,
                        weather.daily.first?.temp.max ?? weather.current.temp
                    )
                )
                
                // Humidity
                WeatherDetailView(
                    icon: "humidity",
                    title: "Humidity",
                    value: "\(weather.current.humidity)%"
                )
                
                // Wind speed
                WeatherDetailView(
                    icon: "wind",
                    title: "Wind",
                    value: "\(Int(weather.current.windSpeed)) m/s"
                )
                
                // UV Index
                WeatherDetailView(
                    icon: "sun.max",
                    title: "UV Index",
                    value: String(format: "%.1f", weather.current.uvi)
                )
            }
        }
        .padding()
        .background(
            // Gradient background for a subtle weather effect
            LinearGradient(
                colors: [Color.weatherBlue.opacity(0.1), Color.weatherBlue.opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// MARK: - PREVIEW
#Preview {
    // Mock current weather for preview
    let mockCurrent = OneCallWeatherData.Current(
        dt: Int(Date().timeIntervalSince1970),
        sunrise: nil,
        sunset: nil,
        temp: 22,
        feelsLike: 21,
        pressure: 1012,
        humidity: 55,
        dewPoint: 12,
        uvi: 5.2,
        clouds: 10,
        visibility: 10000,
        windSpeed: 4,
        windDeg: 180,
        windGust: nil,
        weather: [
            OneCallWeatherData.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")
        ]
    )
    
    // Mock daily weather for preview
    let mockDaily = [
        OneCallWeatherData.Daily(
            dt: Int(Date().timeIntervalSince1970),
            sunrise: 0,
            sunset: 0,
            moonrise: 0,
            moonset: 0,
            moonPhase: 0.5,
            summary: "Clear sky",
            temp: OneCallWeatherData.Daily.Temp(day: 22, min: 18, max: 25, night: 18, eve: 21, morn: 18),
            feelsLike: OneCallWeatherData.Daily.FeelsLike(day: 21, night: 18, eve: 20, morn: 18),
            pressure: 1012,
            humidity: 55,
            dewPoint: 12,
            windSpeed: 4,
            windDeg: 180,
            windGust: nil,
            weather: [OneCallWeatherData.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")],
            clouds: 10,
            pop: 0.0,
            uvi: 5.2
        )
    ]
    
    // Mock OneCallWeatherData for the preview
    let mockWeather = OneCallWeatherData(
        lat: 37.7749,
        lon: -122.4194,
        timezone: "PST",
        timezoneOffset: -28800,
        current: mockCurrent,
        hourly: nil,
        daily: mockDaily
    )
    
    // Display the WeatherCard with mock data
    WeatherCard(weather: mockWeather)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
