//  WeatherServiceTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
@testable import WeatherAware

final class WeatherServiceTests: XCTestCase {
    
    // Mock WeatherService that overrides the network methods
    final class MockWeatherService: WeatherService {
        var fetchCityCalled = false
        var fetchLatLonCalled = false
        var simulateError: Bool = false
        
        override func fetchWeatherForCity(_ cityName: String) async {
            fetchCityCalled = true
            if simulateError {
                await MainActor.run {
                    self.errorMessage = "Mock error"
                    self.isLoading = false
                }
            } else {
                await MainActor.run {
                    let current = OneCallWeatherData.Current(
                        dt: 123,
                        sunrise: nil,
                        sunset: nil,
                        temp: 70,
                        feelsLike: 70,
                        pressure: 1010,
                        humidity: 50,
                        dewPoint: 0,
                        uvi: 0,
                        clouds: 10,
                        visibility: 10000,
                        windSpeed: 5,
                        windDeg: nil,
                        windGust: nil,
                        weather: [
                            OneCallWeatherData.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")
                        ]
                    )
                    self.currentWeather = OneCallWeatherData(
                        lat: 10,
                        lon: 20,
                        timezone: "UTC",
                        timezoneOffset: 0,
                        current: current,
                        hourly: nil,
                        daily: []
                    )
                    self.isLoading = false
                }
            }
        }
        
        override func fetchWeather(lat: Double, lon: Double) async {
            fetchLatLonCalled = true
            await fetchWeatherForCity("MockCity") // reuse same mock logic
        }
    }
    
    func testFetchWeatherForCity_success_setsCurrentWeather() async {
        let service = MockWeatherService()
        await service.fetchWeatherForCity("TestCity")
        
        XCTAssertTrue(service.fetchCityCalled)
        XCTAssertNotNil(service.currentWeather)
        XCTAssertNil(service.errorMessage)
        XCTAssertFalse(service.isLoading)
    }
    
    func testFetchWeatherForCity_error_setsErrorMessage() async {
        let service = MockWeatherService()
        service.simulateError = true
        await service.fetchWeatherForCity("TestCity")
        
        XCTAssertEqual(service.errorMessage, "Mock error")
        XCTAssertFalse(service.isLoading)
        XCTAssertNil(service.currentWeather)
    }
    
    func testFetchWeather_latLon_callsCityFetch() async {
        let service = MockWeatherService()
        await service.fetchWeather(lat: 10, lon: 20)
        
        XCTAssertTrue(service.fetchLatLonCalled)
        XCTAssertNotNil(service.currentWeather)
    }
}
