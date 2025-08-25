//  WeatherCard.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

import Foundation
import SwiftUI

struct WeatherCard: View {
    let weather: OneCallWeatherData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Current Weather")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(weather.current.weather.first?.description.capitalized ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
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
            
            HStack(spacing: 20) {
                WeatherDetailView(
                    icon: "thermometer.medium",
                    title: "Range",
                    value: TemperatureUtils.formatTemperatureRange(
                        weather.daily.first?.temp.min ?? weather.current.temp,
                        weather.daily.first?.temp.max ?? weather.current.temp
                    )
                )
                
                WeatherDetailView(
                    icon: "humidity",
                    title: "Humidity",
                    value: "\(weather.current.humidity)%"
                )
                
                WeatherDetailView(
                    icon: "wind",
                    title: "Wind",
                    value: "\(Int(weather.current.windSpeed)) m/s"
                )
                
                WeatherDetailView(
                    icon: "sun.max",
                    title: "UV Index",
                    value: String(format: "%.1f", weather.current.uvi)
                )
            }
        }
        .padding()
        .background(
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

// MARK: PREVIEW
#Preview {
    // Mock current weather
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
    
    WeatherCard(weather: mockWeather)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
