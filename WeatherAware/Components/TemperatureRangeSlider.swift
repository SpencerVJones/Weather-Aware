//
//  TemperatureRangeSlider.swift
//  WeatherAware
//
//  Created by Spencer Jones on 8/22/25.
//

import Foundation
import SwiftUI

struct TemperatureRangeSlider: View {
    @Binding var minTemp: Double
    @Binding var maxTemp: Double
    let range: ClosedRange<Double>
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Min: \(Int(minTemp))°")
                    .font(.caption)
                    .foregroundColor(.blue)
                Spacer()
                Text("Max: \(Int(maxTemp))°")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            
            ZStack {
                // Background track
                Rectangle()
                    .fill(Color(.systemGray5))
                    .frame(height: 6)
                    .cornerRadius(3)
                
                // Active range
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let minPosition = (minTemp - range.lowerBound) / (range.upperBound - range.lowerBound) * width
                    let maxPosition = (maxTemp - range.lowerBound) / (range.upperBound - range.lowerBound) * width
                    
                    Rectangle()
                        .fill(LinearGradient(
                            colors: [.blue, .red],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .frame(width: maxPosition - minPosition, height: 6)
                        .offset(x: minPosition)
                        .cornerRadius(3)
                }
                .frame(height: 6)
            }
            
            HStack {
                Slider(value: $minTemp, in: range, step: 1)
                    .tint(.blue)
                    .onChange(of: minTemp) { newValue in
                        if newValue >= maxTemp {
                            maxTemp = newValue + 1
                        }
                    }
                
                Slider(value: $maxTemp, in: range, step: 1)
                    .tint(.red)
                    .onChange(of: maxTemp) { newValue in
                        if newValue <= minTemp {
                            minTemp = newValue - 1
                        }
                    }
            }
        }
    }
}

// MARK: PREVIEW
#Preview {
    StatefulPreviewWrapper((min: 10.0, max: 25.0)) { state in
        TemperatureRangeSlider(
            minTemp: state.min,
            maxTemp: state.max,
            range: 0...40
        )
        .padding()
    }
}
