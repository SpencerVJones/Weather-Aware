//  AddClothingItemView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

import SwiftUI
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
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Basic Info")) {
                    TextField("Item name", text: $name)
                    
                    Picker("Type", selection: $selectedType) {
                        ForEach(ClothingItem.ClothingType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    
                    TextField("Color", text: $color)
                    
                    Picker("Occasion", selection: $selectedOccasion) {
                        ForEach(ClothingItem.Occasion.allCases, id: \.self) { occasion in
                            Text(occasion.rawValue).tag(occasion)
                        }
                    }
                }
                
                Section(header: Text("Temperature Range (°C)")) {
                    VStack {
                        HStack {
                            Text("Min: \(Int(minTemp))°")
                            Spacer()
                            Text("Max: \(Int(maxTemp))°")
                        }
                        
                        Slider(value: $minTemp, in: -20...40, step: 1)
                            .tint(.blue)
                        
                        Slider(value: $maxTemp, in: -20...40, step: 1)
                            .tint(.red)
                    }
                }
                
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
    }
    
    private func saveItem() {
        let newItem = ClothingItem(
            name: name,
            type: selectedType,
            minTemp: minTemp,
            maxTemp: maxTemp,
            weatherTypes: Array(selectedWeatherTypes),
            occasion: selectedOccasion,
            color: color,
            isLayerable: isLayerable
        )
        
        wardrobeManager.addClothingItem(newItem)
        presentationMode.wrappedValue.dismiss()
    }
}


// MARK: PREVIEW
#Preview {
    AddClothingItemView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
