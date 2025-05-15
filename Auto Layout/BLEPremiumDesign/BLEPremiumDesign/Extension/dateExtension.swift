//
//  UIViews.swift
//  BLEScanner
//
//  Created by Bluepixel.
//  Copyright © 2024 Bluepixel. All rights reserved.
//

import Foundation
import UIKit

public extension Date  {
    
    func add(_ unit: Calendar.Component = .day, value: Int) -> Date? {
        return Calendar.current.date(byAdding: unit, value: value, to: self)
    }
    
    var startOfTimeDay : Date {
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        let components = calendar.dateComponents(unitFlags, from: self)
        return calendar.date(from: components)!
    }
    
    func startDayOfThisMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endDayOfThisMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startDayOfThisMonth())!
    }
    
    func toStringtimezon(format: String , timeZone : TimeZone) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        df.timeZone = timeZone
        
        return df.string(from: self)
    }
    
    func toStringWithOffset(format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    
    //    func convertToLocaleDate(template: String) -> String {
    //
    //        let dateFormatter = DateFormatter()
    //
    //        let calender = Calendar.current
    //
    //        dateFormatter.timeZone = calender.timeZone
    //        dateFormatter.locale = calender.locale
    //        dateFormatter.dateFormat = template
    //
    //        return dateFormatter.string(from: self)
    //    }
    //
    //    func convertToLocaleDate(template: String) -> Date {
    //
    //        let dateFormatter = DateFormatter()
    //
    //        let calender = Calendar.current
    //
    //        dateFormatter.timeZone = calender.timeZone
    //        dateFormatter.locale = calender.locale
    //        dateFormatter.dateFormat = template
    //
    //        return dateFormatter.date(from: self.toString(format: template))!
    //    }
    //
    //    func convertDateToDate(dateformat: String) -> Date {
    //
    //            let dateFormatter = DateFormatter()
    //            dateFormatter.dateFormat = dateformat
    //            dateFormatter.timeZone = .current
    //            let convertDate = dateFormatter.string(from: self)
    //            return dateFormatter.date(from: convertDate)!
    //        }
    
}

extension Formatter {
    static let customDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
        return formatter
    }()
}
