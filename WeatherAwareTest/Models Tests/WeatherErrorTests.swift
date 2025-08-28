//  WeatherErrorTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
@testable import WeatherAware

final class WeatherErrorTests: XCTestCase {

    func testErrorDescriptions() {
        let invalidURL = WeatherError.invalidURL
        XCTAssertEqual(invalidURL.errorDescription, "Invalid URL")

        let cityNotFound = WeatherError.cityNotFound
        XCTAssertEqual(cityNotFound.errorDescription, "City not found")

        let networkError = WeatherError.networkError
        XCTAssertEqual(networkError.errorDescription, "Network error occurred")

        let decodingError = WeatherError.decodingError
        XCTAssertEqual(decodingError.errorDescription, "Failed to decode weather data")
    }
}
