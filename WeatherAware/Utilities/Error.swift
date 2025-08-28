//  Error.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

/*
This file contains an extension to the Swift Error protocol to provide
user-friendly error messages. It is primarily used to display readable
error messages in the UI instead of raw system errors.
*/

import Foundation

extension Error {
    // Provides a user-friendly message for any Error.
    /// - Returns: A readable string describing the error.
    /// If the error is a WeatherError, returns its localized description.
    /// Otherwise, returns a generic fallback message.
    var friendlyMessage: String {
        if let weatherError = self as? WeatherError {
            return weatherError.localizedDescription
        } else {
            return "Something went wrong. Please try again."
        }
    }
}
