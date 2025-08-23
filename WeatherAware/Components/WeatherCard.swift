//  WeatherCard.swift
//  WeatherAware
//  Created by Spencer Jones on 8/12/25

import SwiftUI

struct WeatherCard: View {
    let weather: WeatherData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(weather.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(weather.weather.first?.description.capitalized ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(TemperatureUtils.formatTemperature(weather.main.temp))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Feels \(TemperatureUtils.formatTemperature(weather.main.feels_like))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Divider()
            
            HStack(spacing: 20) {
                WeatherDetailView(
                    icon: "thermometer.medium",
                    title: "Range",
                    value: TemperatureUtils.formatTemperatureRange(weather.main.temp_min, weather.main.temp_max)
                )
                
                WeatherDetailView(
                    icon: "humidity",
                    title: "Humidity",
                    value: "\(weather.main.humidity)%"
                )
                
                WeatherDetailView(
                    icon: "wind",
                    title: "Wind",
                    value: "\(Int(weather.wind.speed)) m/s"
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
    // Mock WeatherData
    let mockWeather = WeatherData(
        main: WeatherData.Main(
            temp: 22,
            feels_like: 21,
            temp_min: 18,
            temp_max: 25,
            humidity: 60
        ),
        weather: [
            WeatherData.Weather(
                id: 800,
                main: "Clear",
                description: "clear sky",
                icon: "01d"
            )
        ],
        wind: WeatherData.Wind(
            speed: 5
        ),
        name: "San Francisco"
    )
    
    WeatherCard(weather: mockWeather)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
