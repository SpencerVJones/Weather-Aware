//  WeatherAwareApp.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct WeatherAwareApp: App {
    @StateObject private var weatherService = WeatherService()
    @StateObject private var recommendationEngine = RecommendationEngine(wardrobeManager: WardrobeManager())
     //   @StateObject private var wardrobeManager = WardrobeManager()
        @StateObject private var locationManager = LocationManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared
    
    init() {
          let wardrobeManager = WardrobeManager()
          _recommendationEngine = StateObject(wrappedValue: RecommendationEngine(wardrobeManager: wardrobeManager))
      }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
               .environmentObject(weatherService)
               .environmentObject(recommendationEngine)
               //.environmentObject(wardrobeManager)
               .environmentObject(locationManager)
               .onAppear { locationManager.request() } // ask on launch
                .onAppear {
                    setupAppearance()
                }
        }
    }
    
    private func setupAppearance() {
        // Configure navigation bar appearance
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.systemBackground
        navBarAppearance.shadowColor = UIColor.clear
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
        // Configure tab bar appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.systemBackground
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        // Set tint colors
        UINavigationBar.appearance().tintColor = UIColor(Color.weatherBlue)
        UITabBar.appearance().tintColor = UIColor(Color.weatherBlue)
    }
}

// MARK: - App Configuration
extension WeatherAwareApp {
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    static let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    
    static var isDebug: Bool {
#if DEBUG
        return true
#else
        return false
#endif
    }
}
