//  ColorMappingTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
import SwiftUI
@testable import WeatherAware

final class ColorMappingTests: XCTestCase {

    // MARK: - clothingColor(for:)
    func testClothingColorMapping() {
        XCTAssertEqual(Color.clothingColor(for: .top), .blue)
        XCTAssertEqual(Color.clothingColor(for: .bottom), .purple)
        XCTAssertEqual(Color.clothingColor(for: .outerwear), .green)
        XCTAssertEqual(Color.clothingColor(for: .shoes), .brown)
        XCTAssertEqual(Color.clothingColor(for: .accessory), .orange)
    }

    // MARK: - weatherConditionColor(for:)
    func testWeatherConditionColorMapping() {
        XCTAssertEqual(Color.weatherConditionColor(for: "Light rain"), .blue)
        XCTAssertEqual(Color.weatherConditionColor(for: "Snowstorm"), .cyan)
        XCTAssertEqual(Color.weatherConditionColor(for: "Cloudy"), .gray)
        XCTAssertEqual(Color.weatherConditionColor(for: "Windy"), .green)
        
        // Fallback for unknown conditions
        XCTAssertEqual(Color.weatherConditionColor(for: "Sunny"), .orange)
    }
}
