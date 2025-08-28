//  TemperatureRangeSlider.swift
//  WeatherAware
//  Created by Spencer Jones on 8/16/25

/*
A dual slider allowing the user to select a minimum and maximum temperature within a given range.
Displays both the numeric values and a colored gradient representing the active temperature range.
*/

import Foundation
import SwiftUI

struct TemperatureRangeSlider: View {
    @Binding var minTemp: Double // Binding for the minimum temperature selected by the user
    @Binding var maxTemp: Double // Binding for the maximum temperature selected by the user
    let range: ClosedRange<Double> // Full allowed temperature range
    
    var body: some View {
        VStack(spacing: 12) { // Vertical stack for labels, track, and sliders
            // MARK: - Temperature Labels
            HStack {
                // Displays current minimum temperature
                Text("Min: \(Int(minTemp))°")
                    .font(.caption)
                    .foregroundColor(.blue)
                Spacer()
                // Displays current maximum temperature
                Text("Max: \(Int(maxTemp))°")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            
            // MARK: - Slider Track
            ZStack {
                // Background track (full range)
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(height: 6)
                    .cornerRadius(3)
                
                // Active selected range track
                GeometryReader { geometry in
                    let width = geometry.size.width
                    // Calculate relative positions of min and max within the total width
                    let minPosition = (minTemp - range.lowerBound) / (range.upperBound - range.lowerBound) * width
                    let maxPosition = (maxTemp - range.lowerBound) / (range.upperBound - range.lowerBound) * width
                    
                    Rectangle()
                        .fill(LinearGradient(
                            colors: [.blue, .red], // Gradient from min to max
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .frame(width: maxPosition - minPosition, height: 6)
                        .offset(x: minPosition) // Position rectangle starting at minTemp
                        .cornerRadius(3)
                }
                .frame(height: 6) // Fix height of active range track
            }
            
            // MARK: - Sliders
            HStack {
                // Slider for minimum temperature
                Slider(value: $minTemp, in: range, step: 1)
                    .tint(.blue)
                // Ensure minTemp does not exceed maxTemp
                    .onChange(of: minTemp) { newValue in
                        if newValue >= maxTemp {
                            maxTemp = newValue + 1
                        }
                    }
                
                // Slider for maximum temperature
                Slider(value: $maxTemp, in: range, step: 1)
                    .tint(.red)
                    .onChange(of: maxTemp) { newValue in
                        // Ensure maxTemp does not fall below minTemp
                        if newValue <= minTemp {
                            minTemp = newValue - 1
                        }
                    }
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    // Use a stateful wrapper to preview a binding in SwiftUI
    StatefulPreviewWrapper((min: 10.0, max: 25.0)) { state in
        TemperatureRangeSlider(
            minTemp: state.min,
            maxTemp: state.max,
            range: 0...40 // Define the allowed temperature range
        )
        .padding()
    }
}
