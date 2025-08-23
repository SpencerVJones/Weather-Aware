//
//  InsightRow.swift
//  WeatherAware
//
//  Created by Spencer Jones on 8/22/25.
//

import Foundation
import SwiftUI

struct InsightRow: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 20)
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

// MARK: PREVIEW
#Preview {
    InsightRow(
        icon: "thermometer.medium",
        text: "Temperature is moderate today",
        color: .blue
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
