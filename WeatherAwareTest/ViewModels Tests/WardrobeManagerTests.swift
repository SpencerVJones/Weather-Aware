//  WardrobeManagerTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
import CoreData
@testable import WeatherAware

class WardrobeManagerTests: XCTestCase {
    
    // MARK: - Properties
    var wardrobeManager: WardrobeManager!
    var testContext: NSManagedObjectContext!
    
    // MARK: - Setup and Teardown
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Create a simple in-memory context without trying to load the model file
        testContext = createSimpleInMemoryContext()
        
        // Initialize WardrobeManager with test context
        wardrobeManager = WardrobeManager(viewContext: testContext)
    }
    
    override func tearDownWithError() throws {
        wardrobeManager = nil
        testContext = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Helper Methods
    private func createSimpleInMemoryContext() -> NSManagedObjectContext {
        // Create a minimal model programmatically
        let model = NSManagedObjectModel()
        
        // Create entity
        let entity = NSEntityDescription()
        entity.name = "ClothingItemEntity"
        entity.managedObjectClassName = "ClothingItemEntity"
        
        // Add required attributes
        let idAttr = NSAttributeDescription()
        idAttr.name = "id"
        idAttr.attributeType = .UUIDAttributeType
        idAttr.isOptional = true
        
        let nameAttr = NSAttributeDescription()
        nameAttr.name = "name"
        nameAttr.attributeType = .stringAttributeType
        nameAttr.isOptional = true
        
        let typeAttr = NSAttributeDescription()
        typeAttr.name = "type"
        typeAttr.attributeType = .stringAttributeType
        typeAttr.isOptional = true
        
        let minTempAttr = NSAttributeDescription()
        minTempAttr.name = "minTemp"
        minTempAttr.attributeType = .doubleAttributeType
        minTempAttr.isOptional = false
        
        let maxTempAttr = NSAttributeDescription()
        maxTempAttr.name = "maxTemp"
        maxTempAttr.attributeType = .doubleAttributeType
        maxTempAttr.isOptional = false
        
        let colorAttr = NSAttributeDescription()
        colorAttr.name = "color"
        colorAttr.attributeType = .stringAttributeType
        colorAttr.isOptional = true
        
        let isLayerableAttr = NSAttributeDescription()
        isLayerableAttr.name = "isLayerable"
        isLayerableAttr.attributeType = .booleanAttributeType
        isLayerableAttr.isOptional = false
        
        let imageDataAttr = NSAttributeDescription()
        imageDataAttr.name = "imageData"
        imageDataAttr.attributeType = .binaryDataAttributeType
        imageDataAttr.isOptional = true
        
        let occasionAttr = NSAttributeDescription()
        occasionAttr.name = "occasion"
        occasionAttr.attributeType = .stringAttributeType
        occasionAttr.isOptional = true
        
        let weatherTypesAttr = NSAttributeDescription()
        weatherTypesAttr.name = "weatherTypes"
        weatherTypesAttr.attributeType = .stringAttributeType
        weatherTypesAttr.isOptional = true
        
        entity.properties = [idAttr, nameAttr, typeAttr, minTempAttr, maxTempAttr,
                           colorAttr, isLayerableAttr, imageDataAttr, occasionAttr, weatherTypesAttr]
        
        model.entities = [entity]
        
        // Create container
        let container = NSPersistentContainer(name: "TestModel", managedObjectModel: model)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to create test store: \(error)")
            }
        }
        
        return container.viewContext
    }
    
    private func createSampleClothingItem(name: String = "Test T-Shirt") -> ClothingItem {
        return ClothingItem(
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
    func testInitialization() {
        XCTAssertNotNil(wardrobeManager)
        XCTAssertNotNil(wardrobeManager.clothingItems)
    }
    
    func testAddClothingItem() {
        let initialCount = wardrobeManager.clothingItems.count
        let testItem = createSampleClothingItem()
        
        wardrobeManager.addClothingItem(testItem)
        
        // Verify count increased
        XCTAssertEqual(wardrobeManager.clothingItems.count, initialCount + 1, "Item count should increase by 1")
        
        // Verify the item was added with correct properties
        let addedItem = wardrobeManager.clothingItems.first { $0.name == testItem.name }
        XCTAssertNotNil(addedItem, "Added item should be findable by name")
        XCTAssertEqual(addedItem?.name, testItem.name)
        XCTAssertEqual(addedItem?.type, testItem.type)
        XCTAssertEqual(addedItem?.minTemp, testItem.minTemp)
        XCTAssertEqual(addedItem?.maxTemp, testItem.maxTemp)
        XCTAssertEqual(addedItem?.color, testItem.color)
        XCTAssertEqual(addedItem?.isLayerable, testItem.isLayerable)
        XCTAssertEqual(addedItem?.occasion, testItem.occasion)
        XCTAssertEqual(addedItem?.weatherTypes, testItem.weatherTypes)
    }
    
    func testAddMultipleItems() {
        let initialCount = wardrobeManager.clothingItems.count
        
        let item1 = createSampleClothingItem(name: "Test Item 1")
        let item2 = createSampleClothingItem(name: "Test Item 2")
        
        wardrobeManager.addClothingItem(item1)
        wardrobeManager.addClothingItem(item2)
        
        XCTAssertEqual(wardrobeManager.clothingItems.count, initialCount + 2)
        XCTAssertTrue(wardrobeManager.clothingItems.contains { $0.name == "Test Item 1" })
        XCTAssertTrue(wardrobeManager.clothingItems.contains { $0.name == "Test Item 2" })
    }
    
    func testRemoveClothingItemByObject() {
        let testItem = createSampleClothingItem(name: "Item To Remove")
        wardrobeManager.addClothingItem(testItem)
        
        let initialCount = wardrobeManager.clothingItems.count
        
        // Get the actual added item (with correct ID)
        guard let addedItem = wardrobeManager.clothingItems.first(where: { $0.name == testItem.name }) else {
            XCTFail("Test item should exist after adding")
            return
        }
        
        wardrobeManager.removeClothingItem(addedItem)
        
    }
    
    func testRemoveClothingItemByIndexSet() {
        let testItem = createSampleClothingItem(name: "Index Remove Test")
        wardrobeManager.addClothingItem(testItem)
        
        let initialCount = wardrobeManager.clothingItems.count
        
        // Find the index of our test item
        guard let index = wardrobeManager.clothingItems.firstIndex(where: { $0.name == testItem.name }) else {
            XCTFail("Test item not found in wardrobe")
            return
        }
        
        let indexSet = IndexSet(integer: index)
        wardrobeManager.removeClothingItem(at: indexSet)
        
        XCTAssertEqual(wardrobeManager.clothingItems.count, initialCount - 1)
        XCTAssertFalse(wardrobeManager.clothingItems.contains { $0.name == testItem.name })
    }
    
    // MARK: - Edge Cases
    func testRemoveWithInvalidIndex() {
        let initialCount = wardrobeManager.clothingItems.count
        
        // Try to remove with index that's way too high
        let indexSet = IndexSet(integer: 99999)
        wardrobeManager.removeClothingItem(at: indexSet)
        
        // Should not crash and count should remain the same
        XCTAssertEqual(wardrobeManager.clothingItems.count, initialCount)
    }
    
    func testRemoveWithEmptyIndexSet() {
        let initialCount = wardrobeManager.clothingItems.count
        
        let indexSet = IndexSet()
        wardrobeManager.removeClothingItem(at: indexSet)
        
        // Should not crash and count should remain the same
        XCTAssertEqual(wardrobeManager.clothingItems.count, initialCount)
    }
    
    // MARK: - Weather Types Tests
    func testClothingItemWithMultipleWeatherTypes() {
        let item = ClothingItem(
            name: "Multi-Weather Item",
            type: .outerwear,
            minTemp: 30,
            maxTemp: 70,
            weatherTypes: [.sunny, .cloudy, .rainy, .snowy, .windy],
            occasion: .casual,
            color: "Gray",
            isLayerable: true
        )
        
        wardrobeManager.addClothingItem(item)
        
        let addedItem = wardrobeManager.clothingItems.first { $0.name == "Multi-Weather Item" }
        XCTAssertNotNil(addedItem)
        XCTAssertEqual(addedItem?.weatherTypes.count, 5)
        XCTAssertTrue(addedItem?.weatherTypes.contains(.sunny) ?? false)
        XCTAssertTrue(addedItem?.weatherTypes.contains(.rainy) ?? false)
        XCTAssertTrue(addedItem?.weatherTypes.contains(.snowy) ?? false)
    }
    
    func testClothingItemWithSingleWeatherType() {
        let item = ClothingItem(
            name: "Single Weather Item",
            type: .top,
            minTemp: 60,
            maxTemp: 80,
            weatherTypes: [.sunny],
            occasion: .casual,
            color: "Blue",
            isLayerable: true
        )
        
        wardrobeManager.addClothingItem(item)
        
        let addedItem = wardrobeManager.clothingItems.first { $0.name == "Single Weather Item" }
        XCTAssertNotNil(addedItem)
        XCTAssertEqual(addedItem?.weatherTypes.count, 1)
        XCTAssertEqual(addedItem?.weatherTypes.first, .sunny)
    }
    
    // MARK: - Occasion Tests
    func testCasualOccasionClothing() {
        let casualItem = createSampleClothingItem(name: "Casual Item")
        wardrobeManager.addClothingItem(casualItem)
        
        let addedItem = wardrobeManager.clothingItems.first { $0.name == "Casual Item" }
        XCTAssertNotNil(addedItem)
        XCTAssertEqual(addedItem?.occasion, .casual)
    }
    
    func testFormalOccasionClothing() {
        let formalItem = ClothingItem(
            name: "Formal Item",
            type: .outerwear,
            minTemp: 50,
            maxTemp: 80,
            weatherTypes: [.sunny, .cloudy],
            occasion: .formal,
            color: "Navy",
            isLayerable: true
        )
        
        wardrobeManager.addClothingItem(formalItem)
        
        let addedItem = wardrobeManager.clothingItems.first { $0.name == "Formal Item" }
        XCTAssertNotNil(addedItem)
        XCTAssertEqual(addedItem?.occasion, .formal)
    }
    
    // MARK: - Temperature Tests
    func testTemperatureRanges() {
        let coldItem = ClothingItem(
            name: "Cold Weather Item",
            type: .outerwear,
            minTemp: -10,
            maxTemp: 32,
            weatherTypes: [.snowy],
            occasion: .casual,
            color: "Black",
            isLayerable: false
        )
        
        wardrobeManager.addClothingItem(coldItem)
        
        let addedItem = wardrobeManager.clothingItems.first { $0.name == "Cold Weather Item" }
        XCTAssertNotNil(addedItem)
        XCTAssertEqual(addedItem?.minTemp, -10)
        XCTAssertEqual(addedItem?.maxTemp, 32)
    }
    
    func testHotWeatherItem() {
        let hotItem = ClothingItem(
            name: "Hot Weather Item",
            type: .top,
            minTemp: 80,
            maxTemp: 110,
            weatherTypes: [.sunny],
            occasion: .casual,
            color: "White",
            isLayerable: true
        )
        
        wardrobeManager.addClothingItem(hotItem)
        
        let addedItem = wardrobeManager.clothingItems.first { $0.name == "Hot Weather Item" }
        XCTAssertNotNil(addedItem)
        XCTAssertEqual(addedItem?.minTemp, 80)
        XCTAssertEqual(addedItem?.maxTemp, 110)
    }
    
    // MARK: - Clothing Type Tests
    func testAllClothingTypes() {
        let topItem = createSampleClothingItem(name: "Top Item")
        
        
        let bottomItem = ClothingItem(name: "Bottom Item", type: .bottom, minTemp: 50, maxTemp: 80, weatherTypes: [.sunny], occasion: .casual, color: "Blue", isLayerable: false)
        
        let outerwearItem = ClothingItem(name: "Outerwear Item", type: .outerwear, minTemp: 30, maxTemp: 60, weatherTypes: [.windy], occasion: .casual, color: "Gray", isLayerable: true)
        
        let shoesItem = ClothingItem(name: "Shoes Item", type: .shoes, minTemp: 32, maxTemp: 95, weatherTypes: [.sunny], occasion: .casual, color: "Brown", isLayerable: false)
        
        wardrobeManager.addClothingItem(topItem)
        wardrobeManager.addClothingItem(bottomItem)
        wardrobeManager.addClothingItem(outerwearItem)
        wardrobeManager.addClothingItem(shoesItem)
        
        let addedTop = wardrobeManager.clothingItems.first { $0.name == "Top Item" }
        let addedBottom = wardrobeManager.clothingItems.first { $0.name == "Bottom Item" }
        let addedOuterwear = wardrobeManager.clothingItems.first { $0.name == "Outerwear Item" }
        let addedShoes = wardrobeManager.clothingItems.first { $0.name == "Shoes Item" }
        
        XCTAssertEqual(addedTop?.type, .top)
        XCTAssertEqual(addedBottom?.type, .bottom)
        XCTAssertEqual(addedOuterwear?.type, .outerwear)
        XCTAssertEqual(addedShoes?.type, .shoes)
    }
    
    // MARK: - Layerable Tests
    func testLayerableItems() {
        let layerableItem = ClothingItem(
            name: "Layerable Item",
            type: .top,
            minTemp: 50,
            maxTemp: 75,
            weatherTypes: [.cloudy],
            occasion: .casual,
            color: "Green",
            isLayerable: true
        )
        
        let nonLayerableItem = ClothingItem(
            name: "Non-Layerable Item",
            type: .outerwear,
            minTemp: 30,
            maxTemp: 50,
            weatherTypes: [.snowy],
            occasion: .casual,
            color: "Red",
            isLayerable: false
        )
        
        wardrobeManager.addClothingItem(layerableItem)
        wardrobeManager.addClothingItem(nonLayerableItem)
        
        let addedLayerable = wardrobeManager.clothingItems.first { $0.name == "Layerable Item" }
        let addedNonLayerable = wardrobeManager.clothingItems.first { $0.name == "Non-Layerable Item" }
        
        XCTAssertEqual(addedLayerable?.isLayerable, true)
        XCTAssertEqual(addedNonLayerable?.isLayerable, false)
    }
    
    // MARK: - Data Persistence Test
    func testDataPersistenceAcrossManagers() {
        let testItem = createSampleClothingItem(name: "Persistence Test Item")
        wardrobeManager.addClothingItem(testItem)
        
        // Create new manager with same context
        let newManager = WardrobeManager(viewContext: testContext)
        
        XCTAssertTrue(newManager.clothingItems.contains { $0.name == "Persistence Test Item" })
    }
}

// MARK: - Performance Tests
extension WardrobeManagerTests {
    
    func testPerformanceAddingMultipleItems() {
        measure {
            for i in 0..<5 { // Keep it small for CI
                let item = ClothingItem(
                    name: "Performance Item \(i)",
                    type: .top,
                    minTemp: Double(50 + i),
                    maxTemp: Double(80 + i),
                    weatherTypes: [.sunny],
                    occasion: .casual,
                    color: "Color\(i)",
                    isLayerable: i % 2 == 0
                )
                wardrobeManager.addClothingItem(item)
            }
        }
    }
}
