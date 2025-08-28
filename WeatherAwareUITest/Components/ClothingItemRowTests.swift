//  ClothingItemRowTests.swift
//  WeatherAwareUITest
//  Created by Spencer Jones on 8/27/25

import XCTest
import SwiftUI

// MARK: - Mock Models (Renamed)


struct UITestClothingItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let color: String
    let minTemp: Double
    let maxTemp: Double
    let occasion: String
    let isLayerable: Bool
    let weatherTypes: [String]
}

// MARK: - Mock Row View (Renamed)
struct UITestClothingItemRow: View {
    let item: UITestClothingItem

    var body: some View {
        HStack {
            Text(item.name)
            Text(item.type)
            Text(item.color)
            Text("\(Int(item.minTemp))-\(Int(item.maxTemp))°F")
            Text(item.occasion)
            if item.isLayerable {
                Text("Layerable")
            }
            HStack {
                ForEach(item.weatherTypes, id: \.self) { weather in
                    Text(weather)
                }
            }
        }
    }
}

// MARK: - Tests
final class ClothingItemRowTests: XCTestCase {

    func testRowDisplaysBasicInfo() {
        let item = UITestClothingItem(
            name: "Cotton T-Shirt",
            type: "Top",
            color: "White",
            minTemp: 60,
            maxTemp: 85,
            occasion: "Casual",
            isLayerable: true,
            weatherTypes: ["sunny", "rainy"]
        )

        let row = UITestClothingItemRow(item: item)

        XCTAssertEqual(row.item.name, "Cotton T-Shirt")
        XCTAssertEqual(row.item.type, "Top")
        XCTAssertEqual(row.item.color, "White")
        XCTAssertEqual(row.item.minTemp, 60)
        XCTAssertEqual(row.item.maxTemp, 85)
        XCTAssertEqual(row.item.occasion, "Casual")
        XCTAssertTrue(row.item.isLayerable)
        XCTAssertEqual(row.item.weatherTypes, ["sunny", "rainy"])
    }

    func testRowWithoutLayerableShowsCorrectly() {
        let item = UITestClothingItem(
            name: "Jacket",
            type: "Outerwear",
            color: "Black",
            minTemp: 45,
            maxTemp: 60,
            occasion: "Formal",
            isLayerable: false,
            weatherTypes: ["cloudy"]
        )

        let row = UITestClothingItemRow(item: item)

        XCTAssertFalse(row.item.isLayerable)
        XCTAssertEqual(row.item.weatherTypes, ["cloudy"])
    }
}
