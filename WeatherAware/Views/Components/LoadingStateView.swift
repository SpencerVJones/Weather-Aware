//  LoadingStateView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

/*
A reusable view that represents a "loading" state in the app.
Displays a spinning progress indicator and a message to keep users informed
while data is being fetched or processed.
*/

import Foundation
import SwiftUI

struct LoadingStateView: View {
    let message: String // Text message displayed under the loading spinner
    
    var body: some View {
        VStack(spacing: 16) {
            // Progress spinner (system built-in activity indicator)
            ProgressView()
                .scaleEffect(1.5)
                .tint(.weatherBlue)
            
            // Loading message (e.g., "Loading your wardrobe…")
            Text(message)
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 100)
    }
}

// MARK: - PREVIEW
#Preview {
    // Example preview with a test message
    LoadingStateView(message: "Loading your wardrobe…")
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
