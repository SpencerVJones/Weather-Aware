//
//  ClothingTypeFilter.swift
//  WeatherAware
//
//  Created by Spencer Jones on 8/22/25.
//

import Foundation
import SwiftUI

struct ClothingTypeFilter: View {
    @Binding var selectedTypes: Set<ClothingItem.ClothingType>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(ClothingItem.ClothingType.allCases, id: \.self) { type in
                    ClothingTypeChip(
                        type: type,
                        isSelected: selectedTypes.contains(type)
                    ) {
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

// MARK: PREVIEW
#Preview {
    ClothingTypeFilter(
        selectedTypes: .constant([.top, .bottom])
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
