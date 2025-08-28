//  OutfitRecommendationTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
@testable import WeatherAware

final class OutfitRecommendationTests: XCTestCase {

    func makeSampleClothingItem() -> ClothingItem {
        return ClothingItem(
            name: "Blue Jacket",
            type: .outerwear,
            minTemp: 10,
            maxTemp: 20,
            weatherTypes: [.sunny, .rainy],
            occasion: .casual,
            color: "Blue",
            isLayerable: true
        )
    }

    func testInitializationWithDate() {
        let item = makeSampleClothingItem()
        let date = Date()
        let outfit = OutfitRecommendation(
            items: [item],
            weatherCondition: "Sunny",
            temperature: 15.0,
            confidence: 0.85,
            date: date
        )

        XCTAssertEqual(outfit.items.count, 1)
        XCTAssertEqual(outfit.items.first?.name, "Blue Jacket")
        XCTAssertEqual(outfit.weatherCondition, "Sunny")
        XCTAssertEqual(outfit.temperature, 15.0)
        XCTAssertEqual(outfit.confidence, 0.85)
        XCTAssertEqual(outfit.date, date)
    }

    func testInitializationWithoutDate() {
        let item = makeSampleClothingItem()
        let outfit = OutfitRecommendation(
            items: [item],
            weatherCondition: "Rainy",
            temperature: 12.0,
            confidence: 0.9
        )

        XCTAssertEqual(outfit.items.count, 1)
        XCTAssertEqual(outfit.weatherCondition, "Rainy")
        XCTAssertEqual(outfit.temperature, 12.0)
        XCTAssertEqual(outfit.confidence, 0.9)

        // The date should be close to now
        XCTAssertLessThan(abs(outfit.date.timeIntervalSinceNow), 1.0)
    }
}
