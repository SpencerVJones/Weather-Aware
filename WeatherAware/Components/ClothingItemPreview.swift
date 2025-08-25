//  ClothingItemPreview.swift
//  WeatherAware
//  Created by Spencer Jones on 8/12/25

import SwiftUI

struct ClothingItemPreview: View {
    let item: ClothingItem
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: iconForClothingType(item.type))
                .font(.title2)
                .foregroundColor(colorForClothingType(item.type))
            
            Text(item.name)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            Text(item.color)
                .font(.caption2)
                .foregroundColor(.secondary)
                .padding(.horizontal, 4)
                .padding(.vertical, 1)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(4)
        }
        .padding(8)
        .frame(minHeight: 80)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private func iconForClothingType(_ type: ClothingItem.ClothingType) -> String {
        switch type {
        case .top: return "tshirt"
        case .bottom: return "button.angledbottom.horizontal.right"
        case .outerwear: return "jacket"
        case .shoes: return "shoe"
        case .accessory: return "eyeglasses"
        }
    }
    
    private func colorForClothingType(_ type: ClothingItem.ClothingType) -> Color {
        switch type {
        case .top: return .blue
        case .bottom: return .purple
        case .outerwear: return .green
        case .shoes: return .brown
        case .accessory: return .orange
        }
    }
}

// MARK: PREVIEW
#Preview {
    ClothingItemPreview(item: .init(name: "Test Item", type: .bottom, minTemp: 0, maxTemp: 100, weatherTypes: [], occasion: .casual, color: "Blue", isLayerable: false)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
