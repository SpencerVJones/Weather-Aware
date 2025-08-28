//  ClothingItemRow.swift
//  WeatherAware
//  Created by Spencer Jones on 8/15/25

/*
This view displays a clothing item in a horizontal row format.
It shows either the item's saved photo or a fallback icon (SF Symbol),
alongside its name, type, color, temperature range, occasion, layerability,
and applicable weather conditions.
*/

import SwiftUI

struct ClothingItemRow: View {
    let item: ClothingItem // The clothing item being represented in the row
    
    var body: some View {
        HStack(spacing: 12) {
            // MARK: - Image/Icon Section
            ZStack {
                if let data = item.imageData, let uiImage = UIImage(data: data) {
                    // Show actual user-uploaded image if available
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } else {
                    // No image -> fallback to icon with colored circle
                    Circle()
                        .fill(colorForClothingType(item.type).opacity(0.1))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: iconForClothingType(item.type))
                        .foregroundColor(colorForClothingType(item.type))
                        .font(.system(size: 18, weight: .medium))
                }
            }
            
            // MARK: - Main Info Section
            VStack(alignment: .leading, spacing: 4) {
                // Item name
                Text(item.name)
                    .font(.headline)
                    .lineLimit(1)
                
                HStack {
                    // Clothing type badge
                    Text(item.type.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(colorForClothingType(item.type).opacity(0.1))
                        .cornerRadius(4)
                    
                    // Clothing color
                    Text(item.color)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // Display item’s suitable temperature range (in Fahrenheit)
                Text("\(Int(item.minTemp))-\(Int(item.maxTemp))°F")
                    .font(.caption2)
                    .foregroundColor(.blue)
            }
            
            Spacer() // Pushes right-side info to the edge
            
            // MARK: - Right-Side Labels Section
            VStack(alignment: .trailing, spacing: 4) {
                // Occasion badge (e.g., casual, formal)
                Text(item.occasion.rawValue)
                    .font(.caption2)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(4)
                
                // Layerability label
                if item.isLayerable {
                    Text("Layerable")
                        .font(.caption2)
                        .foregroundColor(.green)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 1)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(3)
                }
                
                // Weather type icons
                HStack(spacing: 2) {
                    ForEach(Array(item.weatherTypes.prefix(3)), id: \.self) { weather in
                        Image(systemName: iconForWeatherType(weather))
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding(.vertical)
    }
}

// MARK: - PREVIEW
#Preview {
    ClothingItemRow(item: ClothingItem(
        name: "Cotton T-Shirt",
        type: .top,
        minTemp: 59,
        maxTemp: 95,
        weatherTypes: [.sunny, .cloudy],
        occasion: .casual,
        color: "White",
        isLayerable: true
    ))
}
