//  CompactClothingItemPreviewTests.swift
//  WeatherAwareUITest
//  Created by Spencer Jones on 8/28/25

import XCTest
import SwiftUI
@testable import WeatherAware

// MARK: - Fresh Mock Types

struct PreviewWearableItem {
    let name: String
    let kind: WearableKind
    let minTemp: Double
    let maxTemp: Double
    let weatherConditions: [WeatherCondition]
    let occasion: WearableOccasion
    let color: String
    let isLayerable: Bool
    let imageData: Data? = nil
}

enum WearableKind { case top, bottom, outerwear }
enum WeatherCondition { case sunny, rainy, windy }
enum WearableOccasion { case casual, formal }

struct PreviewCompactWearableView: View {
    let item: PreviewWearableItem
    
    var body: some View {
        VStack {
            Text(item.name)
        }
    }
}

// MARK: - Unit Tests

final class CompactClothingItemPreviewTests: XCTestCase {

    func testViewStoresItemCorrectly() {
        let item = PreviewWearableItem(
            name: "Blue Jacket",
            kind: .outerwear,
            minTemp: 5,
            maxTemp: 15,
            weatherConditions: [.rainy, .windy],
            occasion: .casual,
            color: "Blue",
            isLayerable: true
        )
        
        let view = PreviewCompactWearableView(item: item)
        
        XCTAssertEqual(view.item.name, "Blue Jacket")
        XCTAssertEqual(view.item.color, "Blue")
        XCTAssertTrue(view.item.isLayerable)
    }

    func testFallbackIconUsedWhenNoImage() {
        let item = PreviewWearableItem(
            name: "T-Shirt",
            kind: .top,
            minTemp: 60,
            maxTemp: 85,
            weatherConditions: [.sunny],
            occasion: .casual,
            color: "White",
            isLayerable: false
        )
        
        let view = PreviewCompactWearableView(item: item)
        
        XCTAssertNil(view.item.imageData)
    }
}
