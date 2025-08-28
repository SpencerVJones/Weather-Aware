//  WeatherConditionBadgeLogicTests.swift
//  WeatherAwareUITest
//  Created by Spencer Jones on 8/28/25

import XCTest
import SwiftUI

// Logic wrapper for testing without SwiftUI view
struct WeatherConditionLogic {
    static func icon(for condition: String) -> String {
        let lowercased = condition.lowercased()
        if lowercased.contains("rain") { return "cloud.rain.fill" }
        else if lowercased.contains("snow") { return "snow" }
        else if lowercased.contains("cloud") { return "cloud.fill" }
        else if lowercased.contains("wind") { return "wind" }
        else { return "sun.max.fill" }
    }
    
    static func color(for condition: String) -> Color {
        let lowercased = condition.lowercased()
        if lowercased.contains("rain") { return .blue }
        else if lowercased.contains("snow") { return .cyan }
        else if lowercased.contains("cloud") { return .gray }
        else if lowercased.contains("wind") { return .green }
        else { return .orange }
    }
}

final class WeatherConditionBadgeLogicTests: XCTestCase {
    
    func testIcons() {
        XCTAssertEqual(WeatherConditionLogic.icon(for: "Rainy"), "cloud.rain.fill")
        XCTAssertEqual(WeatherConditionLogic.icon(for: "Snowstorm"), "snow")
        XCTAssertEqual(WeatherConditionLogic.icon(for: "Cloudy"), "cloud.fill")
        XCTAssertEqual(WeatherConditionLogic.icon(for: "Windy"), "wind")
        XCTAssertEqual(WeatherConditionLogic.icon(for: "Sunny"), "sun.max.fill")
    }
    
    func testColors() {
        XCTAssertEqual(WeatherConditionLogic.color(for: "Rainy"), .blue)
        XCTAssertEqual(WeatherConditionLogic.color(for: "Snow"), .cyan)
        XCTAssertEqual(WeatherConditionLogic.color(for: "Cloudy"), .gray)
        XCTAssertEqual(WeatherConditionLogic.color(for: "Windy"), .green)
        XCTAssertEqual(WeatherConditionLogic.color(for: "Clear"), .orange)
    }
}
