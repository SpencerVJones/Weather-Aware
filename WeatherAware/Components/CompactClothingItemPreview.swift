//
//  CompactClothingItemPreview.swift
//  WeatherAware
//
//  Created by Spencer Jones on 8/22/25.
//

import Foundation
import SwiftUI

struct CompactClothingItemPreview: View {
    let item: ClothingItem
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: iconForClothingType(item.type))
                .font(.title3)
                .foregroundColor(colorForClothingType(item.type))
            
            Text(item.name)
                .font(.caption2)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .padding(6)
        .frame(minHeight: 50)
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
