//  WeeklyForecastView.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

import SwiftUI
import CoreData

struct WeeklyForecastView: View {
    @EnvironmentObject var weatherService: WeatherService
    @EnvironmentObject var recommendationEngine: RecommendationEngine
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    if let weather = weatherService.currentWeather {
                        ForEach(Array(recommendationEngine.weeklyRecommendations.enumerated()), id: \.offset) { index, weeklyRec in
                            WeeklyRecommendationCard(recommendation: weeklyRec)
                                .padding(.horizontal)
                        }
                    } else {
                        VStack(spacing: 16) {
                            Image(systemName: "calendar.badge.exclamationmark")
                                .font(.system(size: 40))
                                .foregroundColor(.gray.opacity(0.5))
                            
                            Text("No Forecast Available")
                                .font(.headline)
                            
                            Text("Visit the Home tab to load weather data first")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 200)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Weekly Forecast")
            .onAppear {
                if let weather = weatherService.currentWeather {
                    recommendationEngine.generateWeeklyRecommendations(for: weather)
                }
            }
            .onChange(of: weatherService.currentWeather?.current.dt) { _ in
                if let weather = weatherService.currentWeather {
                    recommendationEngine.generateWeeklyRecommendations(for: weather)
                }
            }

        }
    }
}

// MARK: PREVIEW
#Preview {
    WeeklyForecastView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

