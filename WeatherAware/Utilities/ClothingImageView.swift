//  ClothingImageView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/24/25

import SwiftUI

struct ClothingImageView: View {
    let imageData: Data?
    let placeholderSystemName: String

    var body: some View {
        Group {
            if let data = imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
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
