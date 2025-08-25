//  WeeklyRecommendationCard.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

//import Foundation
//import SwiftUI
//
//struct WeeklyRecommendationCard: View {
//    let recommendation: WeeklyRecommendation
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            // Date and Weather Header
//            HStack {
//                VStack(alignment: .leading, spacing: 4) {
//                    Text(recommendation.date, style: .date)
//                        .font(.headline)
//                        .fontWeight(.semibold)
//                    
//                    Text(recommendation.weather.weather.first?.description.capitalized ?? "")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                }
//                
//                Spacer()
//                
//                VStack(alignment: .trailing, spacing: 4) {
//                    HStack(spacing: 4) {
//                        Text("\(Int(recommendation.weather.temp.min))°")
//                            .foregroundColor(.secondary)
//                        Text("/")
//                            .foregroundColor(.secondary)
//                        Text("\(Int(recommendation.weather.temp.max))°")
//                            .fontWeight(.semibold)
//                    }
//                    .font(.title3)
//                    
//                    if recommendation.weather.pop > 0.3 {
//                        HStack(spacing: 4) {
//                            Image(systemName: "cloud.rain.fill")
//                                .foregroundColor(.blue)
//                            Text("\(Int(recommendation.weather.pop * 100))%")
//                        }
//                        .font(.caption)
//                        .foregroundColor(.blue)
//                    }
//                }
//            }
//            
//            Divider()
//            
//            // Outfit Recommendation
//            if let outfit = recommendation.recommendation {
//                VStack(alignment: .leading, spacing: 8) {
//                    HStack {
//                        Text("Recommended Outfit")
//                            .font(.subheadline)
//                            .fontWeight(.medium)
//                        
//                        Spacer()
//                        
//                        ConfidenceBadge(confidence: outfit.confidence)
//                    }
//                    
//                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
//                        ForEach(outfit.items.prefix(3), id: \.id) { item in
//                            CompactClothingItemPreview(item: item)
//                        }
//                    }
//                    
//                    if outfit.items.count > 3 {
//                        Text("+ \(outfit.items.count - 3) more items")
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//                    }
//                }
//            } else {
//                VStack(spacing: 8) {
//                    HStack {
//                        Image(systemName: "exclamationmark.triangle")
//                            .foregroundColor(.orange)
//                        Text("No suitable items found")
//                            .font(.subheadline)
//                            .foregroundColor(.orange)
//                    }
//                    
//                    Text("Consider adding more clothing items to your wardrobe")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                        .multilineTextAlignment(.center)
//                }
//            }
//        }
//        .padding()
//        .background(Color(.systemBackground))
//        .cornerRadius(16)
//        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
//    }
//}
//
//// MARK: PREVIEW
//#Preview {
//    // Mock clothing items
//    let items = [
//        ClothingItem(
//            name: "Blue Jacket",
//            type: .outerwear,
//            minTemp: 5,
//            maxTemp: 15,
//            weatherTypes: [.rainy, .windy],
//            occasion: .casual,
//            color: "Blue",
//            isLayerable: true
//        ),
//        ClothingItem(
//            name: "Jeans",
//            type: .bottom,
//            minTemp: 10,
//            maxTemp: 20,
//            weatherTypes: [.sunny],
//            occasion: .casual,
//            color: "Blue",
//            isLayerable: true
//        ),
//        ClothingItem(
//            name: "Sneakers",
//            type: .shoes,
//            minTemp: 5,
//            maxTemp: 25,
//            weatherTypes: [.sunny, .cloudy],
//            occasion: .casual,
//            color: "White",
//            isLayerable: false
//        )
//    ]
//    
//    // Mock outfit recommendation
//    let mockOutfit = OutfitRecommendation(
//        items: items,
//        weatherCondition: "Sunny",
//        temperature: 22,
//        confidence: 0.9
//    )
//    
//    // Mock daily weather data
//    let mockDailyWeather = OneCallWeatherData.Daily(
//        dt: Int(Date().timeIntervalSince1970),
//        sunrise: 1692705600,
//        sunset: 1692756000,
//        moonrise: 1692720000,
//        moonset: 1692764400,
//        moonPhase: 0.5,
//        summary: "Clear sky",
//        temp: .init(day: 22, min: 18, max: 25, night: 18, eve: 21, morn: 19),
//        feelsLike: .init(day: 22, night: 18, eve: 21, morn: 19),
//        pressure: 1015,
//        humidity: 60,
//        dewPoint: 12,
//        windSpeed: 5,
//        windDeg: 180,
//        windGust: nil,
//        weather: [
//            OneCallWeatherData.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")
//        ],
//        clouds: 0,
//        pop: 0.1,
//        uvi: 5
//    )
//    
//    // Mock weekly recommendation
//    let mockWeeklyRecommendation = WeeklyRecommendation(
//        date: Date(),
//        weather: mockDailyWeather,
//        recommendation: mockOutfit
//    )
//    
//    WeeklyRecommendationCard(recommendation: mockWeeklyRecommendation)
//        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
