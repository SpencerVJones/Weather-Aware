//  CompactClothingItemPreview.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

/*
A compact visual representation of a clothing item.
Shows either the clothing photo (if available) or a fallback icon,
along with the item’s name in a small card-like design.
*/

import Foundation
import SwiftUI

struct CompactClothingItemPreview: View {
    let item: ClothingItem // Clothing item to be displayed
    
    var body: some View {
        VStack(spacing: 6) {
            // Display clothing image if available; otherwise use an SF Symbol as fallback
            ClothingImageView(
                imageData: item.imageData, // User-uploaded photo (optional)
                placeholderSystemName: iconForClothingType(item.type) // Default icon if no image
            )
            .frame(width: 44, height: 44)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Item name displayed under the image
            Text(item.name)
                .font(.caption2)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .padding(6)
        .frame(minHeight: 70)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

// MARK: - PREVIEW
#Preview {
    // Example preview item (mock clothing item)
    let item = ClothingItem(
        name: "Blue Jacket",
        type: .outerwear,
        minTemp: 5,
        maxTemp: 15,
        weatherTypes: [.rainy, .windy],
        occasion: .casual,
        color: "Blue",
        isLayerable: true
    )
    
    CompactClothingItemPreview(item: item)
}
