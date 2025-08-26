//  Animation.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

import Foundation
import SwiftUI

extension Animation {
    static let smoothSpring = Animation.spring(response: 0.5, dampingFraction: 0.8)
    static let quickSpring = Animation.spring(response: 0.3, dampingFraction: 0.7)
    static let gentleEase = Animation.easeInOut(duration: 0.4)
}
