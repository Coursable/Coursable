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
