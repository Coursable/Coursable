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
    
    
    
    static let periodExample = PeriodModel(id: "1", startTime: "12:17:30", endTime: "12:19:00", periodNumber: 3, subject: Subject.ExampleSubject)
    static let periodExample1 = PeriodModel(id: "1", startTime: "12:20:00", endTime: "12:20:30", periodNumber: 4, subject: Subject.ExampleSubject1)
    static let periodExample2 = PeriodModel(id: "1", startTime: "12:21:00", endTime: "12:21:30", periodNumber: 5, subject: Subject.ExampleSubject2)
}

struct Subject: Identifiable {
    var id: String
    var name: String
    var teacher: String
    var color: LinearGradient
    
    static let ExampleSubject = Subject(id: "1", name: "Math", teacher: "Ari", color: .bluePink)
    static let ExampleSubject1 = Subject(id: "1", name: "Language Arts", teacher: "Ari", color: .yellowOrange)
    static let ExampleSubject2 = Subject(id: "1", name: "Science", teacher: "Ari", color: .orangePurple)
}


struct DayModel: Identifiable {
    var id: String
    var day: Int
    var periods: [PeriodModel]
    
    static let ExampleDay = DayModel(id: "123", day: 7, periods: [PeriodModel.periodExample])
    static let ExampleDay1 = DayModel(id: "123", day: 2, periods: [PeriodModel.periodExample, PeriodModel.periodExample1, PeriodModel.periodExample2])
}

struct FullSchedule: Identifiable {
    var id: String
    var allClasses: [DayModel]
    
    static let FullScheduleExample = FullSchedule(id: "1342", allClasses: [DayModel.ExampleDay, DayModel.ExampleDay1])
}

