//  ConfidenceBadge.swift
//  WeatherAware
//  Created by Spencer Jones on 8/17/25

import Foundation
import SwiftUI

struct ConfidenceBadge: View {
    let confidence: Double
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: confidenceIcon)
                .font(.caption)
            
            Text("\(Int(confidence * 100))%")
                .font(.caption)
                .fontWeight(.medium)
        }
        .foregroundColor(confidenceColor)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(confidenceColor.opacity(0.1))
        .cornerRadius(8)
    }
    
    private var confidenceIcon: String {
        switch confidence {
        case 0.8...1.0:
            return "checkmark.circle.fill"
        case 0.6..<0.8:
            return "checkmark.circle"
        case 0.4..<0.6:
            return "questionmark.circle"
        default:
            return "exclamationmark.triangle"
        }
    }
    
    private var confidenceColor: Color {
        switch confidence {
        case 0.8...1.0:
            return .green
        case 0.6..<0.8:
            return .blue
        case 0.4..<0.6:
            return .orange
        default:
            return .red
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        ConfidenceBadge(confidence: 0.95)
        ConfidenceBadge(confidence: 0.75)
        ConfidenceBadge(confidence: 0.50)
        ConfidenceBadge(confidence: 0.25)
    }
    .padding()
}

// MARK: PREVIEW
#Preview {
    ConfidenceBadge(confidence: 0.75).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

