//  RecommendationUtilsTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
import SwiftUI
@testable import WeatherAware

final class RecommendationUtilsTests: XCTestCase {

    let top = ClothingItem(
        name: "T-Shirt",
        type: .top,
        minTemp: 60,
        maxTemp: 85,
        weatherTypes: [.sunny, .cloudy],
        occasion: .casual,
        color: "blue",
        isLayerable: false
    )

    let bottom = ClothingItem(
        name: "Jeans",
        type: .bottom,
        minTemp: 50,
        maxTemp: 85,
        weatherTypes: [.sunny, .cloudy],
        occasion: .casual,
        color: "purple",
        isLayerable: false
    )

    let shoes = ClothingItem(
        name: "Sneakers",
        type: .shoes,
        minTemp: 40,
        maxTemp: 90,
        weatherTypes: [.sunny, .rainy],
        occasion: .casual,
        color: "brown",
        isLayerable: false
    )

    let outerwear = ClothingItem(
        name: "Jacket",
        type: .outerwear,
        minTemp: 30,
        maxTemp: 60,
        weatherTypes: [.rainy, .snowy],
        occasion: .casual,
        color: "green",
        isLayerable: true
    )

    // Example test
    func testCalculateConfidence_withAllEssentialItems() {
        let items = [top, bottom, shoes]
        let score = RecommendationUtils.calculateConfidence(for: items, temperature: 70, weatherCondition: "sunny")
        XCTAssertGreaterThan(score, 0.9)
    }
}
