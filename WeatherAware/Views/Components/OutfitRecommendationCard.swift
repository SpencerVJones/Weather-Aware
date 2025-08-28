//  OutfitRecommendationCard.swift
//  WeatherAware
//  Created by Spencer Jones on 8/12/25

/*
A card view that displays an outfit recommendation based on weather and temperature.
If no recommendation is available, shows a placeholder prompting the user to add clothing items.
*/

import SwiftUI

struct OutfitRecommendationCard: View {
    let recommendation: OutfitRecommendation? // Optional outfit recommendation to display
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // MARK: - Header
            HStack {
                Text("Today's Outfit") // Card title
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer() // Pushes the confidence badge to the right
                
                // MARK: - Confidence Badge
                // Shows the confidence of the recommendation if available
                if let rec = recommendation {
                    ConfidenceBadge(confidence: rec.confidence)
                }
            }
            
            // MARK: - Recommendation Content
            if let rec = recommendation {
                VStack(alignment: .leading, spacing: 12) {
                    // Description text for weather and temperature
                    Text("Perfect for \(rec.weatherCondition) at \(TemperatureUtils.formatTemperature(rec.temperature))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Grid layout for clothing item previews
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                        ForEach(rec.items, id: \.id) { item in
                            ClothingItemPreview(item: item)
                        }
                    }
                    
                    // Layering recommendation if multiple layerable items exist
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
                // MARK: - Placeholder when no recommendation exists
                VStack(spacing: 12) {
                    Image(systemName: "tshirt") // Placeholder icon
                        .font(.system(size: 40))
                        .foregroundColor(.gray.opacity(0.5))
                    
                    Text("Add clothing items to get recommendations") // Prompt text
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

// MARK: - PREVIEW
#Preview {
    // Sample clothing items for preview
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
    
    // Mock outfit recommendation for preview
    let mockRecommendation = OutfitRecommendation(
        items: items,
        weatherCondition: "Sunny",
        temperature: 22,
        confidence: 0.85,
        date: Date() // Add a date for preview purposes
    )
    
    // Display the OutfitRecommendationCard with preview data
    OutfitRecommendationCard(recommendation: mockRecommendation)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
