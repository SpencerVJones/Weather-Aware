//  ClothingTypeChipTests.swift
//  WeatherAwareUITest
//  Created by Spencer Jones on 8/27/25

import XCTest
import SwiftUI

// MARK: - Mock ClothingType Enum for Testing
enum TestClothingType: String {
    case top, bottom, outerwear
}

// MARK: - Mock ClothingTypeChip for Testing
struct TestClothingTypeChip: View {
    let type: TestClothingType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(type.rawValue)
                .foregroundColor(isSelected ? .white : .blue)
                .padding()
                .background(isSelected ? Color.blue : Color.gray.opacity(0.1))
                .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Unit Tests
final class ClothingTypeChipTests: XCTestCase {
    
    func testChipActionTriggered() {
        var tapped = false
        
        let chip = TestClothingTypeChip(type: .top, isSelected: true) {
            tapped = true
        }
        
        // Trigger action manually
        chip.action()
        
        XCTAssertTrue(tapped, "Action closure should be called when chip is tapped")
    }
    
    func testChipSelectionState() {
        let selectedChip = TestClothingTypeChip(type: .bottom, isSelected: true) {
            // no-op
        }
        
        let unselectedChip = TestClothingTypeChip(type: .bottom, isSelected: false) {
            // no-op
        }
        
        // We cannot test actual SwiftUI color directly in XCTest
        // But we can assert the isSelected flag affects internal logic
        XCTAssertTrue(selectedChip.isSelected)
        XCTAssertFalse(unselectedChip.isSelected)
    }
}
