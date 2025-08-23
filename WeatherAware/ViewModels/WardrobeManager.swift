//  WardrobeManager.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

import Foundation

class WardrobeManager: ObservableObject {
    @Published var clothingItems: [ClothingItem] = []
    
    private let userDefaults = UserDefaults.standard
    private let clothingItemsKey = "ClothingItems"
    
    init() {
        loadClothingItems()
    }
    
    func addClothingItem(_ item: ClothingItem) {
        clothingItems.append(item)
        saveClothingItems()
    }
    
    func removeClothingItem(at indexSet: IndexSet) {
        clothingItems.remove(atOffsets: indexSet)
        saveClothingItems()
    }
    
    func removeClothingItem(_ item: ClothingItem) {
        clothingItems.removeAll { $0.id == item.id }
        saveClothingItems()
    }
    
    func updateClothingItem(_ item: ClothingItem) {
        if let index = clothingItems.firstIndex(where: { $0.id == item.id }) {
            clothingItems[index] = item
            saveClothingItems()
        }
    }
    
    private func loadClothingItems() {
        if let data = userDefaults.data(forKey: clothingItemsKey),
           let items = try? JSONDecoder().decode([ClothingItem].self, from: data) {
            self.clothingItems = items
        } else {
            // Add sample items if none exist
            addSampleItems()
        }
    }
    
    private func saveClothingItems() {
        if let data = try? JSONEncoder().encode(clothingItems) {
            userDefaults.set(data, forKey: clothingItemsKey)
        }
    }
    
    private func addSampleItems() {
        let sampleItems = [
            ClothingItem(
                name: "Cotton T-Shirt",
                type: .top,
                minTemp: 15,
                maxTemp: 35,
                weatherTypes: [.sunny, .cloudy],
                occasion: .casual,
                color: "White",
                isLayerable: true
            ),
            ClothingItem(
                name: "Winter Jacket",
                type: .outerwear,
                minTemp: -10,
                maxTemp: 10,
                weatherTypes: [.snowy, .windy, .cloudy],
                occasion: .casual,
                color: "Black",
                isLayerable: false
            ),
            ClothingItem(
                name: "Jeans",
                type: .bottom,
                minTemp: 5,
                maxTemp: 25,
                weatherTypes: [.sunny, .cloudy, .windy],
                occasion: .casual,
                color: "Blue",
                isLayerable: false
            ),
            ClothingItem(
                name: "Sneakers",
                type: .shoes,
                minTemp: 0,
                maxTemp: 35,
                weatherTypes: [.sunny, .cloudy],
                occasion: .casual,
                color: "White",
                isLayerable: false
            )
        ]
        
        clothingItems = sampleItems
        saveClothingItems()
    }
}
