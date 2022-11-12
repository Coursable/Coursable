//
//  ClassModel.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/23/22.
//

import Foundation
import SwiftUI


struct PeriodModel: Identifiable {
    var id: String
    var startTime: String
    var endTime: String
    var periodNumber: Int
    var subject: Subject
    
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
    
    
    
    static let periodExample = PeriodModel(id: "1", startTime: "11:40:30", endTime: "12:05:00", periodNumber: 3, subject: Subject.ExampleSubject)
    static let periodExample1 = PeriodModel(id: "1", startTime: "14:00:00", endTime: "14:01:30", periodNumber: 4, subject: Subject.ExampleSubject1)
    static let periodExample2 = PeriodModel(id: "1", startTime: "16:00:00", endTime: "17:05:30", periodNumber: 5, subject: Subject.ExampleSubject2)
    static let periodExample3 = PeriodModel(id: "1", startTime: "17:49:00", endTime: "17:50:30", periodNumber: 6, subject: Subject.ExampleSubject2)
}

struct Subject: Identifiable {
    var id: String
    var name: String
    var teacher: String
    var color: LinearGradient
    var roomNumber: String
    
    static let ExampleSubject = Subject(id: "1", name: "Lunch", teacher: "", color: .bluePink, roomNumber: "1")
    static let ExampleSubject1 = Subject(id: "1", name: "Language Arts", teacher: "Ari", color: .yellowOrange, roomNumber: "2")
    static let ExampleSubject2 = Subject(id: "1", name: "Science", teacher: "Ari", color: .orangePurple, roomNumber: "3")
}


struct DayModel: Identifiable {
    var id: String
    var day: Int
    var periods: [PeriodModel]
    
    static let ExampleDay = DayModel(id: "123", day: 7, periods: [PeriodModel.periodExample])
    static let ExampleDay1 = DayModel(id: "123", day: 4, periods: [PeriodModel.periodExample, PeriodModel.periodExample1, PeriodModel.periodExample2, PeriodModel.periodExample3])
}

struct FullSchedule: Identifiable {
    var id: String
    var allClasses: [DayModel]
    
    static let FullScheduleExample = FullSchedule(id: "1342", allClasses: [DayModel.ExampleDay, DayModel.ExampleDay1])
}

