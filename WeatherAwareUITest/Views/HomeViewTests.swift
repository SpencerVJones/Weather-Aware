//  HomeViewTests.swift
//  WeatherAwareUITest
//  Created by Spencer Jones on 8/27/25

import XCTest
import SwiftUI
import CoreLocation
import Combine

@testable import WeatherAware

// MARK: - Mock Models

struct MockWeather {
    let temp: Double
    let description: String
}

class MockWeatherService: ObservableObject {
    @Published var currentWeather: MockWeather? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func fetchWeather(lat: Double, lon: Double) async {
        // simulate async fetch
        await MainActor.run {
            self.currentWeather = MockWeather(temp: 72, description: "Sunny")
        }
    }
}

class MockLocationManager: ObservableObject {
    @Published var lastLocation: CLLocation? = CLLocation(latitude: 35.789, longitude: -78.644)
    @Published var cityName: String? = "Cary"
    
    func request() {
        // simulate location request
    }
}

class MockRecommendationEngine: ObservableObject {
    @Published var currentRecommendation: String? = "T-Shirt and Shorts"
    
    func generateRecommendation(for weather: MockWeather) {
        currentRecommendation = weather.temp > 70 ? "Shorts and Tee" : "Jacket"
    }
}

// MARK: - HomeView (Testable Version)

struct HomeViewTestable: View {
    @StateObject var weatherService = MockWeatherService()
    @StateObject var locationManager = MockLocationManager()
    @StateObject var recommendationEngine = MockRecommendationEngine()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Location header
                Text(locationManager.cityName ?? "Unknown Location")
                    .font(.headline)
                
                if weatherService.isLoading {
                    ProgressView("Loading weather...")
                } else if let weather = weatherService.currentWeather {
                    VStack(spacing: 10) {
                        Text("Temp: \(weather.temp, specifier: "%.1f")°F")
                        Text("Desc: \(weather.description)")
                        Text("Recommendation: \(recommendationEngine.currentRecommendation ?? "")")
                    }
                } else if let error = weatherService.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    Text("Getting your local weather…")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .task { await weatherService.fetchWeather(lat: 35.789, lon: -78.644) }
        }
    }
}

// MARK: - Tests

final class HomeViewTests: XCTestCase {
    
    func testInitialViewState() {
        let view = HomeViewTestable()
        XCTAssertNotNil(view)
    }
    
    func testWeatherFetch() async {
        let service = MockWeatherService()
        await service.fetchWeather(lat: 0, lon: 0)
        XCTAssertNotNil(service.currentWeather)
        XCTAssertEqual(service.currentWeather?.description, "Sunny")
    }
    
    func testRecommendationGeneration() {
        let engine = MockRecommendationEngine()
        let weather = MockWeather(temp: 75, description: "Sunny")
        engine.generateRecommendation(for: weather)
        XCTAssertEqual(engine.currentRecommendation, "Shorts and Tee")
    }
    
    func testLocationManager() {
        let location = MockLocationManager()
        XCTAssertEqual(location.cityName, "Cary")
        XCTAssertNotNil(location.lastLocation)
    }
}
