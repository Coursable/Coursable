//
//  ClassModel.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/23/22.
//

import Foundation


struct PeriodModel: Identifiable {
    var id: String
    var startTime: String
    var endTime: String
    var periodNumber: Int
    
    var startTimeParsed: Date {
        startTime.parseTimeStringToDate()
    }
    
    var endTimeParsed: Date {
        endTime.parseTimeStringToDate()
    }
    
    var fullStartTimeParsed: Date {
        startTime.parseFullLengthStringToDate(string: "\(DateFormatter.dateFormatYearLength.string(from: Date())) \(startTime)")
    }
    
    var fullEndTimeParsed: Date {
        startTime.parseFullLengthStringToDate(string: "\(DateFormatter.dateFormatYearLength.string(from: Date())) \(endTime)")
    }
    
    var classLength: Double {
        endTimeParsed.timeIntervalSinceReferenceDate - startTimeParsed.timeIntervalSinceReferenceDate
    }
    
    
    
    static let periodExample = PeriodModel(id: "1", startTime: "12:17:30", endTime: "12:19:00", periodNumber: 3)
    static let periodExample1 = PeriodModel(id: "1", startTime: "12:20:00", endTime: "12:20:30", periodNumber: 4)
}


struct DayModel: Identifiable {
    var id: String
    var day: Int
    var periods: [PeriodModel]
    
    static let ExampleDay = DayModel(id: "123", day: 6, periods: [PeriodModel.periodExample])
    static let ExampleDay1 = DayModel(id: "123", day: 7, periods: [PeriodModel.periodExample, PeriodModel.periodExample1])
}

struct FullSchedule: Identifiable {
    var id: String
    var allClasses: [DayModel]
    
    static let FullScheduleExample = FullSchedule(id: "1342", allClasses: [DayModel.ExampleDay, DayModel.ExampleDay1])
}

