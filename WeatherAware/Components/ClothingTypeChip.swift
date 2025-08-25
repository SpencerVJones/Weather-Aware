//  ClothingTypeChip.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

import Foundation
import SwiftUI

struct ClothingTypeChip: View {
    let type: ClothingItem.ClothingType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: iconForClothingType(type))
                    .font(.caption)
                
                Text(type.rawValue)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .foregroundColor(isSelected ? .white : colorForClothingType(type))
            .background(
                isSelected ?
                colorForClothingType(type) :
                colorForClothingType(type).opacity(0.1)
            )
            .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: PREVIEW
#Preview {
    VStack(spacing: 12) {
        // Show both selected and unselected states
        ClothingTypeChip(
            type: .top,
            isSelected: true,
            action: { print("Top selected") }
        )
        
        ClothingTypeChip(
            type: .bottom,
            isSelected: false,
            action: { print("Bottom selected") }
        )
        
        ClothingTypeChip(
            type: .outerwear,
            isSelected: true,
            action: { print("Outerwear selected") }
        )
    }
    .padding()
}
