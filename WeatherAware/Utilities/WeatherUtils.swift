//  WeatherUtils.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

import Foundation
import SwiftUI

struct WeatherUtils {
    static func uvIndexDescription(_ uvIndex: Double) -> String {
        switch uvIndex {
        case 0..<3:
            return "Low"
        case 3..<6:
            return "Moderate"
        case 6..<8:
            return "High"
        case 8..<11:
            return "Very High"
        default:
            return "Extreme"
        }
    }
    
    static func uvIndexColor(_ uvIndex: Double) -> Color {
            switch uvIndex {
            case 0..<3:
                return .green
            case 3..<6:
                return .yellow
            case 6..<8:
                return .orange
            case 8..<11:
                return .red
            default:
                return .purple
            }
        }
        
        static func windSpeedDescription(_ speed: Double) -> String {
            switch speed {
            case 0..<1:
                return "Calm"
            case 1..<4:
                return "Light breeze"
            case 4..<8:
                return "Moderate breeze"
            case 8..<12:
                return "Fresh breeze"
            case 12..<17:
                return "Strong breeze"
            case 17..<25:
                return "Gale"
            default:
                return "Storm"
            }
        }
        
        static func humidityDescription(_ humidity: Int) -> String {
            switch humidity {
            case 0..<30:
                return "Dry"
            case 30..<60:
                return "Comfortable"
            case 60..<80:
                return "Humid"
            default:
                return "Very humid"
            }
        }
        
        static func precipitationDescription(_ pop: Double) -> String {
            switch pop {
            case 0..<0.1:
                return "No rain expected"
            case 0.1..<0.3:
                return "Light chance of rain"
            case 0.3..<0.6:
                return "Moderate chance of rain"
            case 0.6..<0.8:
                return "High chance of rain"
            default:
                return "Rain very likely"
            }
        }
    }
