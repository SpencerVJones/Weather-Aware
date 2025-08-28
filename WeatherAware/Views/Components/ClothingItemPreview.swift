//  ClothingItemPreview.swift
//  WeatherAware
//  Created by Spencer Jones on 8/12/25

/*
This view displays a clothing item in a compact card-style format.
It shows either the user-uploaded photo (if available) or falls back
to a relevant SF Symbol icon based on the clothing type.
Each item also displays its name and color for clarity.
*/
import SwiftUI

struct ClothingItemPreview: View {
    let item: ClothingItem // The clothing item being displayed
    
    var body: some View {
        VStack(spacing: 5) {
            if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                // If the item has stored image data, show the actual photo
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipped()
                    .cornerRadius(8)
            } else {
                // Otherwise, fall back to a default SF Symbol icon
                Image(systemName: iconForClothingType(item.type))
                    .font(.title2)
                    .foregroundColor(colorForClothingType(item.type))
                    .frame(width: 60, height: 60)
            }
            
            // Clothing item name
            Text(item.name)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            // Clothing item color (visual label)
            Text(item.color)
                .font(.caption2)
                .foregroundColor(.secondary)
                .padding(.horizontal, 4)
                .padding(.vertical, 1)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(4)
        }
        .padding(8)
        .frame(minHeight: 100)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    // MARK: - Icon Mapping
    
    // Returns a relevant SF Symbol string for each clothing type.
    private func iconForClothingType(_ type: ClothingItem.ClothingType) -> String {
        switch type {
        case .top: return "tshirt"
        case .bottom: return "figure.walk"
        case .outerwear: return "wind"
        case .shoes: return "shoeprints.fill"
        case .accessory: return "eyeglasses"
        }
    }
    
    // Returns a default color for the clothing type (used for SF Symbols).
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

// MARK: - PREVIEW
#Preview {
    // Example preview item without an image
    ClothingItemPreview(
        item: .init(
            name: "Test Item",
            type: .bottom,
            minTemp: 0,
            maxTemp: 100,
            weatherTypes: [],
            occasion: .casual,
            color: "Blue",
            isLayerable: false
        )
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
