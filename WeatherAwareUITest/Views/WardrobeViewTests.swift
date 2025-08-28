//  WardrobeViewTests.swift
//  WeatherAwareUITest
//  Created by Spencer Jones on 8/27/25

import XCTest
import SwiftUI
@testable import WeatherAware


// MARK: - Mock Classes

// Mock wardrobe manager for testing
class TestWardrobeManager: ObservableObject {
    @Published private(set) var items: [TestClothingItem] = []

    func addItem(_ item: TestClothingItem) {
        items.append(item)
    }

    func removeItem(at offsets: IndexSet) {
        for index in offsets.sorted(by: >) {
            if items.indices.contains(index) {
                items.remove(at: index)
            }
        }
    }
}

// Mock clothing item for testing
struct TestClothingItem: Identifiable {
    let id = UUID()
    let name: String
}

// MARK: - Unit Tests

final class WardrobeViewTests: XCTestCase {

    func testEmptyWardrobeShowsPlaceholder() {
        let manager = TestWardrobeManager()
        XCTAssertTrue(manager.items.isEmpty)
    }

    func testAddingClothingItem() {
        let manager = TestWardrobeManager()
        let item = TestClothingItem(name: "T-Shirt")
        manager.addItem(item)
        XCTAssertEqual(manager.items.count, 1)
        XCTAssertEqual(manager.items.first?.name, "T-Shirt")
    }

    func testDeletingClothingItem() {
        let manager = TestWardrobeManager()
        let item1 = TestClothingItem(name: "T-Shirt")
        let item2 = TestClothingItem(name: "Jacket")
        manager.addItem(item1)
        manager.addItem(item2)

        manager.removeItem(at: IndexSet(integer: 0))

        XCTAssertEqual(manager.items.count, 1)
        XCTAssertEqual(manager.items.first?.name, "Jacket")
    }
}
