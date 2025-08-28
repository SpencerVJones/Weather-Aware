//  OneCallWeatherData.swift
//  WeatherAware
//  Created by Spencer Jones on 8/10/25

/*
Represents the response from OpenWeatherMap One Call API.
Includes current, hourly, and daily weather information along with coordinates and timezone.
*/

import Foundation

struct OneCallWeatherData: Codable {
    let lat: Double // Latitude of the location
    let lon: Double // Longitude of the location
    let timezone: String // Timezone name (e.g., "PST")
    let timezoneOffset: Int // Timezone offset in seconds from UTC
    let current: Current // Current weather data
    let hourly: [Hourly]? // Optional hourly weather forecasts
    let daily: [Daily] // Daily weather forecasts
    
    // MARK: - Current Weather
    // Current weather conditions
    struct Current: Codable {
        let dt: Int // Time of data calculation (UNIX timestamp)
        let sunrise: Int? // Sunrise time (optional)
        let sunset: Int? // Sunset time (optional)
        let temp: Double // Current temperature
        let feelsLike: Double // Perceived temperature
        let pressure: Int // Atmospheric pressure (hPa)
        let humidity: Int // Humidity percentage
        let dewPoint: Double // Dew point
        let uvi: Double // UV index
        let clouds: Int // Cloudiness percentage
        let visibility: Int? // Visibility in meters (optional)
        let windSpeed: Double // Wind speed
        let windDeg: Int? // Wind direction in degrees (optional)
        let windGust: Double? // Wind gust speed (optional)
        let weather: [Weather] // Array of weather conditions
        
        // Map JSON keys to Swift properties
        enum CodingKeys: String, CodingKey {
            case dt, sunrise, sunset, temp, pressure, humidity, uvi, clouds, visibility, weather
            case feelsLike = "feels_like"
            case dewPoint = "dew_point"
            case windSpeed = "wind_speed"
            case windDeg = "wind_deg"
            case windGust = "wind_gust"
        }
    }
    
    // MARK: - Hourly Weather
    // Hourly forecast data
    struct Hourly: Codable {
        let dt: Int
        let temp: Double
        let feelsLike: Double
        let pressure: Int
        let humidity: Int
        let dewPoint: Double
        let uvi: Double
        let clouds: Int
        let visibility: Int?
        let windSpeed: Double
        let windDeg: Int?
        let windGust: Double?
        let weather: [Weather]
        let pop: Double // Probability of precipitation
        
        enum CodingKeys: String, CodingKey {
            case dt, temp, pressure, humidity, uvi, clouds, visibility, weather, pop
            case feelsLike = "feels_like"
            case dewPoint = "dew_point"
            case windSpeed = "wind_speed"
            case windDeg = "wind_deg"
            case windGust = "wind_gust"
        }
    }
    
    // MARK: - Daily Weather
    // Daily forecast data
    struct Daily: Codable {
        let dt: Int
        let sunrise: Int
        let sunset: Int
        let moonrise: Int
        let moonset: Int
        let moonPhase: Double // Fractional phase of the moon
        let summary: String? // Optional text summary
        let temp: Temp // Temperature details
        let feelsLike: FeelsLike // Perceived temperature details
        let pressure: Int
        let humidity: Int
        let dewPoint: Double
        let windSpeed: Double
        let windDeg: Int
        let windGust: Double?
        let weather: [Weather]
        let clouds: Int
        let pop: Double
        let uvi: Double
        
        // MARK: - Temp
        // Temperature values for different times of day
        struct Temp: Codable {
            let day: Double
            let min: Double
            let max: Double
            let night: Double
            let eve: Double
            let morn: Double
        }
        
        // MARK: - FeelsLike
        // "Feels like" temperatures for different times of day
        struct FeelsLike: Codable {
            let day: Double
            let night: Double
            let eve: Double
            let morn: Double
        }
        
        enum CodingKeys: String, CodingKey {
            case dt, sunrise, sunset, moonrise, moonset, summary, temp, pressure, humidity, weather, clouds, pop, uvi
            case moonPhase = "moon_phase"
            case feelsLike = "feels_like"
            case dewPoint = "dew_point"
            case windSpeed = "wind_speed"
            case windDeg = "wind_deg"
            case windGust = "wind_gust"
        }
    }
    
    // MARK: - Weather
    // Represents a single weather condition
    struct Weather: Codable {
        let id: Int // Weather condition ID
        let main: String // Group of weather parameters (Rain, Snow, etc.)
        let description: String // Description (e.g., "light rain")
        let icon: String // Weather icon code
    }
    
    // MARK: - Coding Keys
    // Map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone, current, hourly, daily
        case timezoneOffset = "timezone_offset"
    }
}
