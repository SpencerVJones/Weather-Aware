//  ClothingTypeFilter.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

/*
A horizontal scrollable filter bar that displays all clothing types
as selectable "chips". Tapping a chip toggles whether that type
is included in the selected set.
*/

import Foundation
import SwiftUI

struct ClothingTypeFilter: View {
    // Binding to the parent view’s selected clothing types
    // This allows two-way data flow (filter selections update the parent state)
    @Binding var selectedTypes: Set<ClothingItem.ClothingType>
    
    var body: some View {
        // Horizontal scrolling container
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                // Loop through all clothing types (e.g., Top, Bottom, Shoes, etc.)
                ForEach(ClothingItem.ClothingType.allCases, id: \.self) { type in
                    // Create a chip for each clothing type
                    ClothingTypeChip(
                        type: type,
                        isSelected: selectedTypes.contains(type)
                    ) {
                        // Toggle selection: remove if already selected, add if not
                        if selectedTypes.contains(type) {
                            selectedTypes.remove(type)
                        } else {
                            selectedTypes.insert(type)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - PREVIEW
#Preview {
    // Example preview showing Top + Bottom preselected
    ClothingTypeFilter(
        selectedTypes: .constant([.top, .bottom])
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
