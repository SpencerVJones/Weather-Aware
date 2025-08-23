//  ClothingItemRow.swift
//  WeatherAware
//  Created by Spencer Jones on 8/15/25

import SwiftUI

struct ClothingItemRow: View {
    let item: ClothingItem
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon with background
            ZStack {
                Circle()
                    .fill(colorForClothingType(item.type).opacity(0.1))
                    .frame(width: 40, height: 40)
                
                Image(systemName: iconForClothingType(item.type))
                    .foregroundColor(colorForClothingType(item.type))
                    .font(.system(size: 18, weight: .medium))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .lineLimit(1)
                
                HStack {
                    Text(item.type.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(colorForClothingType(item.type).opacity(0.1))
                        .cornerRadius(4)
                    
                    Text(item.color)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text("\(Int(item.minTemp))-\(Int(item.maxTemp))°C")
                    .font(.caption2)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(item.occasion.rawValue)
                    .font(.caption2)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(4)
                
                if item.isLayerable {
                    Text("Layerable")
                        .font(.caption2)
                        .foregroundColor(.green)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 1)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(3)
                }
                
                // Weather types
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

// MARK: PREVIEW
#Preview {
    ClothingItemRow(item: ClothingItem(
        name: "Cotton T-Shirt",
        type: .top,
        minTemp: 15,
        maxTemp: 35,
        weatherTypes: [.sunny, .cloudy],
        occasion: .casual,
        color: "White",
        isLayerable: true
    ))
}
