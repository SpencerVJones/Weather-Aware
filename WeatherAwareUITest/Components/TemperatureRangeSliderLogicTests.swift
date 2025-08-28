//  TemperatureRangeSliderLogicTests.swift
//  WeatherAwareUITest
//  Created by Spencer Jones on 8/28/25

import XCTest

// MARK: - Logic Wrapper for TemperatureRangeSlider
struct TemperatureRange {
    var minTemp: Double
    var maxTemp: Double
    let range: ClosedRange<Double>
    
    mutating func setMin(_ value: Double) {
        minTemp = value
        if minTemp >= maxTemp {
            maxTemp = minTemp + 1
        }
    }
    
    mutating func setMax(_ value: Double) {
        maxTemp = value
        if maxTemp <= minTemp {
            minTemp = maxTemp - 1
        }
    }
}

// MARK: - Unit Tests
final class TemperatureRangeSliderLogicTests: XCTestCase {
    
    func testMinCannotExceedMax() {
        var tempRange = TemperatureRange(minTemp: 10, maxTemp: 20, range: 0...40)
        tempRange.setMin(25)
        
        XCTAssertEqual(tempRange.minTemp, 25)
        XCTAssertEqual(tempRange.maxTemp, 26)
    }
    
    func testMaxCannotBeBelowMin() {
        var tempRange = TemperatureRange(minTemp: 15, maxTemp: 25, range: 0...40)
        tempRange.setMax(10)
        
        XCTAssertEqual(tempRange.maxTemp, 10)
        XCTAssertEqual(tempRange.minTemp, 9)
    }
    
    func testNormalMinMax() {
        var tempRange = TemperatureRange(minTemp: 5, maxTemp: 15, range: 0...40)
        tempRange.setMin(8)
        tempRange.setMax(12)
        
        XCTAssertEqual(tempRange.minTemp, 8)
        XCTAssertEqual(tempRange.maxTemp, 12)
    }
}
