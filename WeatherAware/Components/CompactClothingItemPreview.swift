//  CompactClothingItemPreview.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

import Foundation
import SwiftUI

struct CompactClothingItemPreview: View {
    let item: ClothingItem

    var body: some View {
        VStack(spacing: 6) {
            // If imageData exists, show it, else show SF Symbol for clothing type
            ClothingImageView(
                imageData: item.imageData,
                placeholderSystemName: iconForClothingType(item.type)
            )
            .frame(width: 44, height: 44)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 8))

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

// MARK: PREVIEW
#Preview {
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
