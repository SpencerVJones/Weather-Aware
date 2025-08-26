//  DateExtensions.swift
//  WeatherAware
//  Created by Spencer Jones on 8/22/25

import Foundation

extension Date {
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    var dayOfWeek: String {
        return DateFormatters.dayFormatter.string(from: self)
    }
    
    var shortDate: String {
        return DateFormatters.shortDateFormatter.string(from: self)
    }
    
    func addingDays(_ days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }
}
