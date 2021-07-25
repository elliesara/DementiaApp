//
//  DateHelper.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 9/11/20.
//  Copyright © 2020 Neuroscience Amador Valley. All rights reserved.
//

import Foundation

/*
 DateFormatter() has 5 format style options for each of Date and Time. These are:
 .none .short .medium .long .full
 
 https://www.datetimeformatter.com/how-to-format-date-time-in-swift/
 
 DATE      TIME     DATE/TIME STRING
 "none"    "none"
 "none"    "short"   9:42 AM
 "none"    "medium"  9:42:27 AM
 "none"    "long"    9:42:27 AM EDT
 "none"    "full"    9:42:27 AM Eastern Daylight Time
 "short"   "none"    10/10/17
 "short"   "short"   10/10/17, 9:42 AM
 "short"   "medium"  10/10/17, 9:42:27 AM
 "short"   "long"    10/10/17, 9:42:27 AM EDT
 "short"   "full"    10/10/17, 9:42:27 AM Eastern Daylight Time
 "medium"  "none"    Oct 10, 2017
 "medium"  "short"   Oct 10, 2017, 9:42 AM
 "medium"  "medium"  Oct 10, 2017, 9:42:27 AM
 "medium"  "long"    Oct 10, 2017, 9:42:27 AM EDT
 "medium"  "full"    Oct 10, 2017, 9:42:27 AM Eastern Daylight Time
 "long"    "none"    October 10, 2017
 "long"    "short"   October 10, 2017 at 9:42 AM
 "long"    "medium"  October 10, 2017 at 9:42:27 AM
 "long"    "long"    October 10, 2017 at 9:42:27 AM EDT
 "long"    "full"    October 10, 2017 at 9:42:27 AM Eastern Daylight Time
 "full"    "none"    Tuesday, October 10, 2017
 "full"    "short"   Tuesday, October 10, 2017 at 9:42 AM
 "full"    "medium"  Tuesday, October 10, 2017 at 9:42:27 AM
 "full"    "long"    Tuesday, October 10, 2017 at 9:42:27 AM EDT
 "full"    "full"    Tuesday, October 10, 2017 at 9:42:27 AM Eastern Daylight Time
 */

/// Custom Date Formatter Styles
extension Date {
    
    /// MMMMyyyy = August 2020
    var MMMMyyyy: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }
    
    /// MMMd = Aug 15
    var MMMd: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: self)
    }
    
    /// short = 10/10/17
    var short: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
    
    /// shortMedium = 10/10/17, 9:42 AM
    var shortMedium: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter.string(from: self)
    }
    
    /// MMMd = Aug 15
    var dayOfWeek: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: self)
    }
}



///  Usage:
///      print(Weekday.allValues[index].rawValue)
///      ForEach(0 ..< Weekday.allCases.count)
enum Weekday : String, CaseIterable {
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    
    static let allValues = [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]
}

///  Usage:
///      print(DateType.allValues[index].rawValue)
///      ForEach(0 ..< DateType.allCases.count)
enum DateType : String, CaseIterable {
    case Day
    case Week
    case Month
    case Year
    
    static let allValues = [Day, Week, Month, Year]
}



extension Date {
    
    /// Get an offset for adjacent dates used for Day, Week and Month
    enum Offset: Int {
        case none = 0
        case forward = 1
        case backward = -1
    }
    
    /// Returns an integer from 1 - 7, with 1 being Sunday and 7 being Saturday
    /// usage: Date().weekDayNumber()   // 4
    var weekdayNumber : Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    /// Start of day local time
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    /// Start of adjacent day local time
    func startOfAdjacentDay(offset: Offset) -> Date {
        var components = DateComponents()
        components.weekday = offset.rawValue
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    /// End of day local time
    var endOfDay: Date {
        var components = DateComponents()
        components.weekday = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    /// End of day local time
    func endOfAdjacentDay(offset: Offset) -> Date {
        var components = DateComponents()
        components.weekday = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfAdjacentDay(offset: offset))!
    }
    
    /// Start of week local time — begins on Sunday
    var startOfWeek: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return calendar.date(from: components)!
    }
    
    /// End of week local time — is on Saturday
    var endOfWeek: Date {
        var components = DateComponents()
        components.weekday = 7
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfWeek)!
    }
    
    /// Start of month local time
    var startOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
    
    /// End of month local time
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
}
