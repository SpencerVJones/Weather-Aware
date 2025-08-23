//  WeatherService.swift
//  WeatherAware
//  Created by Spencer Jones on 8/09/25

import Foundation
import Combine

class WeatherService: ObservableObject {
    @Published var currentWeather: OneCallWeatherData?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiKey = "ffb048678081e3feb7407951a2f12d40"    
    private let session = URLSession.shared
        
        func fetchWeatherForCity(_ cityName: String) async {
            await MainActor.run {
                isLoading = true
                errorMessage = nil
            }
            
            do {
                // First, get coordinates for the city
                let coordinates = try await geocodeCity(cityName)
                
                // Then fetch weather using coordinates
                let weather = try await fetchWeatherForCoordinates(
                    lat: coordinates.lat,
                    lon: coordinates.lon
                )
                
                await MainActor.run {
                    self.currentWeather = weather
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
        
        private func geocodeCity(_ cityName: String) async throws -> GeocodingResult {
            let encodedCity = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? cityName
            let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(encodedCity)&limit=1&appid=\(apiKey)"
            
            guard let url = URL(string: urlString) else {
                throw WeatherError.invalidURL
            }
            
            let (data, _) = try await session.data(from: url)
            let results = try JSONDecoder().decode([GeocodingResult].self, from: data)
            
            guard let first = results.first else {
                throw WeatherError.cityNotFound
            }
            
            return first
        }
        
        private func fetchWeatherForCoordinates(lat: Double, lon: Double) async throws -> OneCallWeatherData {
            let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,alerts&appid=\(apiKey)&units=metric"
            
            guard let url = URL(string: urlString) else {
                throw WeatherError.invalidURL
            }
            
            let (data, _) = try await session.data(from: url)
            return try JSONDecoder().decode(OneCallWeatherData.self, from: data)
        }
    }
