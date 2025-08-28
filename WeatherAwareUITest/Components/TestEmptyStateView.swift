//  TestEmptyStateView.swift
//  WeatherAwareUITest
//  Created by Spencer Jones on 8/28/25

import XCTest
import SwiftUI

// MARK: - Mocked EmptyStateView for Testing
struct TestEmptyStateView {
    let icon: String
    let title: String
    let message: String
    let actionTitle: String?
    let hasAction: Bool
}

// MARK: - Unit Tests
final class EmptyStateViewTests: XCTestCase {

    func testPropertiesStoredCorrectly() {
        let view = TestEmptyStateView(
            icon: "tray",
            title: "No Items Found",
            message: "Please add items.",
            actionTitle: "Add",
            hasAction: true
        )
        
        XCTAssertEqual(view.icon, "tray")
        XCTAssertEqual(view.title, "No Items Found")
        XCTAssertEqual(view.message, "Please add items.")
        XCTAssertEqual(view.actionTitle, "Add")
        XCTAssertTrue(view.hasAction)
    }

    func testButtonOptionalBehavior() {
        // Case where actionTitle is nil
        let view1 = TestEmptyStateView(
            icon: "tray",
            title: "No Items",
            message: "Empty",
            actionTitle: nil,
            hasAction: false
        )
        XCTAssertNil(view1.actionTitle)
        XCTAssertFalse(view1.hasAction)
        
        // Case where actionTitle exists but no action closure
        let view2 = TestEmptyStateView(
            icon: "tray",
            title: "No Items",
            message: "Empty",
            actionTitle: "Add",
            hasAction: false
        )
        XCTAssertEqual(view2.actionTitle, "Add")
        XCTAssertFalse(view2.hasAction)
    }
}
