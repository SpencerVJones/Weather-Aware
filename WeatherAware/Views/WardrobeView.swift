//  WardrobeView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

import SwiftUI
import CoreData

struct WardrobeView: View {
    @EnvironmentObject var wardrobeManager: WardrobeManager
    @State private var showingAddItem = false
    
    var body: some View {
        NavigationView {
            List {
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
                    ForEach(wardrobeManager.clothingItems, id: \.id) { item in
                        ClothingItemRow(item: item)
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Wardrobe")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        showingAddItem = true
                    }
                }
            }
            .sheet(isPresented: $showingAddItem) {
                AddClothingItemView()
                    .environmentObject(wardrobeManager)
            }
        }
    }
    
    // Corrected delete function
    private func deleteItems(offsets: IndexSet) {
        wardrobeManager.removeClothingItem(at: offsets)
    }
}

// MARK: PREVIEW
#Preview {
    WardrobeView()
        .environmentObject(WardrobeManager())
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
