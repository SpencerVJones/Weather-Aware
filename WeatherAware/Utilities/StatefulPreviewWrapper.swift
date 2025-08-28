//  StatefulPreviewWrapper.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

/*
This file defines a generic SwiftUI wrapper that allows you to use @State
properties in SwiftUI previews. Normally, previews are static and cannot
hold mutable state. This wrapper provides a binding to a mutable value
so that interactive previews (e.g., sliders, toggles) work correctly.
*/

import Foundation
import SwiftUI

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value // The internal state value that can be mutated in the preview
    private let content: (Binding<Value>) -> Content // A closure that receives a Binding to the state value and returns the content view
    
    // Initialize with an initial state value and a content builder closure
    /// - Parameters:
    ///   - initialValue: The starting value for the state
    ///   - content: Closure that receives a Binding<Value> and returns a view
    init(_ initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: initialValue)
        self.content = content
    }
    
    var body: some View {
        // Pass the binding to the content closure
        content($value)
    }
}
