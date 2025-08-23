//
//  LoadingStateView.swift
//  WeatherAware
//
//  Created by Spencer Jones on 8/22/25.
//

import Foundation
import SwiftUI

struct LoadingStateView: View {
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
                .tint(.weatherBlue)
            
            Text(message)
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 100)
    }
}

// MARK: PREVIEW
#Preview {
    LoadingStateView(message: "Loading your wardrobe…")
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

