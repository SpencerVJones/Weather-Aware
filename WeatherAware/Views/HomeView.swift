//  HomeView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

/*
Displays the main home screen showing current weather, outfit recommendations,
and weather insights. Handles location-based weather fetching and error states.
*/

import SwiftUI
import CoreData

struct HomeView: View {
    // MARK: - Environment Objects
    @EnvironmentObject var weatherService: WeatherService// Provides current weather data
    @EnvironmentObject var recommendationEngine: RecommendationEngine // Provides outfit recommendations
    @EnvironmentObject var locationManager: LocationManager // Handles location updates and permissions
    
    // MARK: - Local State
    @State private var isLocationPromptShown = false // Tracks whether location prompt is displayed
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // MARK: - Location Header
                    HStack {
                        VStack(alignment: .leading) {
                            // Display city name or fallback text
                            Text(locationManager.cityName ?? "Your Location")
                                .font(.headline)
                                .foregroundStyle(.primary)
                            
                            // Display coordinates if available
                            if let loc = locationManager.lastLocation {
                                Text("Lat \(String(format: "%.3f", loc.coordinate.latitude)), Lon \(String(format: "%.3f", loc.coordinate.longitude))")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        Spacer()
                        
                        // Button to request current location again
                        Button("Use My Location") {
                            locationManager.request()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Weather & Recommendations
                    if weatherService.isLoading {
                        // Show loading indicator while fetching weather
                        ProgressView("Loading weather...")
                            .frame(maxWidth: .infinity, minHeight: 100)
                    } else if let weather = weatherService.currentWeather {
                        // Show weather card, outfit recommendation, and insight
                        WeatherCard(weather: weather).padding(.horizontal)
                        OutfitRecommendationCard(recommendation: recommendationEngine.currentRecommendation).padding(.horizontal)
                        WeatherInsightsCard(weather: weather).padding(.horizontal)
                        
                    } else if let error = weatherService.errorMessage {
                        // Display error state if fetching fails
                        VStack(spacing: 16) {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.system(size: 40))
                                .foregroundColor(.orange)
                            
                            Text("Weather Unavailable")
                                .font(.headline)
                            
                            Text(error)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                            
                            
                            Button("Try Again") {
                                Task {
                                    await fetchUsingLocationIfPossible()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 200)
                        
                        
                    } else {
                        // Initial state before weather data is fetched
                        VStack(spacing: 16) {
                            Image(systemName: "location")
                                .font(.system(size: 50))
                                .foregroundColor(.weatherBlue)
                            Text("Getting your local weather…")
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 200)
                    }
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("Today")
            .task { await fetchUsingLocationIfPossible() } // Fetch weather on first load
            .onChange(of: locationManager.lastLocation) { oldValue, newValue in
                // Refetch weather if location changes
                Task { await fetchUsingLocationIfPossible() }
            }
            .onChange(of: weatherService.currentWeather?.current.temp) { oldValue, newValue in
                // Regenerate outfit recommendation when temperature changes
                if let weather = weatherService.currentWeather {
                    recommendationEngine.generateRecommendation(for: weather)
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    // Fetch weather using the current location if available
    private func fetchUsingLocationIfPossible() async {
        guard let loc = locationManager.lastLocation else { return }
        await weatherService.fetchWeather(lat: loc.coordinate.latitude, lon: loc.coordinate.longitude)
    }
}
    
// MARK: - Preview
#Preview {
    HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
