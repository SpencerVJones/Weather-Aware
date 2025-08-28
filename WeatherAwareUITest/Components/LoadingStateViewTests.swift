//  LoadingStateViewTests.swift
//  WeatherAwareUITest
//  Created by Spencer Jones on 8/28/25

import XCTest
import SwiftUI

// MARK: - Mocked LoadingStateView for Testing
struct TestLoadingStateView {
    let message: String
}

// MARK: - Unit Tests
final class LoadingStateViewTests: XCTestCase {

    func testMessageStoredCorrectly() {
        let view = TestLoadingStateView(message: "Loading…")
        XCTAssertEqual(view.message, "Loading…")
    }

    func testMessageOptionalCases() {
        let emptyMessageView = TestLoadingStateView(message: "")
        XCTAssertEqual(emptyMessageView.message, "")
    }
}
