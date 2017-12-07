//
//  Utility
//  PersonalAssistant
//
//  Created by Nisha Raghu on 11/25/17.
//  Copyright © 2017 TheUltimates.com. All rights reserved.
//

import Foundation

class Utility {

    static let numberOfDays = 10
    class func getString(fromDate date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let dateString = dateFormatter.string(from:date)
        return dateString
    }
    
    class func getMidnightDateTime(date: Date) -> Date {
        let cal = NSCalendar.current
        var comps = cal.dateComponents(in: TimeZone.current, from: date)
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        return cal.date(from: comps)!
    }
    
    class func getFormattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E  MMM dd, YYYY"
        let dateString = dateFormatter.string(from:date)
        return dateString
    }
}
