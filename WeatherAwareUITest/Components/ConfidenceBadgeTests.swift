//  ConfidenceBadgeTests.swift
//  WeatherAwareUITest
//  Created by Spencer Jones on 8/28/25

import XCTest
import SwiftUI

// MARK: - Mocked ConfidenceBadge Logic
struct TestConfidenceBadge {
    let confidence: Double
    
    var confidenceIcon: String {
        switch confidence {
        case 0.8...1.0: return "checkmark.circle.fill"
        case 0.6..<0.8: return "checkmark.circle"
        case 0.4..<0.6: return "questionmark.circle"
        default: return "exclamationmark.triangle"
        }
    }
    
    var confidenceColor: Color {
        switch confidence {
        case 0.8...1.0: return .green
        case 0.6..<0.8: return .blue
        case 0.4..<0.6: return .orange
        default: return .red
        }
    }
}

// MARK: - Unit Tests
final class ConfidenceBadgeLogicTests: XCTestCase {

    func testIconMapping() {
        XCTAssertEqual(TestConfidenceBadge(confidence: 0.95).confidenceIcon, "checkmark.circle.fill")
        XCTAssertEqual(TestConfidenceBadge(confidence: 0.75).confidenceIcon, "checkmark.circle")
        XCTAssertEqual(TestConfidenceBadge(confidence: 0.5).confidenceIcon, "questionmark.circle")
        XCTAssertEqual(TestConfidenceBadge(confidence: 0.2).confidenceIcon, "exclamationmark.triangle")
    }
    
    func testColorMapping() {
        XCTAssertEqual(TestConfidenceBadge(confidence: 0.95).confidenceColor, .green)
        XCTAssertEqual(TestConfidenceBadge(confidence: 0.75).confidenceColor, .blue)
        XCTAssertEqual(TestConfidenceBadge(confidence: 0.5).confidenceColor, .orange)
        XCTAssertEqual(TestConfidenceBadge(confidence: 0.2).confidenceColor, .red)
    }
}
