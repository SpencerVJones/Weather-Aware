//  ErrorExtensionTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
@testable import WeatherAware

final class ErrorExtensionTests: XCTestCase {
    
    func testFriendlyMessage_withWeatherError_returnsLocalizedDescription() {
        let error: Error = WeatherError.invalidURL
        XCTAssertEqual(error.friendlyMessage, WeatherError.invalidURL.localizedDescription)
        
        let error2: Error = WeatherError.cityNotFound
        XCTAssertEqual(error2.friendlyMessage, WeatherError.cityNotFound.localizedDescription)
        
        let error3: Error = WeatherError.networkError
        XCTAssertEqual(error3.friendlyMessage, WeatherError.networkError.localizedDescription)
        
        let error4: Error = WeatherError.decodingError
        XCTAssertEqual(error4.friendlyMessage, WeatherError.decodingError.localizedDescription)
    }
    
    func testFriendlyMessage_withGenericError_returnsFallbackMessage() {
        struct TestError: Error {}
        let error = TestError()
        XCTAssertEqual(error.friendlyMessage, "Something went wrong. Please try again.")
    }
}

