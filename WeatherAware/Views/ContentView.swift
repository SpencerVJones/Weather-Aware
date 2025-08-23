//  ContentView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var weatherService = WeatherService()
    @StateObject private var wardrobeManager = WardrobeManager()
    @StateObject private var recommendationEngine: RecommendationEngine
    
    init() {
        let wardrobeManager = WardrobeManager()
        self._wardrobeManager = StateObject(wrappedValue: wardrobeManager)
        self._recommendationEngine = StateObject(wrappedValue: RecommendationEngine(wardrobeManager: wardrobeManager))
    }
    
    var body: some View {
        TabView {
            HomeView()
                .environmentObject(weatherService)
                .environmentObject(wardrobeManager)
                .environmentObject(recommendationEngine)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            WardrobeView()
                .environmentObject(wardrobeManager)
                .tabItem {
                    Image(systemName: "tshirt.fill")
                    Text("Wardrobe")
                }
            
            WeeklyForecastView()
                .environmentObject(weatherService)
                .environmentObject(recommendationEngine)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Weekly")
                }
        }
        .accentColor(.weatherBlue)
    }
}

// MARK: PREVIEW
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
