//
//  WeatherAwareApp.swift
//  WeatherAware
//
//  Created by Spencer Jones on 8/11/25.
//

import SwiftUI

@main
struct WeatherAwareApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
