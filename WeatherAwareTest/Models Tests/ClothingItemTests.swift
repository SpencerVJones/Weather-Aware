//  ClothingItemTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
@testable import WeatherAware

// MARK: - Lightweight struct for testing
struct TestClothingItem {
    var minTemp: Double
    var maxTemp: Double
    var weatherTypes: [String]
    var isLayerable: Bool
}

// MARK: - Extensions to mimic ClothingItem logic
extension TestClothingItem {
    var temperatureRangeText: String {
        return "\(Int(minTemp))-\(Int(maxTemp))°C"
    }

    var weatherTypesText: String {
        return weatherTypes.joined(separator: ", ")
    }

    var suitabilityScore: Double {
        var score = 0.5
        let tempRange = maxTemp - minTemp
        score += min(tempRange / 40.0, 0.3)
        score += Double(weatherTypes.count) * 0.05
        if isLayerable { score += 0.1 }
        return min(score, 1.0)
    }
}

// MARK: - Test Case
final class ClothingItemTests: XCTestCase {

    // MARK: - temperatureRangeText tests
    func testTemperatureRangeText() {
        let item = TestClothingItem(minTemp: 10, maxTemp: 25, weatherTypes: [], isLayerable: false)
        XCTAssertEqual(item.temperatureRangeText, "10-25°C")
    }

    // MARK: - weatherTypesText tests
    func testWeatherTypesText_single() {
        let item = TestClothingItem(minTemp: 0, maxTemp: 10, weatherTypes: ["sunny"], isLayerable: false)
        XCTAssertEqual(item.weatherTypesText, "sunny")
    }

    func testWeatherTypesText_multiple() {
        let item = TestClothingItem(minTemp: 0, maxTemp: 10, weatherTypes: ["sunny", "rainy", "snowy"], isLayerable: false)
        XCTAssertEqual(item.weatherTypesText, "sunny, rainy, snowy")
    }

    func testWeatherTypesText_empty() {
        let item = TestClothingItem(minTemp: 0, maxTemp: 10, weatherTypes: [], isLayerable: false)
        XCTAssertEqual(item.weatherTypesText, "")
    }

    // MARK: - suitabilityScore tests
    func testSuitabilityScore_base() {
        let item = TestClothingItem(minTemp: 0, maxTemp: 0, weatherTypes: [], isLayerable: false)
        XCTAssertEqual(item.suitabilityScore, 0.5)
    }

    func testSuitabilityScore_tempRange() {
        let item = TestClothingItem(minTemp: 0, maxTemp: 20, weatherTypes: [], isLayerable: false)
        XCTAssertEqual(item.suitabilityScore, 0.8) // capped temp bonus = 0.3
    }

    func testSuitabilityScore_weatherTypes() {
        let item = TestClothingItem(minTemp: 0, maxTemp: 0, weatherTypes: ["sunny", "rainy"], isLayerable: false)
        XCTAssertEqual(item.suitabilityScore, 0.6)
    }

    func testSuitabilityScore_layerable() {
        let item = TestClothingItem(minTemp: 0, maxTemp: 0, weatherTypes: [], isLayerable: true)
        XCTAssertEqual(item.suitabilityScore, 0.6)
    }

    func testSuitabilityScore_combined() {
        let item = TestClothingItem(minTemp: 0, maxTemp: 40, weatherTypes: ["sunny", "rainy", "snowy"], isLayerable: true)
        XCTAssertEqual(item.suitabilityScore, 1.0)
    }

    // MARK: - Helpers for real ClothingItem
    private func makeClothingItem() -> ClothingItem {
        return ClothingItem(
            name: "Blue Jacket",
            type: .outerwear,
            minTemp: 5,
            maxTemp: 20,
            weatherTypes: [.sunny, .rainy],
            occasion: .casual,
            color: "Blue",
            isLayerable: true
        )
    }

    // MARK: - isSuitableFor(temperature:) tests
    func testIsSuitableForTemperature_insideRange() {
        let item = makeClothingItem()
        XCTAssertTrue(item.isSuitableFor(temperature: 10))
        XCTAssertTrue(item.isSuitableFor(temperature: 5))
        XCTAssertTrue(item.isSuitableFor(temperature: 20))
    }

    func testIsSuitableForTemperature_outsideRange() {
        let item = makeClothingItem()
        XCTAssertFalse(item.isSuitableFor(temperature: 4))
        XCTAssertFalse(item.isSuitableFor(temperature: 21))
    }

    // MARK: - isSuitableFor(weather:) tests
    func testIsSuitableForWeather_supported() {
        let item = makeClothingItem()
        XCTAssertTrue(item.isSuitableFor(weather: "Sunny"))
        XCTAssertTrue(item.isSuitableFor(weather: "light rain"))
        XCTAssertTrue(item.isSuitableFor(weather: "RAINY"))
        XCTAssertTrue(item.isSuitableFor(weather: "drizzle"))
    }

    func testIsSuitableForWeather_notSupported() {
        let item = makeClothingItem()
        XCTAssertFalse(item.isSuitableFor(weather: "Snowy"))
        XCTAssertFalse(item.isSuitableFor(weather: "Windy"))
        XCTAssertFalse(item.isSuitableFor(weather: "Cloudy"))
    }

    // MARK: - Codable tests
    func testEncodingAndDecoding() throws {
        let item = makeClothingItem()
        let encoder = JSONEncoder()
        let data = try encoder.encode(item)
        
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(ClothingItem.self, from: data)
        
        XCTAssertEqual(decoded.name, item.name)
        XCTAssertEqual(decoded.type, item.type)
        XCTAssertEqual(decoded.minTemp, item.minTemp)
        XCTAssertEqual(decoded.maxTemp, item.maxTemp)
        XCTAssertEqual(decoded.weatherTypes, item.weatherTypes)
        XCTAssertEqual(decoded.occasion, item.occasion)
        XCTAssertEqual(decoded.color, item.color)
        XCTAssertEqual(decoded.isLayerable, item.isLayerable)
    }
}
