//  WeatherAwareApp.swift
//  WeatherAware
//  Created by Spencer Jones on 8/11/25

/*
Entry point of the WeatherAware app.
Configures Firebase, Core Data, and app-wide appearance settings.
*/

import SwiftUI
import FirebaseCore
import CoreData

// MARK: - AppDelegate for Firebase Setup
class AppDelegate: NSObject, UIApplicationDelegate {
    // Called when the app has finished launching.
    // Configures Firebase for the application.
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

// MARK: - Main App Struct
@main
struct WeatherAwareApp: App {
    // Connect the custom AppDelegate for Firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // Shared Core Data persistence controller
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView() // Root view of the app
                .environment(\.managedObjectContext, persistenceController.container.viewContext) // Inject Core Data context
                .onAppear { setupAppearance() } // Set app-wide appearance when the view appears
        }
    }
    
    // MARK: - Appearance Setup
    // Configures the navigation bar and tab bar appearances across the app.
    private func setupAppearance() {
        // Navigation bar appearance
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.systemBackground
        navBarAppearance.shadowColor = UIColor.clear
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
        // Tab bar appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.systemBackground
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        // Set tint colors for navigation and tab bars
        UINavigationBar.appearance().tintColor = UIColor(Color.weatherBlue)
        UITabBar.appearance().tintColor = UIColor(Color.weatherBlue)
    }
}

// MARK: - App Configuration Info
extension WeatherAwareApp {
    // App version from Info.plist
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    
    // Build number from Info.plist
    static let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    
    // Returns true if the app is currently running in debug mode
    static var isDebug: Bool {
#if DEBUG
        return true
#else
        return false
#endif
    }
}
