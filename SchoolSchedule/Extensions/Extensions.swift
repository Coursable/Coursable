//
//  Extensions.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/23/22.
//

import Foundation


extension DateFormatter {
    static let dateFormatFullLength: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter
    }()
    
    static let dateFormatTimeLength: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "HH:mm:ss"
        
        return formatter
    }()
    
    static let dateFormatYearLength: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
    }()

}

extension Double {
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
    formatter.unitsStyle = style
    return formatter.string(from: self) ?? ""
  }
}




extension String {
    func parseTimeStringToDate() -> Date {
        guard let parsedDate = DateFormatter.dateFormatTimeLength.date(from: self) else { return Date() }
                
        return parsedDate
    }
    
    func parseFullLengthStringToDate(string: String) -> Date {
        guard let parsedDate = DateFormatter.dateFormatFullLength.date(from: string) else { return Date() }
                
        return parsedDate
    }
    
    
}

extension TimeInterval {
    var hour: Int {
        Int((self/3600).truncatingRemainder(dividingBy: 3600))
    }
    var minute: Int {
        Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}
