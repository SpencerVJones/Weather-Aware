//
//  UserDefaults.swift
//  WeatherAware
//
//  Created by Spencer Jones on 8/22/25.
//

import Foundation

extension UserDefaults {
    enum Keys {
        static let clothingItems = "clothingItems"
        static let defaultCity = "defaultCity"
        static let temperatureUnit = "temperatureUnit"
        static let lastWeatherUpdate = "lastWeatherUpdate"
    }
    
    var defaultCity: String {
        get { string(forKey: Keys.defaultCity) ?? "London" }
        set { set(newValue, forKey: Keys.defaultCity) }
    }
    
    var temperatureUnit: TemperatureUnit {
        get {
            if let rawValue = object(forKey: Keys.temperatureUnit) as? String,
               let unit = TemperatureUnit(rawValue: rawValue) {
                return unit
            }
            return .celsius
        }
        set { set(newValue.rawValue, forKey: Keys.temperatureUnit) }
    }
}

enum TemperatureUnit: String, CaseIterable {
    case celsius = "celsius"
    case fahrenheit = "fahrenheit"
    
    var symbol: String {
        switch self {
        case .celsius: return "°C"
        case .fahrenheit: return "°F"
        }
    }
    
    var displayName: String {
        switch self {
        case .celsius: return "Celsius"
        case .fahrenheit: return "Fahrenheit"
        }
    }
}
