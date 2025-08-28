//  ContentView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

/*
The main entry point for the app. Sets up environment objects for
weather, location, wardrobe, and recommendations. Uses a TabView
to switch between Home and Wardrobe screens.
*/

import SwiftUI
import CoreData

// The main content view that sets up environment objects and launches the app UI
struct ContentView: View {
    // MARK: - Environment
    @Environment(\.managedObjectContext) private var viewContext // Core Data context
    
    // MARK: - State Objects
    @StateObject private var weatherService = WeatherService() // Handles fetching and storing weather data
    @StateObject private var locationManager = LocationManager() // Handles location permission and updates
    
    var body: some View {
        // Initialize single instances for this app session
        let wardrobeManager = WardrobeManager(viewContext: viewContext)
        let recommendationEngine = RecommendationEngine(wardrobeManager: wardrobeManager)
        
        // Pass environment objects down the view hierarchy
        ContentViewContent()
            .environmentObject(weatherService)
            .environmentObject(locationManager)
            .environmentObject(wardrobeManager)
            .environmentObject(recommendationEngine)
            .onAppear {
                // Request location access when app launches
                locationManager.request()
            }
    }
}

// A separate view for the TabView content to keep ContentView clean
struct ContentViewContent: View {
    // Access environment objects
    @EnvironmentObject var weatherService: WeatherService
    @EnvironmentObject var wardrobeManager: WardrobeManager
    @EnvironmentObject var recommendationEngine: RecommendationEngine
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        TabView {
            // MARK: - Home Tab
            HomeView()
                .environmentObject(weatherService)
                .environmentObject(wardrobeManager)
                .environmentObject(recommendationEngine)
                .environmentObject(locationManager)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            // MARK: - Wardrobe Tab
            WardrobeView()
                .environmentObject(wardrobeManager)
                .tabItem {
                    Image(systemName: "tshirt.fill")
                    Text("Wardrobe")
                }
        }
        .accentColor(.weatherBlue) // Sets the active tab color
    }
}

// MARK: - Preview
#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
