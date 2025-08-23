//  WeatherData.swift
//  WeatherAware
//  Created by Spencer Jones on 8/10/25


struct WeatherData: Codable {
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let name: String
    
    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let humidity: Int
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Wind: Codable {
        let speed: Double
    }
}

struct ForecastData: Codable {
    let list: [ForecastItem]
    
    struct ForecastItem: Codable {
        let dt: Int
        let main: WeatherData.Main
        let weather: [WeatherData.Weather]
        let wind: WeatherData.Wind
        let dt_txt: String
    }
}
