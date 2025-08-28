//  WeatherDataTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
@testable import WeatherAware

final class WeatherDataTests: XCTestCase {

    // MARK: - Sample JSON
    let sampleJSON = """
    {
        "main": {
            "temp": 20.5,
            "feels_like": 21.0,
            "temp_min": 18.0,
            "temp_max": 22.0,
            "humidity": 60
        },
        "weather": [
            {
                "id": 500,
                "main": "Rain",
                "description": "light rain",
                "icon": "10d"
            }
        ],
        "wind": {
            "speed": 5.5
        },
        "name": "San Francisco"
    }
    """.data(using: .utf8)!

    // MARK: - Test Initialization
    func testWeatherDataDecoding() throws {
        let decoder = JSONDecoder()
        let weather = try decoder.decode(WeatherData.self, from: sampleJSON)

        XCTAssertEqual(weather.name, "San Francisco")
        XCTAssertEqual(weather.main.temp, 20.5)
        XCTAssertEqual(weather.main.humidity, 60)
        XCTAssertEqual(weather.weather.first?.main, "Rain")
        XCTAssertEqual(weather.wind.speed, 5.5)
    }

    func testWeatherDataEncoding() throws {
        let main = WeatherData.Main(temp: 20.0, feels_like: 21.0, temp_min: 18.0, temp_max: 22.0, humidity: 55)
        let weatherCondition = WeatherData.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")
        let wind = WeatherData.Wind(speed: 3.0)
        let weather = WeatherData(main: main, weather: [weatherCondition], wind: wind, name: "London")

        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let data = try encoder.encode(weather)

        let decoded = try JSONDecoder().decode(WeatherData.self, from: data)
        XCTAssertEqual(decoded.name, "London")
        XCTAssertEqual(decoded.main.temp, 20.0)
        XCTAssertEqual(decoded.weather.first?.main, "Clear")
        XCTAssertEqual(decoded.wind.speed, 3.0)
    }

    // MARK: - ForecastData Test
    func testForecastDataDecoding() throws {
        let forecastJSON = """
        {
            "list": [
                {
                    "dt": 1693142400,
                    "main": {
                        "temp": 21.0,
                        "feels_like": 22.0,
                        "temp_min": 20.0,
                        "temp_max": 22.0,
                        "humidity": 50
                    },
                    "weather": [
                        {"id": 801, "main": "Clouds", "description": "few clouds", "icon": "02d"}
                    ],
                    "wind": {"speed": 4.0},
                    "dt_txt": "2025-08-27 15:00:00"
                }
            ]
        }
        """.data(using: .utf8)!

        let forecast = try JSONDecoder().decode(ForecastData.self, from: forecastJSON)
        XCTAssertEqual(forecast.list.count, 1)
        XCTAssertEqual(forecast.list.first?.main.temp, 21.0)
        XCTAssertEqual(forecast.list.first?.weather.first?.main, "Clouds")
        XCTAssertEqual(forecast.list.first?.wind.speed, 4.0)
        XCTAssertEqual(forecast.list.first?.dt_txt, "2025-08-27 15:00:00")
    }
}
