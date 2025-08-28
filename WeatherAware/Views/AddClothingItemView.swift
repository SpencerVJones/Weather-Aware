//  AddClothingItemView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

/*
A SwiftUI form view that allows the user to add a new clothing item to their wardrobe.
Users can specify name, type, color, occasion, temperature range, suitable weather, layering option, and optionally attach a photo.
*/

import SwiftUI
import PhotosUI
import CoreData

// A view for adding a new clothing item
struct AddClothingItemView: View {
    // MARK: - Environment
    @EnvironmentObject var wardrobeManager: WardrobeManager // Access to wardrobe manager
    @Environment(\.presentationMode) var presentationMode // Used to dismiss view
    
    // MARK: - Form State
    @State private var name = "" // Clothing item name
    @State private var selectedType = ClothingItem.ClothingType.top
    @State private var minTemp: Double = 50 // Minimum temperature suitability
    @State private var maxTemp: Double = 77 // Maximum temperature suitability
    @State private var selectedWeatherTypes: Set<ClothingItem.WeatherType> = [.sunny] // Selected weather conditions
    @State private var selectedOccasion = ClothingItem.Occasion.casual
    @State private var color = "" // Color as string
    @State private var isLayerable = false // Can the item be layered
    
    // MARK: - PhotosPicker State
    @State private var selectedPhoto: PhotosPickerItem? = nil // Holds the selected photo
    @State private var pickedImageData: Data? = nil // Image data for storage
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                // MARK: - Photo Section
                Section("Photo") {
                    HStack(spacing: 12) {
                        // Display the selected image or placeholder
                        ClothingImageView(imageData: pickedImageData,
                                          placeholderSystemName: "photo.on.rectangle.angled")
                        .frame(width: 64, height: 64)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        // Photo picker for choosing image
                        PhotosPicker("Choose Photo", selection: $selectedPhoto, matching: .images)
                            .onChange(of: selectedPhoto) { newItem in
                                guard let newItem else { return }
                                Task {
                                    if let data = try? await newItem.loadTransferable(type: Data.self) {
                                        await MainActor.run { pickedImageData = data }
                                    }
                                }
                            }
                    }
                }
                
                // MARK: - Basic Info Section
                Section(header: Text("Basic Info")) {
                    // Item name
                    TextField("Item name", text: $name)
                    
                    // Clothing type
                    Picker("Type", selection: $selectedType) {
                        ForEach(ClothingItem.ClothingType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    
                    // Color
                    TextField("Color", text: $color)
                    
                    // Occasion
                    Picker("Occasion", selection: $selectedOccasion) {
                        ForEach(ClothingItem.Occasion.allCases, id: \.self) { occasion in
                            Text(occasion.rawValue).tag(occasion)
                        }
                    }
                }
                
                // MARK: - Temperature Range Section
                Section(header: Text("Temperature Range (°F)")) {
                    VStack {
                        HStack {
                            Text("Min: \(Int(minTemp))°F")
                            Spacer()
                            Text("Max: \(Int(maxTemp))°F")
                        }
                        
                        // Min temperature slider
                        Slider(value: $minTemp, in: -4...104, step: 1)
                            .tint(.blue)
                        
                        // Max temperature slider
                        Slider(value: $maxTemp, in: -4...104, step: 1)
                            .tint(.red)
                    }
                }
                
                // MARK: - Suitable Weather Section
                Section(header: Text("Suitable Weather")) {
                    ForEach(ClothingItem.WeatherType.allCases, id: \.self) { weather in
                        MultipleSelectionRow(
                            title: weather.rawValue,
                            isSelected: selectedWeatherTypes.contains(weather)
                        ) {
                            if selectedWeatherTypes.contains(weather) {
                                selectedWeatherTypes.remove(weather)
                            } else {
                                selectedWeatherTypes.insert(weather)
                            }
                        }
                    }
                }
                
                // MARK: - Additional Options Section
                Section(header: Text("Additional Options")) {
                    Toggle("Can be layered", isOn: $isLayerable)
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Cancel button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                // Save button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveItem()
                    }
                    .disabled(name.isEmpty || color.isEmpty || selectedWeatherTypes.isEmpty)
                }
            }
            .onAppear {
                // Ensure maxTemp is greater than minTemp on view load
                if maxTemp <= minTemp {
                    maxTemp = minTemp + 9
                }
            }
            .onChange(of: minTemp) { newValue in
                if newValue >= maxTemp {
                    maxTemp = newValue + 9
                }
            }
            .onChange(of: maxTemp) { newValue in
                if newValue <= minTemp {
                    minTemp = newValue - 9
                }
            }
        }
    }
    
    // MARK: - Private Methods
    // Saves the new clothing item to the wardrobe
    private func saveItem() {
        // DEBUG: Check if image data exists
        if let imageData = pickedImageData {
            print("Image data exists: \(imageData.count) bytes")
        } else {
            print("No image data found")
        }
        
        // Create ClothingItem instance
        let newItem = ClothingItem(
            name: name,
            type: selectedType,
            minTemp: minTemp,
            maxTemp: maxTemp,
            weatherTypes: Array(selectedWeatherTypes),
            occasion: selectedOccasion,
            color: color,
            isLayerable: isLayerable,
            imageData: pickedImageData
        )
        
        // DEBUG: Verify if image data was saved
        if let itemImageData = newItem.imageData {
            print("ClothingItem created with image data: \(itemImageData.count) bytes")
        } else {
            print("ClothingItem created without image data")
        }
        
        // Add item to wardrobe and dismiss view
        wardrobeManager.addClothingItem(newItem)
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - PREVIEW
#Preview {
    AddClothingItemView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
