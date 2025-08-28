//  TemperatureUtilsTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
@testable import WeatherAware

final class TemperatureUtilsTests: XCTestCase {

    func testFormatTemperature() {
        XCTAssertEqual(TemperatureUtils.formatTemperature(72.3), "72°F")
        XCTAssertEqual(TemperatureUtils.formatTemperature(68.7), "69°F")
        XCTAssertEqual(TemperatureUtils.formatTemperature(-5), "-5°F")
    }

    func testFormatTemperatureRange() {
        XCTAssertEqual(TemperatureUtils.formatTemperatureRange(68.3, 75.6), "68° - 76°F")
        XCTAssertEqual(TemperatureUtils.formatTemperatureRange(32, 50), "32° - 50°F")
    }

    func testTemperatureDescription() {
        XCTAssertEqual(TemperatureUtils.temperatureDescription(-10), "Freezing")
        XCTAssertEqual(TemperatureUtils.temperatureDescription(40), "Cold")
        XCTAssertEqual(TemperatureUtils.temperatureDescription(55), "Cool")
        XCTAssertEqual(TemperatureUtils.temperatureDescription(70), "Comfortable")
        XCTAssertEqual(TemperatureUtils.temperatureDescription(80), "Warm")
        XCTAssertEqual(TemperatureUtils.temperatureDescription(90), "Hot")
        XCTAssertEqual(TemperatureUtils.temperatureDescription(100), "Very Hot")
    }

    func testCelsiusToFahrenheit() {
        XCTAssertEqual(TemperatureUtils.celsiusToFahrenheit(0), 32)
        XCTAssertEqual(TemperatureUtils.celsiusToFahrenheit(100), 212)
        XCTAssertEqual(TemperatureUtils.celsiusToFahrenheit(-40), -40)
    }

    func testFahrenheitToCelsius() {
        XCTAssertEqual(TemperatureUtils.fahrenheitToCelsius(32), 0)
        XCTAssertEqual(TemperatureUtils.fahrenheitToCelsius(212), 100)
        XCTAssertEqual(TemperatureUtils.fahrenheitToCelsius(-40), -40)
    }
}
