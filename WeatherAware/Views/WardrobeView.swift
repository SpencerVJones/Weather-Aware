// WardrobeView.swift
// WeatherAware
// Created by Spencer Jones on 8/11/25

/*
Displays the user's wardrobe, allowing viewing, adding, and deleting clothing items.
Shows a placeholder view when no clothing items are present.
*/

import SwiftUI
import CoreData

struct WardrobeView: View {
    // MARK: - Environment Objects
    @EnvironmentObject var wardrobeManager: WardrobeManager // Manages the user's clothing items
    
    // MARK: - Local State
    @State private var showingAddItem = false // Controls whether AddClothingItemView sheet is presented
    
    
    var body: some View {
        NavigationView {
            List {
                // MARK: - Placeholder when wardrobe is empty
                if wardrobeManager.clothingItems.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "tshirt")
                            .font(.system(size: 40))
                            .foregroundColor(.gray.opacity(0.5))
                        
                        Text("No Clothing Items")
                            .font(.headline)
                        
                        Text("Add your first clothing item to get personalized outfit recommendations")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                        
                        Button("Add Item") {
                            showingAddItem = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                } else {
                    // MARK: - Display clothing items
                    ForEach(wardrobeManager.clothingItems, id: \.id) { item in
                        ClothingItemRow(item: item) // Custom row view for each item
                    }
                    .onDelete(perform: deleteItems) // Swipe to delete functionality
                }
            }
            .navigationTitle("Wardrobe")
            .toolbar {
                // MARK: - Add button in the navigation bar
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") { showingAddItem = true }
                }
            }
            // MARK: - Sheet to add new clothing item
            .sheet(isPresented: $showingAddItem) {
                AddClothingItemView()
                    .environmentObject(wardrobeManager) // Pass the manager to the sheet
            }
        }
    }
    
    // MARK: - Helper Methods
    // Deletes clothing items from the wardrobe
    /// - Parameter offsets: IndexSet of items to delete
    private func deleteItems(offsets: IndexSet) {
        wardrobeManager.removeClothingItem(at: offsets)
    }
}

// MARK: - Preview
#Preview {
    WardrobeView()
        .environmentObject(WardrobeManager(viewContext: PersistenceController.preview.container.viewContext))
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
