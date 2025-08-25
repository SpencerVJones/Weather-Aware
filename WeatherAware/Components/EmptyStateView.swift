//  EmptyStateView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

import Foundation
import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    let actionTitle: String?
    let action: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(.gray.opacity(0.5))
            
            Text(title)
                .font(.headline)
            
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            if let actionTitle = actionTitle, let action = action {
                Button(actionTitle, action: action)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

// MARK: PREVIEW
#Preview {
    EmptyStateView(
        icon: "tray",
        title: "No Items Found",
        message: "It looks like you don’t have any clothing items yet. Add some to get started!",
        actionTitle: "Add Item",
        action: { print("Add Item tapped") }
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
