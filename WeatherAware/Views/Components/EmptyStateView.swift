//  EmptyStateView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

/*
A reusable view that displays an "empty state" when there is no data to show.
Typically used for empty wardrobes.
Includes an icon, title, message, and optional action button.
*/

import Foundation
import SwiftUI

struct EmptyStateView: View {
    let icon: String // SF Symbol name for the icon
    let title: String // Main title text (e.g., "No Items Found")
    let message: String // Supporting message to explain the empty state
    let actionTitle: String? // Optional button label (e.g., "Add Item")
    let action: (() -> Void)? // Optional closure to run when button is tapped
    
    var body: some View {
        VStack(spacing: 16) {
            // Icon at the top (large, light gray)
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(.gray.opacity(0.5))
            
            // Title (bold headline)
            Text(title)
                .font(.headline)
            
            // Supporting description (smaller, gray text, centered)
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            // Optional action button (only shown if both title + action are provided)
            if let actionTitle = actionTitle, let action = action {
                Button(actionTitle, action: action)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

// MARK: - PREVIEW
#Preview {
    EmptyStateView(
        icon: "tray", // Tray icon indicates emptiness
        title: "No Items Found", // Headline text
        message: "It looks like you don’t have any clothing items yet. Add some to get started!",
        actionTitle: "Add Item", // Action button
        action: { print("Add Item tapped") } // Debug action for preview
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
