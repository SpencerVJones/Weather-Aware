//
//  UIDevice.swift
//  WeatherAware
//
//  Created by Spencer Jones on 8/22/25.
//

import Foundation
import SwiftUI

extension UIDevice {
    var isPhone: Bool {
        userInterfaceIdiom == .phone
    }
    
    var isPad: Bool {
        userInterfaceIdiom == .pad
    }
}
