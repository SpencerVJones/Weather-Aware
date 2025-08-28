//  AddClothingItemViewTests.swift
//  WeatherAwareUITest
// Created by Spencer Jones on 8/27/25

import XCTest

// MARK: - Mock structs for testing wardrobe logic
struct MockClothingItem {
    let id = UUID()
    let name: String
    let type: ClothingType
    let minTemp: Double
    let maxTemp: Double
    let weatherTypes: [WeatherType]
    let occasion: Occasion
    let color: String
    let isLayerable: Bool
    
    enum ClothingType: String, CaseIterable {
        case top, bottom, outerwear, shoes
    }
    
    enum WeatherType: String, CaseIterable {
        case sunny, cloudy, rainy, snowy, windy
    }
    
    enum Occasion: String, CaseIterable {
        case casual, formal
    }
    
    // Test the core logic methods
    func isSuitableFor(temperature: Double) -> Bool {
        return temperature >= minTemp && temperature <= maxTemp
    }
    
    func isSuitableFor(weather: String) -> Bool {
        let weatherLower = weather.lowercased()
        return weatherTypes.contains { weatherType in
            let typeLower = weatherType.rawValue.lowercased()
            return weatherLower.contains(typeLower) ||
                   (weatherType == .rainy && (weatherLower.contains("rain") || weatherLower.contains("drizzle"))) ||
                   (weatherType == .sunny && weatherLower.contains("clear"))
        }
    }
    
    var temperatureRangeText: String {
        return "\(Int(minTemp))-\(Int(maxTemp))°F"
    }
    
    var weatherTypesText: String {
        return weatherTypes.map { $0.rawValue }.joined(separator: ", ")
    }
}

// MARK: - Mock wardrobe manager for testing logic
class MockWardrobeManager {
    private(set) var clothingItems: [MockClothingItem] = []
    
    func addClothingItem(_ item: MockClothingItem) {
        clothingItems.append(item)
    }
    
    func removeClothingItem(_ item: MockClothingItem) {
        clothingItems.removeAll { $0.id == item.id }
    }
    
    func removeClothingItem(at indexSet: IndexSet) {
        for index in indexSet.sorted(by: >) {
            if clothingItems.indices.contains(index) {
                clothingItems.remove(at: index)
            }
        }
    }
    
    func getItemsSuitableFor(temperature: Double) -> [MockClothingItem] {
        return clothingItems.filter { $0.isSuitableFor(temperature: temperature) }
    }
    
    func getItemsSuitableFor(weather: String) -> [MockClothingItem] {
        return clothingItems.filter { $0.isSuitableFor(weather: weather) }
    }
    
    func getItemsOfType(_ type: MockClothingItem.ClothingType) -> [MockClothingItem] {
        return clothingItems.filter { $0.type == type }
    }
    
    func getLayerableItems() -> [MockClothingItem] {
        return clothingItems.filter { $0.isLayerable }
    }
}

// MARK: - Test Cases
final class SimplifiedWardrobeManagerTests: XCTestCase {
    
