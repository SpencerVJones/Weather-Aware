//  IconHelpersTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
import SwiftUI
@testable import WeatherAware

final class IconHelpersTests: XCTestCase {
    
    // MARK: - Clothing Type Icons
    func testIconForClothingType() {
        XCTAssertEqual(iconForClothingType(.top), "tshirt.fill")
        XCTAssertEqual(iconForClothingType(.bottom), "rectangle.fill")
        XCTAssertEqual(iconForClothingType(.outerwear), "jacket")
        XCTAssertEqual(iconForClothingType(.shoes), "shoe.2.fill")
        XCTAssertEqual(iconForClothingType(.accessory), "eyeglasses")
    }
    
    func testColorForClothingType() {
        XCTAssertEqual(colorForClothingType(.top), Color.blue)
        XCTAssertEqual(colorForClothingType(.bottom), Color.purple)
        XCTAssertEqual(colorForClothingType(.outerwear), Color.green)
        XCTAssertEqual(colorForClothingType(.shoes), Color.brown)
        XCTAssertEqual(colorForClothingType(.accessory), Color.orange)
    }
    
    // MARK: - Weather Type Icons
    func testIconForWeatherType() {
        XCTAssertEqual(iconForWeatherType(.sunny), "sun.max.fill")
        XCTAssertEqual(iconForWeatherType(.cloudy), "cloud.fill")
        XCTAssertEqual(iconForWeatherType(.rainy), "cloud.rain.fill")
        XCTAssertEqual(iconForWeatherType(.snowy), "snow")
        XCTAssertEqual(iconForWeatherType(.windy), "wind")
    }
    
    // MARK: - Weather Condition Icons
    func testIconForWeatherCondition() {
        XCTAssertEqual(iconForWeatherCondition("light rain"), "cloud.rain.fill")
        XCTAssertEqual(iconForWeatherCondition("Heavy Snow"), "snow")
        XCTAssertEqual(iconForWeatherCondition("partly cloudy"), "cloud.fill")
        XCTAssertEqual(iconForWeatherCondition("windy"), "wind")
        XCTAssertEqual(iconForWeatherCondition("sunny"), "sun.max.fill")
        XCTAssertEqual(iconForWeatherCondition("clear sky"), "sun.max.fill") // fallback
    }
}
