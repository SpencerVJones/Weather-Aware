//  WeatherService.swift
//  WeatherAware
//  Created by Spencer Jones on 8/09/25
//  Using Current Weather API (free)

import Foundation
import Combine
import CoreLocation

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
            print("Fetching weather for: \(cityName)")
            
            // Get coordinates for the city
            let coordinates = try await geocodeCity(cityName)
            print("Got coordinates: \(coordinates.lat), \(coordinates.lon)")
            
            // Fetch current weather (free API)
            let currentWeather = try await fetchCurrentWeather(
                lat: coordinates.lat,
                lon: coordinates.lon
            )
            print("Successfully fetched current weather")
            
            // Convert to OneCallWeatherData format for compatibility
            let oneCallData = convertToOneCallFormat(currentWeather, coordinates: coordinates)
            
            await MainActor.run {
                self.currentWeather = oneCallData
                self.isLoading = false
            }
        } catch {
            print("Weather fetch error: \(error)")
            
            await MainActor.run {
                self.errorMessage = error.friendlyMessage
                self.isLoading = false
            }
        }
    }
    
    func fetchWeather(lat: Double, lon: Double) async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            print("🌍 Fetching weather for coordinates: \(lat), \(lon)")
            
            // Fetch current weather
            let currentWeather = try await fetchCurrentWeather(lat: lat, lon: lon)
            print("Successfully fetched current weather")
            
            // Convert to OneCallWeatherData
            let coordinates = GeocodingResult(name: "", localNames: nil, lat: lat, lon: lon, country: "", state: nil)
            let oneCallData = convertToOneCallFormat(currentWeather, coordinates: coordinates)
            
            await MainActor.run {
                self.currentWeather = oneCallData
                self.isLoading = false
            }
        } catch {
            print("Weather fetch error: \(error)")
            
            await MainActor.run {
                self.errorMessage = error.friendlyMessage
                self.isLoading = false
            }
        }
    }
    
    private func geocodeCity(_ cityName: String) async throws -> GeocodingResult {
        let encodedCity = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? cityName
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(encodedCity)&limit=1&appid=\(apiKey)"
        
        print("Geocoding URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            throw WeatherError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Geocoding response status: \(httpResponse.statusCode)")
            
            if httpResponse.statusCode != 200 {
                throw WeatherError.networkError
            }
        }
        
        do {
            let results = try JSONDecoder().decode([GeocodingResult].self, from: data)
            
            guard let first = results.first else {
                throw WeatherError.cityNotFound
            }
            
            return first
        } catch {
            if error is DecodingError {
                throw WeatherError.decodingError
            } else {
                throw error
            }
        }
    }
    
    private func fetchCurrentWeather(lat: Double, lon: Double) async throws -> CurrentWeatherResponse {
        // Use Current Weather API (completely free)
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        
        print("Current Weather URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            throw WeatherError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Current Weather response status: \(httpResponse.statusCode)")
            
            if httpResponse.statusCode != 200 {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Error response: \(responseString)")
                }
                throw WeatherError.networkError
            }
        }
        
        // Debug: Print response preview
        if let responseString = String(data: data, encoding: .utf8) {
            let preview = String(responseString.prefix(300))
            print("Current Weather response preview: \(preview)")
        }
        
        do {
            return try JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
        } catch {
            if error is DecodingError {
                print("Decoding error: \(error)")
                throw WeatherError.decodingError
            } else {
                throw error
            }
        }
    }
    
    // Convert CurrentWeatherResponse to OneCallWeatherData for compatibility
    private func convertToOneCallFormat(_ weather: CurrentWeatherResponse, coordinates: GeocodingResult) -> OneCallWeatherData {
        let current = OneCallWeatherData.Current(
            dt: weather.dt,
            sunrise: weather.sys.sunrise,
            sunset: weather.sys.sunset,
            temp: weather.main.temp,
            feelsLike: weather.main.feelsLike,
            pressure: weather.main.pressure,
            humidity: weather.main.humidity,
            dewPoint: 0, // Not available in current weather API
            uvi: 0, // Not available in current weather API
            clouds: weather.clouds.all,
            visibility: weather.visibility,
            windSpeed: weather.wind?.speed ?? 0,
            windDeg: weather.wind?.deg,
            windGust: weather.wind?.gust,
            weather: weather.weather.map { weatherItem in
                OneCallWeatherData.Weather(
                    id: weatherItem.id,
                    main: weatherItem.main,
                    description: weatherItem.description,
                    icon: weatherItem.icon
                )
            }
        )
        
        return OneCallWeatherData(
            lat: coordinates.lat,
            lon: coordinates.lon,
            timezone: "UTC", // Default timezone
            timezoneOffset: 0,
            current: current,
            hourly: nil, // Not available with free API
            daily: [] // Not available with free API
        )
    }
}

// MARK: - Current Weather API Response Structure
struct CurrentWeatherResponse: Codable {
    let coord: Coord
    let weather: [WeatherItem]
    let base: String
    let main: Main
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }
    
    struct WeatherItem: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
        
        enum CodingKeys: String, CodingKey {
            case temp, pressure, humidity
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Int?
        let gust: Double?
    }
    
    struct Clouds: Codable {
        let all: Int
    }
    
    struct Sys: Codable {
        let type: Int?
        let id: Int?
        let country: String
        let sunrise: Int?
        let sunset: Int?
    }
}
