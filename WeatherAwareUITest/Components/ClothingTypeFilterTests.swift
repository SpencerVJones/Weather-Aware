//  ClothingTypeFilterTests.swift
//  WeatherAwareUITest
//  Created by Spencer Jones on 8/28/25

import XCTest
import SwiftUI

import XCTest
import SwiftUI

// MARK: - Unique Mock ClothingType Enum
enum FilterTestClothingType: CaseIterable, Hashable {
    case top, bottom, outerwear
}

// MARK: - Unique Mock ClothingTypeChip
struct FilterTestClothingTypeChip: View {
    let type: FilterTestClothingType
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("\(type)")
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Unique Mock ClothingTypeFilter
struct FilterTestClothingTypeFilter {
    var selectedTypes: Set<FilterTestClothingType>

    mutating func toggle(_ type: FilterTestClothingType) {
        if selectedTypes.contains(type) {
            selectedTypes.remove(type)
        } else {
            selectedTypes.insert(type)
        }
    }
}

// MARK: - Unit Tests
final class ClothingTypeFilterTests: XCTestCase {

    func testToggleSelectionAddsAndRemoves() {
        var filter = FilterTestClothingTypeFilter(selectedTypes: [.top])

        // Initially contains top
        XCTAssertTrue(filter.selectedTypes.contains(.top))
        XCTAssertFalse(filter.selectedTypes.contains(.bottom))

        // Toggling top should remove it
        filter.toggle(.top)
        XCTAssertFalse(filter.selectedTypes.contains(.top))

        // Toggling bottom should add it
        filter.toggle(.bottom)
        XCTAssertTrue(filter.selectedTypes.contains(.bottom))
    }

    func testMultipleSelections() {
        var filter = FilterTestClothingTypeFilter(selectedTypes: [])

        // Add all types
        for type in FilterTestClothingType.allCases {
            filter.toggle(type)
        }

        XCTAssertEqual(filter.selectedTypes, Set(FilterTestClothingType.allCases))

        // Remove all types
        for type in FilterTestClothingType.allCases {
            filter.toggle(type)
        }

        XCTAssertTrue(filter.selectedTypes.isEmpty)
    }
}
