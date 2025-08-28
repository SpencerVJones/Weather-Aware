//  WardrobeManager.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

/*
Manages the user's wardrobe by handling clothing items stored in Core Data.
Provides methods to add, remove, update, and fetch clothing items. Also handles
migration from UserDefaults to Core Data and initializes sample clothing items
for first-time users.
*/

import Foundation
import CoreData
import SwiftUI

class WardrobeManager: ObservableObject {
    // MARK: - Published Properties
    @Published var clothingItems: [ClothingItem] = [] // Array of clothing items currently loaded from Core Data
    
    // MARK: - Private Properties
    private let viewContext: NSManagedObjectContext
    private let userDefaults = UserDefaults.standard
    private let clothingItemsKey = "ClothingItems"
    private let migrationCompletedKey = "CoreDataMigrationCompleted"
    
    // MARK: - Initialization
    // Initializes the wardrobe manager and loads clothing items
    /// - Parameter viewContext: The Core Data context for saving and fetching items
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        
        // Migrate items from UserDefaults if migration hasn't occurred
        if !userDefaults.bool(forKey: migrationCompletedKey) {
            migrateFromUserDefaults()
        }
        // Load clothing items from Core Data
        loadClothingItems()
    }
    
    // MARK: - Core Data Operations
    // Adds a new clothing item to Core Data
    /// - Parameter item: ClothingItem to be added
    func addClothingItem(_ item: ClothingItem) {
        let entity = ClothingItemEntity(context: viewContext)
        entity.id = item.id
        entity.name = item.name
        entity.type = item.type.rawValue
        entity.minTemp = item.minTemp
        entity.maxTemp = item.maxTemp
        entity.color = item.color
        entity.isLayerable = item.isLayerable
        entity.imageData = item.imageData
        entity.occasion = item.occasion.rawValue
        entity.weatherTypes = item.weatherTypes.map { $0.rawValue }.joined(separator: ",")
        
        saveContextAndReload()
    }
    
    // Removes clothing items at the specified indices
    /// - Parameter indexSet: IndexSet of items to delete
    func removeClothingItem(at indexSet: IndexSet) {
        let request: NSFetchRequest<ClothingItemEntity> = ClothingItemEntity.fetchRequest()
        do {
            let entities = try viewContext.fetch(request)
            indexSet.forEach { index in
                if index < entities.count {
                    viewContext.delete(entities[index])
                }
            }
            saveContextAndReload()
        } catch {
            print("Failed to delete clothing item: \(error)")
        }
    }
    
    // Removes a specific clothing item
    /// - Parameter item: ClothingItem to remove
    func removeClothingItem(_ item: ClothingItem) {
        let request: NSFetchRequest<ClothingItemEntity> = ClothingItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
        do {
            let entities = try viewContext.fetch(request)
            entities.forEach { viewContext.delete($0) }
            saveContextAndReload()
        } catch {
            print("Failed to delete clothing item: \(error)")
        }
    }
    
    // Updates an existing clothing item in Core Data
    /// - Parameter item: ClothingItem with updated properties
    func updateClothingItem(_ item: ClothingItem) {
        let request: NSFetchRequest<ClothingItemEntity> = ClothingItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
        do {
            if let entity = try viewContext.fetch(request).first {
                entity.name = item.name
                entity.type = item.type.rawValue
                entity.minTemp = item.minTemp
                entity.maxTemp = item.maxTemp
                entity.color = item.color
                entity.isLayerable = item.isLayerable
                entity.imageData = item.imageData
                entity.occasion = item.occasion.rawValue
                entity.weatherTypes = item.weatherTypes.map { $0.rawValue }.joined(separator: ",")
                
                saveContextAndReload()
            }
        } catch {
            print("Failed to update clothing item: \(error)")
        }
    }
    
    // Saves the Core Data context and reloads clothing items
    private func saveContextAndReload() {
        do {
            try viewContext.save()
            loadClothingItems()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    // Loads clothing items from Core Data into the published array
    private func loadClothingItems() {
        let request: NSFetchRequest<ClothingItemEntity> = ClothingItemEntity.fetchRequest()
        do {
            let entities = try viewContext.fetch(request)
            clothingItems = entities.compactMap { entity -> ClothingItem? in
                guard let id = entity.id,
                      let name = entity.name,
                      let typeString = entity.type,
                      let type = ClothingItem.ClothingType(rawValue: typeString),
                      let color = entity.color,
                      let occasionString = entity.occasion,
                      let occasion = ClothingItem.Occasion(rawValue: occasionString) else {
                    return nil
                }
                
                let weatherTypes: [ClothingItem.WeatherType] = entity.weatherTypes?
                    .split(separator: ",")
                    .compactMap { ClothingItem.WeatherType(rawValue: String($0)) } ?? []
                
                return ClothingItem(
                    //   id: id,
                    name: name,
                    type: type,
                    minTemp: entity.minTemp,
                    maxTemp: entity.maxTemp,
                    weatherTypes: weatherTypes,
                    occasion: occasion,
                    color: color,
                    isLayerable: entity.isLayerable,
                    imageData: entity.imageData
                )
            }
            print("Loaded \(clothingItems.count) clothing items from Core Data")
        } catch {
            print("Failed to fetch clothing items: \(error)")
            clothingItems = []
        }
    }
    
    // MARK: - Migration
    // Migrates clothing items stored in UserDefaults to Core Data
    private func migrateFromUserDefaults() {
        guard let data = userDefaults.data(forKey: clothingItemsKey),
              let oldItems = try? JSONDecoder().decode([ClothingItem].self, from: data) else {
            addSampleItems()
            userDefaults.set(true, forKey: migrationCompletedKey)
            return
        }
        
        oldItems.forEach { item in
            let entity = ClothingItemEntity(context: viewContext)
            entity.id = item.id
            entity.name = item.name
            entity.type = item.type.rawValue
            entity.minTemp = item.minTemp
            entity.maxTemp = item.maxTemp
            entity.color = item.color
            entity.isLayerable = item.isLayerable
            entity.imageData = item.imageData
            entity.occasion = item.occasion.rawValue
            entity.weatherTypes = item.weatherTypes.map { $0.rawValue }.joined(separator: ",")
        }
        
        saveContextAndReload()
        userDefaults.removeObject(forKey: clothingItemsKey)
        userDefaults.set(true, forKey: migrationCompletedKey)
    }
    
    // Adds sample clothing items for new users
    private func addSampleItems() {
        let sampleItems: [ClothingItem] = [
            ClothingItem(name: "Cotton T-Shirt", type: .top, minTemp: 59, maxTemp: 95, weatherTypes: [.sunny, .cloudy], occasion: .casual, color: "White", isLayerable: true),
            ClothingItem(name: "Winter Jacket", type: .outerwear, minTemp: 14, maxTemp: 50, weatherTypes: [.snowy, .windy, .cloudy], occasion: .casual, color: "Black", isLayerable: false),
            ClothingItem(name: "Jeans", type: .bottom, minTemp: 41, maxTemp: 77, weatherTypes: [.sunny, .cloudy, .windy], occasion: .casual, color: "Blue", isLayerable: false),
            ClothingItem(name: "Sneakers", type: .shoes, minTemp: 32, maxTemp: 95, weatherTypes: [.sunny, .cloudy], occasion: .casual, color: "White", isLayerable: false)
        ]
        
        sampleItems.forEach(addClothingItem)
    }
}
