//  ClothingImageView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/24/25

/*
 A view that displays a clothing item's image if available,
or a placeholder system image if no image data is provided.
*/

import SwiftUI

struct ClothingImageView: View {
    let imageData: Data? // Optional image data (JPEG/PNG) for the clothing item
    let placeholderSystemName: String // System image name to show when no image data exists
    
    var body: some View {
        Group {
            if let data = imageData, let uiImage = UIImage(data: data) {
                // Display the actual clothing image
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                // Display placeholder system image
                Image(systemName: placeholderSystemName)
                    .resizable()
                    .scaledToFit()
                    .padding(16)
                    .foregroundColor(.secondary)
            }
        }
        .clipped()
    }
}

// MARK: - PREVIEW
#Preview {
    VStack(spacing: 20) {
        // Preview with placeholder image
        ClothingImageView(
            imageData: nil,
            placeholderSystemName: "tshirt"
        )
        .frame(width: 100, height: 100)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        
        // Preview with sample image data
        if let sampleImage = UIImage(systemName: "tshirt")?.pngData() {
            ClothingImageView(
                imageData: sampleImage,
                placeholderSystemName: "tshirt"
            )
            .frame(width: 100, height: 100)
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
    .padding()
}
