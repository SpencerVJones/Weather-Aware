//  OneCallWeatherDataTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
@testable import WeatherAware

final class OneCallWeatherDataTests: XCTestCase {

    func makeSampleData() -> OneCallWeatherData {
        let weather = OneCallWeatherData.Weather(id: 500, main: "Rain", description: "light rain", icon: "10d")

        let current = OneCallWeatherData.Current(
            dt: 1690000000,
            sunrise: 1690001000,
            sunset: 1690041000,
            temp: 22.5,
            feelsLike: 23.0,
            pressure: 1012,
            humidity: 80,
            dewPoint: 18.0,
            uvi: 5.0,
            clouds: 75,
            visibility: 10000,
            windSpeed: 5.5,
            windDeg: 180,
            windGust: 7.0,
            weather: [weather]
        )

        let hourly = OneCallWeatherData.Hourly(
            dt: 1690003600,
            temp: 23.0,
            feelsLike: 23.5,
            pressure: 1011,
            humidity: 78,
            dewPoint: 18.5,
            uvi: 5.2,
            clouds: 70,
            visibility: 10000,
            windSpeed: 4.0,
            windDeg: 190,
            windGust: nil,
            weather: [weather],
            pop: 0.2
        )

        let dailyTemp = OneCallWeatherData.Daily.Temp(day: 25, min: 18, max: 28, night: 20, eve: 24, morn: 18)
        let dailyFeels = OneCallWeatherData.Daily.FeelsLike(day: 25, night: 20, eve: 24, morn: 18)
        let daily = OneCallWeatherData.Daily(
            dt: 1690000000,
            sunrise: 1690001000,
            sunset: 1690041000,
            moonrise: 1690002000,
            moonset: 1690042000,
            moonPhase: 0.5,
            summary: "Partly cloudy",
            temp: dailyTemp,
            feelsLike: dailyFeels,
            pressure: 1012,
            humidity: 75,
            dewPoint: 18.0,
            windSpeed: 5.0,
            windDeg: 180,
            windGust: nil,
            weather: [weather],
            clouds: 70,
            pop: 0.2,
            uvi: 6.0
        )

        return OneCallWeatherData(
            lat: 37.7749,
            lon: -122.4194,
            timezone: "PST",
            timezoneOffset: -28800,
            current: current,
            hourly: [hourly],
            daily: [daily]
        )
    }

    func testEncodingAndDecoding() throws {
        let sample = makeSampleData()
        let encoder = JSONEncoder()
        let data = try encoder.encode(sample)

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(OneCallWeatherData.self, from: data)

        XCTAssertEqual(decoded.lat, sample.lat)
        XCTAssertEqual(decoded.lon, sample.lon)
        XCTAssertEqual(decoded.timezone, sample.timezone)
        XCTAssertEqual(decoded.timezoneOffset, sample.timezoneOffset)

        // Current weather
        XCTAssertEqual(decoded.current.temp, sample.current.temp)
        XCTAssertEqual(decoded.current.feelsLike, sample.current.feelsLike)
        XCTAssertEqual(decoded.current.weather.first?.main, sample.current.weather.first?.main)

        // Hourly
        XCTAssertEqual(decoded.hourly?.first?.temp, sample.hourly?.first?.temp)
        XCTAssertEqual(decoded.hourly?.first?.pop, sample.hourly?.first?.pop)

        // Daily
        XCTAssertEqual(decoded.daily.first?.temp.day, sample.daily.first?.temp.day)
        XCTAssertEqual(decoded.daily.first?.summary, sample.daily.first?.summary)
    }

    func testDecodingFromJSON() throws {
        let json = """
        {
            "lat": 37.7749,
            "lon": -122.4194,
            "timezone": "PST",
            "timezone_offset": -28800,
            "current": {
                "dt": 1690000000,
                "sunrise": 1690001000,
                "sunset": 1690041000,
                "temp": 22.5,
                "feels_like": 23.0,
                "pressure": 1012,
                "humidity": 80,
                "dew_point": 18.0,
                "uvi": 5.0,
                "clouds": 75,
                "visibility": 10000,
                "wind_speed": 5.5,
                "wind_deg": 180,
                "wind_gust": 7.0,
                "weather": [{"id":500,"main":"Rain","description":"light rain","icon":"10d"}]
            },
            "hourly": [],
            "daily": []
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(OneCallWeatherData.self, from: json)

        XCTAssertEqual(decoded.lat, 37.7749)
        XCTAssertEqual(decoded.current.temp, 22.5)
        XCTAssertEqual(decoded.current.weather.first?.description, "light rain")
    }
}