    var wardrobeManager: MockWardrobeManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        wardrobeManager = MockWardrobeManager()
    }
    
    override func tearDownWithError() throws {
        wardrobeManager = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Helper Methods
    private func createSampleItem(name: String = "Test Item") -> MockClothingItem {
        return MockClothingItem(
            name: name,
            type: .top,
            minTemp: 60,
            maxTemp: 80,
            weatherTypes: [.sunny, .cloudy],
            occasion: .casual,
            color: "Blue",
            isLayerable: true
        )
    }
    
    // MARK: - Basic Functionality Tests
    func testAddClothingItem() {
        let item = createSampleItem()
        
        wardrobeManager.addClothingItem(item)
        
        XCTAssertEqual(wardrobeManager.clothingItems.count, 1)
        XCTAssertEqual(wardrobeManager.clothingItems.first?.name, "Test Item")
    }
    
    func testAddMultipleItems() {
        let item1 = createSampleItem(name: "Item 1")
        let item2 = createSampleItem(name: "Item 2")
        
        wardrobeManager.addClothingItem(item1)
        wardrobeManager.addClothingItem(item2)
        
        XCTAssertEqual(wardrobeManager.clothingItems.count, 2)
        XCTAssertTrue(wardrobeManager.clothingItems.contains { $0.name == "Item 1" })
        XCTAssertTrue(wardrobeManager.clothingItems.contains { $0.name == "Item 2" })
    }
    
    func testRemoveClothingItem() {
        let item = createSampleItem()
        wardrobeManager.addClothingItem(item)
        
        wardrobeManager.removeClothingItem(item)
        
        XCTAssertEqual(wardrobeManager.clothingItems.count, 0)
    }
    
    func testRemoveByIndexSet() {
        let item1 = createSampleItem(name: "Item 1")
        let item2 = createSampleItem(name: "Item 2")
        wardrobeManager.addClothingItem(item1)
        wardrobeManager.addClothingItem(item2)
        
        let indexSet = IndexSet(integer: 0)
        wardrobeManager.removeClothingItem(at: indexSet)
        
        XCTAssertEqual(wardrobeManager.clothingItems.count, 1)
        XCTAssertEqual(wardrobeManager.clothingItems.first?.name, "Item 2")
    }
    
    // MARK: - Temperature Suitability Tests
    func testTemperatureSuitability() {
        let item = MockClothingItem(
            name: "Winter Coat",
            type: .outerwear,
            minTemp: 20,
            maxTemp: 50,
            weatherTypes: [.snowy, .windy],
            occasion: .casual,
            color: "Black",
            isLayerable: false
        )
        
        XCTAssertTrue(item.isSuitableFor(temperature: 25))
        XCTAssertTrue(item.isSuitableFor(temperature: 20))
        XCTAssertTrue(item.isSuitableFor(temperature: 50))
        XCTAssertFalse(item.isSuitableFor(temperature: 19))
        XCTAssertFalse(item.isSuitableFor(temperature: 51))
    }
    
    func testGetItemsSuitableForTemperature() {
        let winterItem = MockClothingItem(name: "Winter Coat", type: .outerwear, minTemp: 20, maxTemp: 50, weatherTypes: [.snowy], occasion: .casual, color: "Black", isLayerable: false)
        let summerItem = MockClothingItem(name: "T-Shirt", type: .top, minTemp: 70, maxTemp: 100, weatherTypes: [.sunny], occasion: .casual, color: "White", isLayerable: true)
        
        wardrobeManager.addClothingItem(winterItem)
        wardrobeManager.addClothingItem(summerItem)
        
        let suitableFor30 = wardrobeManager.getItemsSuitableFor(temperature: 30)
        let suitableFor80 = wardrobeManager.getItemsSuitableFor(temperature: 80)
        
        XCTAssertEqual(suitableFor30.count, 1)
        XCTAssertEqual(suitableFor30.first?.name, "Winter Coat")
        
        XCTAssertEqual(suitableFor80.count, 1)
        XCTAssertEqual(suitableFor80.first?.name, "T-Shirt")
    }
    
    // MARK: - Weather Suitability Tests
    func testWeatherSuitability() {
        let item = MockClothingItem(
            name: "Rain Jacket",
            type: .outerwear,
            minTemp: 40,
            maxTemp: 70,
            weatherTypes: [.rainy, .windy],
            occasion: .casual,
            color: "Yellow",
            isLayerable: true
        )
        
        XCTAssertTrue(item.isSuitableFor(weather: "Rainy"))
        XCTAssertTrue(item.isSuitableFor(weather: "Light rain"))
        XCTAssertTrue(item.isSuitableFor(weather: "Drizzle"))
        XCTAssertTrue(item.isSuitableFor(weather: "Windy"))
        XCTAssertFalse(item.isSuitableFor(weather: "Sunny"))
        XCTAssertFalse(item.isSuitableFor(weather: "Snowy"))
    }
    
    func testGetItemsSuitableForWeather() {
        let rainItem = MockClothingItem(name: "Rain Coat", type: .outerwear, minTemp: 40, maxTemp: 70, weatherTypes: [.rainy], occasion: .casual, color: "Yellow", isLayerable: false)
        let sunnyItem = MockClothingItem(name: "Sun Hat", type: .top, minTemp: 70, maxTemp: 100, weatherTypes: [.sunny], occasion: .casual, color: "White", isLayerable: false)
        
        wardrobeManager.addClothingItem(rainItem)
        wardrobeManager.addClothingItem(sunnyItem)
        
        let suitableForRain = wardrobeManager.getItemsSuitableFor(weather: "Heavy rain")
        let suitableForSun = wardrobeManager.getItemsSuitableFor(weather: "Sunny skies")
        
        XCTAssertEqual(suitableForRain.count, 1)
        XCTAssertEqual(suitableForRain.first?.name, "Rain Coat")
        
        XCTAssertEqual(suitableForSun.count, 1)
        XCTAssertEqual(suitableForSun.first?.name, "Sun Hat")
    }
    
    // MARK: - Clothing Type Tests
    func testGetItemsOfType() {
        let top = MockClothingItem(name: "Shirt", type: .top, minTemp: 60, maxTemp: 80, weatherTypes: [.sunny], occasion: .casual, color: "Blue", isLayerable: true)
        let bottom = MockClothingItem(name: "Pants", type: .bottom, minTemp: 50, maxTemp: 80, weatherTypes: [.cloudy], occasion: .casual, color: "Black", isLayerable: false)
        let shoes = MockClothingItem(name: "Sneakers", type: .shoes, minTemp: 32, maxTemp: 95, weatherTypes: [.sunny], occasion: .casual, color: "White", isLayerable: false)
        
        wardrobeManager.addClothingItem(top)
        wardrobeManager.addClothingItem(bottom)
        wardrobeManager.addClothingItem(shoes)
        
        let tops = wardrobeManager.getItemsOfType(.top)
        let bottoms = wardrobeManager.getItemsOfType(.bottom)
        let shoesItems = wardrobeManager.getItemsOfType(.shoes)
        let outerwear = wardrobeManager.getItemsOfType(.outerwear)
        
        XCTAssertEqual(tops.count, 1)
        XCTAssertEqual(tops.first?.name, "Shirt")
        
        XCTAssertEqual(bottoms.count, 1)
        XCTAssertEqual(bottoms.first?.name, "Pants")
        
        XCTAssertEqual(shoesItems.count, 1)
        XCTAssertEqual(shoesItems.first?.name, "Sneakers")
        
        XCTAssertEqual(outerwear.count, 0)
    }
    
    // MARK: - Layerable Items Tests
    func testGetLayerableItems() {
        let layerable1 = MockClothingItem(name: "Cardigan", type: .top, minTemp: 50, maxTemp: 70, weatherTypes: [.cloudy], occasion: .casual, color: "Gray", isLayerable: true)
        let layerable2 = MockClothingItem(name: "Light Jacket", type: .outerwear, minTemp: 45, maxTemp: 65, weatherTypes: [.windy], occasion: .casual, color: "Navy", isLayerable: true)
        let nonLayerable = MockClothingItem(name: "Heavy Coat", type: .outerwear, minTemp: 20, maxTemp: 45, weatherTypes: [.snowy], occasion: .casual, color: "Black", isLayerable: false)
        
        wardrobeManager.addClothingItem(layerable1)
        wardrobeManager.addClothingItem(layerable2)
        wardrobeManager.addClothingItem(nonLayerable)
        
        let layerableItems = wardrobeManager.getLayerableItems()
        
        XCTAssertEqual(layerableItems.count, 2)
        XCTAssertTrue(layerableItems.contains { $0.name == "Cardigan" })
        XCTAssertTrue(layerableItems.contains { $0.name == "Light Jacket" })
        XCTAssertFalse(layerableItems.contains { $0.name == "Heavy Coat" })
    }
    
    // MARK: - Edge Cases
    func testRemoveWithInvalidIndex() {
        let item = createSampleItem()
        wardrobeManager.addClothingItem(item)
        
        let indexSet = IndexSet(integer: 999)
        wardrobeManager.removeClothingItem(at: indexSet)
        
        // Should not crash and item should still be there
        XCTAssertEqual(wardrobeManager.clothingItems.count, 1)
    }
    
    func testRemoveMultipleIndices() {
        let item1 = createSampleItem(name: "Item 1")
        let item2 = createSampleItem(name: "Item 2")
        let item3 = createSampleItem(name: "Item 3")
        
        wardrobeManager.addClothingItem(item1)
        wardrobeManager.addClothingItem(item2)
        wardrobeManager.addClothingItem(item3)
        
        let indexSet = IndexSet([0, 2])
        wardrobeManager.removeClothingItem(at: indexSet)
        
        XCTAssertEqual(wardrobeManager.clothingItems.count, 1)
        XCTAssertEqual(wardrobeManager.clothingItems.first?.name, "Item 2")
    }
    
    // MARK: - Text Formatting Tests
    func testTemperatureRangeText() {
        let item = MockClothingItem(name: "Test", type: .top, minTemp: 32, maxTemp: 75, weatherTypes: [], occasion: .casual, color: "Blue", isLayerable: false)
        XCTAssertEqual(item.temperatureRangeText, "32-75°F")
    }
    
    func testWeatherTypesText() {
        let item = MockClothingItem(name: "Test", type: .top, minTemp: 60, maxTemp: 80, weatherTypes: [.sunny, .cloudy, .rainy], occasion: .casual, color: "Blue", isLayerable: false)
        XCTAssertEqual(item.weatherTypesText, "sunny, cloudy, rainy")
    }
    
    func testEmptyWeatherTypesText() {
        let item = MockClothingItem(name: "Test", type: .top, minTemp: 60, maxTemp: 80, weatherTypes: [], occasion: .casual, color: "Blue", isLayerable: false)
        XCTAssertEqual(item.weatherTypesText, "")
    }
}

