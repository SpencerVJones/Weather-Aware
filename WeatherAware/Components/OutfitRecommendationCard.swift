//  OutfitRecommendationCard.swift
//  WeatherAware
//  Created by Spencer Jones on 8/12/25

import SwiftUI

struct OutfitRecommendationCard: View {
    let recommendation: OutfitRecommendation?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Today's Outfit")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                if let rec = recommendation {
                    ConfidenceBadge(confidence: rec.confidence)
                }
            }
            
            if let rec = recommendation {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Perfect for \(rec.weatherCondition) at \(TemperatureUtils.formatTemperature(rec.temperature))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                        ForEach(rec.items, id: \.id) { item in
                            ClothingItemPreview(item: item)
                        }
                    }
                    
                    if rec.items.filter({ $0.isLayerable }).count > 1 {
                        HStack {
                            Image(systemName: "layers.fill")
                                .foregroundColor(.orange)
                            Text("Layering recommended")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                        .padding(.top, 4)
                    }
                }
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "tshirt")
                        .font(.system(size: 40))
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("Add clothing items to get recommendations")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

// MARK: PREVIEW
#Preview {
    let items = [
        ClothingItem(
            name: "Blue Jacket",
            type: .outerwear,
            minTemp: 5,
            maxTemp: 15,
            weatherTypes: [.rainy, .windy],
            occasion: .casual,
            color: "Blue",
            isLayerable: true
        ),
        ClothingItem(
            name: "Jeans",
            type: .bottom,
            minTemp: 10,
            maxTemp: 20,
            weatherTypes: [.sunny],
            occasion: .casual,
            color: "Blue",
            isLayerable: true
        ),
        ClothingItem(
            name: "Sneakers",
            type: .shoes,
            minTemp: 5,
            maxTemp: 25,
            weatherTypes: [.sunny, .cloudy],
            occasion: .casual,
            color: "White",
            isLayerable: false
        )
    ]
    
    let mockRecommendation = OutfitRecommendation(
        items: items,
        weatherCondition: "Sunny",
        temperature: 22,
        confidence: 0.85,
        date: Date() // Add a date for preview
    )
    
    OutfitRecommendationCard(recommendation: mockRecommendation)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
