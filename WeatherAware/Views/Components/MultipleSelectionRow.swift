//  MultipleSelectionRow.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

/*
Represents a single row in a multiple selection list.
Displays a title and, if selected, a checkmark.
Tapping the row triggers a customizable action closure.
*/

import Foundation
import SwiftUI

// A view representing one selectable row in a multiple selection list
struct MultipleSelectionRow: View {
    // MARK: - Properties
    let title: String // The title displayed for this row
    let isSelected: Bool // Whether this row is currently selected
    let action: () -> Void // Action to perform when the row is tapped
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            HStack {
                // Display the title
                Text(title)
                    .foregroundColor(.primary)
                
                Spacer()
                
                // Show checkmark if the row is selected
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    MultipleSelectionRow(
        title: "Option 1",
        isSelected: true,
        action: { print("Tapped Option 1") }
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
