//  ClothingTypeChip.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

/*
A reusable UI component that represents a clothing type as a "chip"
(a small rounded button with an icon and text).
It highlights when selected and uses consistent colors based on clothing type.
*/

import Foundation
import SwiftUI

struct ClothingTypeChip: View {
    let type: ClothingItem.ClothingType // The clothing type this chip represents
    let isSelected: Bool // Whether the chip is currently selected
    let action: () -> Void // Action triggered when the chip is tapped
    
    var body: some View {
        // MARK: - Button wrapper
        Button(action: action) {
            HStack(spacing: 6) {
                // Clothing type icon (SF Symbol based on type)
                Image(systemName: iconForClothingType(type))
                    .font(.caption)
                
                // Clothing type text label (e.g., "Top", "Shoes")
                Text(type.rawValue)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .foregroundColor(isSelected ? .white : colorForClothingType(type))  // Text and icon color depend on selection state
            .background(
                isSelected ?
                colorForClothingType(type) :
                    colorForClothingType(type).opacity(0.1)
            )  // Background also depends on selection state
            .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - PREVIEW
#Preview {
    VStack(spacing: 12) {
        // Example: selected chip for "Top"
        ClothingTypeChip(
            type: .top,
            isSelected: true,
            action: { print("Top selected") }
        )
        // Example: unselected chip for "Bottom"
        ClothingTypeChip(
            type: .bottom,
            isSelected: false,
            action: { print("Bottom selected") }
        )
        // Example: selected chip for "Outerwear"
        ClothingTypeChip(
            type: .outerwear,
            isSelected: true,
            action: { print("Outerwear selected") }
        )
    }
    .padding()
}