// MARK: - Performance Tests
extension SimplifiedWardrobeManagerTests {
    
    func testPerformanceAddingManyItems() {
        measure {
            for i in 0..<100 {
                let item = MockClothingItem(
                    name: "Item \(i)",
                    type: MockClothingItem.ClothingType.allCases.randomElement()!,
                    minTemp: Double(30 + i % 40),
                    maxTemp: Double(70 + i % 30),
                    weatherTypes: [MockClothingItem.WeatherType.allCases.randomElement()!],
                    occasion: MockClothingItem.Occasion.allCases.randomElement()!,
                    color: "Color\(i)",
                    isLayerable: i % 2 == 0
                )
                wardrobeManager.addClothingItem(item)
            }
        }
    }
    
    func testPerformanceFilteringItems() {
        // Add many items first
        for i in 0..<1000 {
            let item = MockClothingItem(
                name: "Item \(i)",
                type: MockClothingItem.ClothingType.allCases.randomElement()!,
                minTemp: Double(30 + i % 40),
                maxTemp: Double(70 + i % 30),
                weatherTypes: [MockClothingItem.WeatherType.allCases.randomElement()!],
                occasion: MockClothingItem.Occasion.allCases.randomElement()!,
                color: "Color\(i)",
                isLayerable: i % 2 == 0
            )
            wardrobeManager.addClothingItem(item)
        }
        
        measure {
            _ = wardrobeManager.getItemsSuitableFor(temperature: 50)
            _ = wardrobeManager.getItemsSuitableFor(weather: "sunny")
            _ = wardrobeManager.getLayerableItems()
        }
    }
}
