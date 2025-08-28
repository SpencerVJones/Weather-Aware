//  WeatherData.swift
//  WeatherAware
//  Created by Spencer Jones on 8/10/25

/*
Represents current weather information from a weather API.
Includes main weather parameters, an array of weather conditions, wind data, and the location name.
*/

struct WeatherData: Codable {
    let main: Main // Main weather measurements (temperature, humidity, etc.)
    let weather: [Weather] // Array of weather conditions (e.g., Rain, Clouds)
    let wind: Wind // Wind information
    let name: String // Name of the location (e.g., "San Francisco")
    
    // MARK: - Main
    // Contains temperature and humidity measurements
    struct Main: Codable {
        let temp: Double // Current temperature
        let feels_like: Double // Feels like temperature
        let temp_min: Double // Minimum temperature
        let temp_max: Double // Maximum temperature
        let humidity: Int // Humidity percentage
    }
    
    // MARK: - Weather
    // Represents a single weather condition
    struct Weather: Codable {
        let id: Int // Weather condition ID
        let main: String // Group of weather parameters (e.g., "Rain", "Clouds")
        let description: String // Description of the weather (e.g., "light rain")
        let icon: String // Weather icon code
    }
    
    // MARK: - Wind
    // Represents wind information
    struct Wind: Codable {
        let speed: Double // Wind speed
    }
}

// MARK: - ForecastData
// Represents forecast data containing a list of weather forecast items
struct ForecastData: Codable {
    let list: [ForecastItem] // Array of forecast items
    
    // MARK: - ForecastItem
    // Represents a single forecast entr
    struct ForecastItem: Codable {
        let dt: Int // Timestamp of the forecast (UNIX time)
        let main: WeatherData.Main // Main weather measurements for this forecast
        let weather: [WeatherData.Weather] // Array of weather conditions for this forecast
        let wind: WeatherData.Wind // Wind data for this forecast
        let dt_txt: String // Forecast time as a formatted string (e.g., "2025-08-27 15:00:00")
    }
}
