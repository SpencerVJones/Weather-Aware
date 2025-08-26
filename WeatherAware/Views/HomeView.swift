//  HomeView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject var weatherService: WeatherService
    @EnvironmentObject var recommendationEngine: RecommendationEngine
    @EnvironmentObject var locationManager: LocationManager
    
//    @State private var cityName = "London"
    @State private var isLocationPromptShown = false
    
    var body: some View {
            NavigationView {
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // Location header
                        HStack {
                            VStack(alignment: .leading) {
                                Text(locationManager.cityName ?? "Your Location")
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                
                                if let loc = locationManager.lastLocation {
                                    Text("Lat \(String(format: "%.3f", loc.coordinate.latitude)), Lon \(String(format: "%.3f", loc.coordinate.longitude))")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            Spacer()
                            Button("Use My Location") {
                                locationManager.request()
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding(.horizontal)
                        
    //                    // City Input
    //                    VStack(alignment: .leading, spacing: 8) {
    //                        Text("Location")
    //                            .font(.headline)
    //
    //                        HStack {
    //                            TextField("Enter city name", text: $cityName)
    //                                .textFieldStyle(RoundedBorderTextFieldStyle())
    //
    //                            Button("Update") {
    //                                Task {
    //                                    await weatherService.fetchWeatherForCity(cityName)
    //                                }
    //                            }
    //                            .buttonStyle(.borderedProminent)
    //                            .disabled(weatherService.isLoading)
    //                        }
    //                    }
    //                    .padding(.horizontal)
                        
                        
    //                    if weatherService.isLoading {
    //                        ProgressView("Loading weather...")
    //                            .frame(maxWidth: .infinity, minHeight: 100)
    //
    //
    //
    //                    } else if let weather = weatherService.currentWeather {
    //                        // Weather Card
    //                        WeatherCard(weather: weather)
    //                            .padding(.horizontal)
    //
    //                        // Outfit Recommendation
    //                        OutfitRecommendationCard(recommendation: recommendationEngine.currentRecommendation)
    //                            .padding(.horizontal)
    //
    //                        // Quick Weather Insights
    //                        WeatherInsightsCard(weather: weather)
    //                            .padding(.horizontal)
                        
                        
                        if weatherService.isLoading {
                            ProgressView("Loading weather...")
                                .frame(maxWidth: .infinity, minHeight: 100)
                        } else if let weather = weatherService.currentWeather {
                            WeatherCard(weather: weather).padding(.horizontal)
                            OutfitRecommendationCard(recommendation: recommendationEngine.currentRecommendation).padding(.horizontal)
                            WeatherInsightsCard(weather: weather).padding(.horizontal)
                            
                        } else if let error = weatherService.errorMessage {
                            VStack(spacing: 16) {
                                Image(systemName: "exclamationmark.triangle")
                                    .font(.system(size: 40))
                                    .foregroundColor(.orange)
                                
                                Text("Weather Unavailable")
                                    .font(.headline)
                                
                                Text(error)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.secondary)
                                
    //                            Button("Try Again") {
    //                                Task {
    //                                    await weatherService.fetchWeatherForCity(cityName)
    //                                }
    //                            }
    //                            .buttonStyle(.borderedProminent)
                                
                                Button("Try Again") {
                                    Task {
                                        await fetchUsingLocationIfPossible()
                                    }
                                }
                                .buttonStyle(.borderedProminent)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 200)
                            
    //                        }
    //                        .padding()
    //                        .frame(maxWidth: .infinity, minHeight: 200)
    //                    } else {
    //                        // Initial state
    //                        VStack(spacing: 16) {
    //                            Image(systemName: "cloud.sun")
    //                                .font(.system(size: 50))
    //                                .foregroundColor(.weatherBlue)
    //
    //                            Text("Welcome to WeatherAware")
    //                                .font(.title2)
    //                                .fontWeight(.semibold)
    //
    //                            Text("Enter a city name to get started with personalized outfit recommendations")
    //                                .multilineTextAlignment(.center)
    //                                .foregroundColor(.secondary)
    //                        }
    //                        .padding()
    //                        .frame(maxWidth: .infinity, minHeight: 200)
    //                    }
    //                }
    //                .padding(.bottom, 20)
    //            }
    //            .navigationTitle("Today")
    //            .onAppear {
    //                Task {
    //                    await weatherService.fetchWeatherForCity(cityName)
    //                }
    //            }
    //            .onChange(of: weatherService.currentWeather?.current.temp) { _ in
    //                if let weather = weatherService.currentWeather {
    //                    recommendationEngine.generateRecommendation(for: weather)
    //                }
    //            }
                        } else {
                            // initial state
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
                .task { await fetchUsingLocationIfPossible() }
                .onChange(of: locationManager.lastLocation) { oldValue, newValue in
                    Task { await fetchUsingLocationIfPossible() }
                }
                .onChange(of: weatherService.currentWeather?.current.temp) { oldValue, newValue in
                    if let weather = weatherService.currentWeather {
                        recommendationEngine.generateRecommendation(for: weather)
                    }
                }
            }
        }
        
    private func fetchUsingLocationIfPossible() async {
           guard let loc = locationManager.lastLocation else { return }
           await weatherService.fetchWeather(lat: loc.coordinate.latitude, lon: loc.coordinate.longitude)
       }
   }

    // MARK: PREVIEW
    #Preview {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
