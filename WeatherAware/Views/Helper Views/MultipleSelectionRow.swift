//
//  MultipleSelectionRow.swift
//  WeatherAware
//
//  Created by Spencer Jones on 8/22/25.
//

import Foundation
import SwiftUI

struct MultipleSelectionRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(.primary)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
}

// MARK: PREVIEW
#Preview {
    MultipleSelectionRow(
        title: "Option 1",
        isSelected: true,
        action: { print("Tapped Option 1") }
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
