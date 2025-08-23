//
//  Error.swift
//  WeatherAware
//
//  Created by Spencer Jones on 8/22/25.
//

import Foundation

extension Error {
    var friendlyMessage: String {
        if let weatherError = self as? WeatherError {
            return weatherError.localizedDescription
        } else {
            return "Something went wrong. Please try again."
        }
    }
}
