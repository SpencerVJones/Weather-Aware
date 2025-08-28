//  RecommendationEngineTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
import CoreData
@testable import WeatherAware

final class RecommendationEngineTests: XCTestCase {

    var engine: RecommendationEngine!
    var wardrobeManager: WardrobeManager!
    
    override func setUp() {
        super.setUp()
        
        // Create an in-memory Core Data stack for testing
        let container = NSPersistentContainer(name: "WeatherAware")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            XCTAssertNil(error)
        }
        
        // Initialize WardrobeManager with the in-memory context
        wardrobeManager = WardrobeManager(viewContext: container.viewContext)
        
        // Add test items directly
        let top = ClothingItem(name: "T-Shirt", type: .top, minTemp: 60, maxTemp: 80, weatherTypes: [.sunny], occasion: .casual, color: "Blue", isLayerable: false)
        let bottom = ClothingItem(name: "Shorts", type: .bottom, minTemp: 60, maxTemp: 85, weatherTypes: [.sunny], occasion: .casual, color: "Gray", isLayerable: false)
        let shoes = ClothingItem(name: "Sneakers", type: .shoes, minTemp: 50, maxTemp: 90, weatherTypes: [.sunny], occasion: .casual, color: "White", isLayerable: false)
        wardrobeManager.clothingItems = [top, bottom, shoes]
        
        engine = RecommendationEngine(wardrobeManager: wardrobeManager)
    }
    
    func testGenerateRecommendation_basicItems_returnsOutfit() {
        // Create minimal weather data
        let weather = OneCallWeatherData(
            lat: 0, lon: 0, timezone: "PST", timezoneOffset: 0,
            current: .init(dt: 0, sunrise: nil, sunset: nil, temp: 70, feelsLike: 70,
                           pressure: 1013, humidity: 50, dewPoint: 50, uvi: 5,
                           clouds: 10, visibility: nil, windSpeed: 5, windDeg: nil,
                           windGust: nil, weather: [.init(id: 800, main: "Clear", description: "Clear sky", icon: "01d")]),
            hourly: nil,
            daily: []
        )
        
        // Act
        engine.generateRecommendation(for: weather)
        
        // Assert async because RecommendationEngine updates on main thread
        let expectation = XCTestExpectation(description: "Recommendation generated")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.engine.currentRecommendation)
            XCTAssertEqual(self.engine.currentRecommendation?.items.count, 3)
            XCTAssertEqual(self.engine.currentRecommendation?.temperature, 70)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
