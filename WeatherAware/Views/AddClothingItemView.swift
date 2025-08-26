//  AddClothingItemView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

import SwiftUI
import PhotosUI
import CoreData

struct AddClothingItemView: View {
    @EnvironmentObject var wardrobeManager: WardrobeManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var selectedType = ClothingItem.ClothingType.top
    @State private var minTemp: Double = 10
    @State private var maxTemp: Double = 25
    @State private var selectedWeatherTypes: Set<ClothingItem.WeatherType> = [.sunny]
    @State private var selectedOccasion = ClothingItem.Occasion.casual
    @State private var color = ""
    @State private var isLayerable = false
    
    // PhotosPicker state
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var pickedImageData: Data? = nil
    
    var body: some View {
        NavigationView {
            Form {
                // Photo Section
                Section("Photo") {
                    HStack(spacing: 12) {
                        ClothingImageView(imageData: pickedImageData,
                                          placeholderSystemName: "photo.on.rectangle.angled")
                        .frame(width: 64, height: 64)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        
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
                
                // Basic Info Section
                Section(header: Text("Basic Info")) {
                    TextField("Item name", text: $name)
                    
                    Picker("Type", selection: $selectedType) {
                        ForEach(ClothingItem.ClothingType.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    
                    TextField("Color", text: $color)
                    
                    Picker("Occasion", selection: $selectedOccasion) {
                        ForEach(ClothingItem.Occasion.allCases, id: \.self) { occasion in
                            Text(occasion.rawValue.capitalized).tag(occasion)
                        }
                    }
                }
                
                // Temperature Section
                Section(header: Text("Temperature Range (°C)")) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Min: \(Int(minTemp))°")
                                .font(.caption)
                                .foregroundColor(.blue)
                            Spacer()
                            Text("Max: \(Int(maxTemp))°")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        
                        VStack(spacing: 4) {
                            Text("Minimum Temperature")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Slider(value: $minTemp, in: -20...40, step: 1)
                                .tint(.blue)
                        }
                        
                        VStack(spacing: 4) {
                            Text("Maximum Temperature")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Slider(value: $maxTemp, in: -20...40, step: 1)
                                .tint(.red)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                // Weather Types Section
                Section(header: Text("Suitable Weather")) {
                    ForEach(ClothingItem.WeatherType.allCases, id: \.self) { weather in
                        MultipleSelectionRow(
                            title: weather.rawValue.capitalized,
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
                
                // Additional Options Section
                Section(header: Text("Additional Options")) {
                    Toggle("Can be layered", isOn: $isLayerable)
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveItem()
                    }
                    .disabled(name.isEmpty || color.isEmpty || selectedWeatherTypes.isEmpty)
                }
            }
        }
        .onAppear {
            // Ensure maxTemp is always greater than minTemp
            if maxTemp <= minTemp {
                maxTemp = minTemp + 5
            }
        }
        .onChange(of: minTemp) { newValue in
            if newValue >= maxTemp {
                maxTemp = newValue + 5
            }
        }
        .onChange(of: maxTemp) { newValue in
            if newValue <= minTemp {
                minTemp = newValue - 5
            }
        }
    }
    
    private func saveItem() {
        // Validate temperature range
        let validatedMinTemp = min(minTemp, maxTemp - 1)
        let validatedMaxTemp = max(maxTemp, minTemp + 1)
        
        let newItem = ClothingItem(
            name: name,
            type: selectedType,
            minTemp: validatedMinTemp,
            maxTemp: validatedMaxTemp,
            weatherTypes: Array(selectedWeatherTypes),
            occasion: selectedOccasion,
            color: color,
            isLayerable: isLayerable,
            imageData: pickedImageData
        )
        
        wardrobeManager.addClothingItem(newItem)
        presentationMode.wrappedValue.dismiss()
    }
}


// MARK: - PREVIEW
#Preview {
    AddClothingItemView()
        .environmentObject(WardrobeManager())
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
