//  WeatherUtilsTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
import SwiftUI
@testable import WeatherAware

final class WeatherUtilsTests: XCTestCase {

    // MARK: - UV Index Tests
    func testUVIndexDescription() {
        XCTAssertEqual(WeatherUtils.uvIndexDescription(0), "Low")
        XCTAssertEqual(WeatherUtils.uvIndexDescription(2.9), "Low")
        XCTAssertEqual(WeatherUtils.uvIndexDescription(3), "Moderate")
        XCTAssertEqual(WeatherUtils.uvIndexDescription(5.9), "Moderate")
        XCTAssertEqual(WeatherUtils.uvIndexDescription(6), "High")
        XCTAssertEqual(WeatherUtils.uvIndexDescription(7.9), "High")
        XCTAssertEqual(WeatherUtils.uvIndexDescription(8), "Very High")
        XCTAssertEqual(WeatherUtils.uvIndexDescription(10.9), "Very High")
        XCTAssertEqual(WeatherUtils.uvIndexDescription(11), "Extreme")
        XCTAssertEqual(WeatherUtils.uvIndexDescription(15), "Extreme")
    }
    
    func testUVIndexColor() {
        XCTAssertEqual(WeatherUtils.uvIndexColor(0), .green)
        XCTAssertEqual(WeatherUtils.uvIndexColor(4), .yellow)
        XCTAssertEqual(WeatherUtils.uvIndexColor(6.5), .orange)
        XCTAssertEqual(WeatherUtils.uvIndexColor(9), .red)
        XCTAssertEqual(WeatherUtils.uvIndexColor(11), .purple)
    }
    
    // MARK: - Wind Speed Tests
    func testWindSpeedDescription() {
        XCTAssertEqual(WeatherUtils.windSpeedDescription(0), "Calm")
        XCTAssertEqual(WeatherUtils.windSpeedDescription(0.5), "Calm")
        XCTAssertEqual(WeatherUtils.windSpeedDescription(2), "Light breeze")
        XCTAssertEqual(WeatherUtils.windSpeedDescription(5), "Moderate breeze")
        XCTAssertEqual(WeatherUtils.windSpeedDescription(9), "Fresh breeze")
        XCTAssertEqual(WeatherUtils.windSpeedDescription(13), "Strong breeze")
        XCTAssertEqual(WeatherUtils.windSpeedDescription(20), "Gale")
        XCTAssertEqual(WeatherUtils.windSpeedDescription(30), "Storm")
    }
    
    // MARK: - Humidity Tests
    func testHumidityDescription() {
        XCTAssertEqual(WeatherUtils.humidityDescription(10), "Dry")
        XCTAssertEqual(WeatherUtils.humidityDescription(40), "Comfortable")
        XCTAssertEqual(WeatherUtils.humidityDescription(70), "Humid")
        XCTAssertEqual(WeatherUtils.humidityDescription(85), "Very humid")
    }
    
    // MARK: - Precipitation Probability Tests
    func testPrecipitationDescription() {
        XCTAssertEqual(WeatherUtils.precipitationDescription(0.0), "No rain expected")
        XCTAssertEqual(WeatherUtils.precipitationDescription(0.05), "No rain expected")
        XCTAssertEqual(WeatherUtils.precipitationDescription(0.2), "Light chance of rain")
        XCTAssertEqual(WeatherUtils.precipitationDescription(0.4), "Moderate chance of rain")
        XCTAssertEqual(WeatherUtils.precipitationDescription(0.7), "High chance of rain")
        XCTAssertEqual(WeatherUtils.precipitationDescription(0.9), "Rain very likely")
    }
}
