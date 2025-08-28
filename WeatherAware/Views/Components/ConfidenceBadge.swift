//  ConfidenceBadge.swift
//  WeatherAware
//  Created by Spencer Jones on 8/17/25

/*
A small badge component that visually represents a confidence score (0–1)
using both an icon and a percentage. Color and icon adapt to the confidence level.
*/

import Foundation
import SwiftUI

struct ConfidenceBadge: View {
    let confidence: Double // Confidence score between 0.0 and 1.0
    
    var body: some View {
        HStack(spacing: 4) {
            // Icon changes based on confidence level
            Image(systemName: confidenceIcon)
                .font(.caption)
            
            // Confidence displayed as a percentage
            Text("\(Int(confidence * 100))%")
                .font(.caption)
                .fontWeight(.medium)
        }
        .foregroundColor(confidenceColor) // Text + icon colored according to confidence
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(confidenceColor.opacity(0.1)) // Background uses a light version of the confidence color
        .cornerRadius(8)
    }
    
    // MARK: - Icon Logic
    private var confidenceIcon: String {
        switch confidence {
        case 0.8...1.0: // High confidence
            return "checkmark.circle.fill"
        case 0.6..<0.8: // Good confidence
            return "checkmark.circle"
        case 0.4..<0.6: // Medium/uncertain
            return "questionmark.circle"
        default: // Low confidence
            return "exclamationmark.triangle"
        }
    }
    
    // MARK: - Color Logic
    private var confidenceColor: Color {
        switch confidence {
        case 0.8...1.0:
            return .green // Strong confidence -> Green
        case 0.6..<0.8:
            return .blue // Moderate -> Blue
        case 0.4..<0.6:
            return .orange // Weak -> Orange
        default:
            return .red // Very low -> Red
        }
    }
}

// MARK: - PREVIEW
#Preview {
    // Showcase different confidence levels
    VStack(spacing: 16) {
        ConfidenceBadge(confidence: 0.95) // High -> Green
        ConfidenceBadge(confidence: 0.75) // Moderate -> Blue
        ConfidenceBadge(confidence: 0.50) // Medium -> Orange
        ConfidenceBadge(confidence: 0.25) // Low -> Red
    }
    .padding()
}
