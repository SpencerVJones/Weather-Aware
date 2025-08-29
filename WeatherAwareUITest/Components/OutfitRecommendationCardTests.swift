//  OutfitRecommendationCardTests.swift
//  WeatherAwareUITest
//  Created by Spencer Jones on 8/28/25

import XCTest

// MARK: - Fresh Mock Types (unique names to avoid conflicts)
struct PreviewOutfitItem {
    let name: String
    let isLayerable: Bool
}

struct PreviewOutfitRecommendation {
    let items: [PreviewOutfitItem]
    let confidence: Double
    let weatherCondition: String
    let temperature: Double
}

struct PreviewOutfitRecommendationCard {
    let recommendation: PreviewOutfitRecommendation?

    // Computed flags simulating view logic
    var showsLayering: Bool {
        guard let rec = recommendation else { return false }
        return rec.items.filter { $0.isLayerable }.count > 1
    }

    var showsPlaceholder: Bool {
        return recommendation == nil
    }
}

// MARK: - Unit Tests
final class OutfitRecommendationCardLogicTests: XCTestCase {

    func testLayeringLogic() {
        let items = [
            PreviewOutfitItem(name: "Jacket", isLayerable: true),
            PreviewOutfitItem(name: "Sweater", isLayerable: true),
            PreviewOutfitItem(name: "Sneakers", isLayerable: false)
        ]
        let recommendation = PreviewOutfitRecommendation(items: items, confidence: 0.9, weatherCondition: "Sunny", temperature: 75)
        let card = PreviewOutfitRecommendationCard(recommendation: recommendation)

        XCTAssertTrue(card.showsLayering, "Layering should be recommended when multiple layerable items exist.")
    }

    func testNoLayeringIfSingleLayerable() {
        let items = [
            PreviewOutfitItem(name: "Jacket", isLayerable: true),
            PreviewOutfitItem(name: "Sneakers", isLayerable: false)
        ]
        let recommendation = PreviewOutfitRecommendation(items: items, confidence: 0.7, weatherCondition: "Cloudy", temperature: 60)
        let card = PreviewOutfitRecommendationCard(recommendation: recommendation)

        XCTAssertFalse(card.showsLayering, "Layering should not be recommended with only one layerable item.")
    }

    func testPlaceholderShownWhenNoRecommendation() {
        let card = PreviewOutfitRecommendationCard(recommendation: nil)

        XCTAssertTrue(card.showsPlaceholder, "Placeholder should be shown when there is no recommendation.")
    }

    func testPlaceholderNotShownWhenRecommendationExists() {
        let items = [
            PreviewOutfitItem(name: "Jeans", isLayerable: false)
        ]
        let recommendation = PreviewOutfitRecommendation(items: items, confidence: 0.8, weatherCondition: "Rainy", temperature: 50)
        let card = PreviewOutfitRecommendationCard(recommendation: recommendation)

        XCTAssertFalse(card.showsPlaceholder, "Placeholder should not be shown when recommendation exists.")
    }
}
