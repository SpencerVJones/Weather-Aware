//  ContentViewUITests.swift
//  WeatherAwareUITest
//  Created by Spencer Jones on 8/27/25

import XCTest

final class ContentViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Stop immediately when a failure occurs
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testTabsExistAndSwitchable() throws {
        let homeTab = app.tabBars.buttons["Home"]
        let wardrobeTab = app.tabBars.buttons["Wardrobe"]
        
        // Assert tabs exist
        XCTAssertTrue(homeTab.exists, "Home tab should exist")
        XCTAssertTrue(wardrobeTab.exists, "Wardrobe tab should exist")
        
        // Tap Wardrobe tab and check selection
        wardrobeTab.tap()
        XCTAssertTrue(wardrobeTab.isSelected, "Wardrobe tab should be selected")
        XCTAssertFalse(homeTab.isSelected, "Home tab should not be selected")
        
        // Tap Home tab and check selection
        homeTab.tap()
        XCTAssertTrue(homeTab.isSelected, "Home tab should be selected")
        XCTAssertFalse(wardrobeTab.isSelected, "Wardrobe tab should not be selected")
    }
}
