//
//  StringExtensions.swift
//  WeatherAware
//
//  Created by Spencer Jones on 8/22/25.
//

import Foundation

extension String {
    var capitalizedFirst: String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func truncated(to length: Int) -> String {
        if count <= length {
            return self
        }
        return String(prefix(length)) + "..."
    }
}
