//  OneCallWeatherData.swift
//  WeatherAware
//  Created by Spencer Jones on 8/10/25

import Foundation

struct OneCallWeatherData: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let hourly: [Hourly]?
    let daily: [Daily]
    
    struct Current: Codable {
        let dt: Int
        let sunrise: Int?
        let sunset: Int?
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
        
        enum CodingKeys: String, CodingKey {
            case dt, sunrise, sunset, temp, pressure, humidity, uvi, clouds, visibility, weather
            case feelsLike = "feels_like"
            case dewPoint = "dew_point"
            case windSpeed = "wind_speed"
            case windDeg = "wind_deg"
            case windGust = "wind_gust"
        }
    }
    
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
    
    struct Daily: Codable {
        let dt: Int
        let sunrise: Int
        let sunset: Int
        let moonrise: Int
        let moonset: Int
        let moonPhase: Double
        let summary: String?
        let temp: Temp
        let feelsLike: FeelsLike
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
        
        struct Temp: Codable {
            let day: Double
            let min: Double
            let max: Double
            let night: Double
            let eve: Double
            let morn: Double
        }
        
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
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone, current, hourly, daily
        case timezoneOffset = "timezone_offset"
    }
}
