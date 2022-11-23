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
    
    
    
    static let periodOneExample = PeriodModel(id: "1", startTime: "12:15:00", endTime: "12:17:00", periodNumber: 3, subject: Subject.MathSubjectExample)
    static let periodTwoExample = PeriodModel(id: "2", startTime: "18:36:00", endTime: "18:36:30", periodNumber: 4, subject: Subject.LanguageArtsSubjectExample)
    static let periodThreeExample = PeriodModel(id: "3", startTime: "22:03:00", endTime: "22:03:30", periodNumber: 5, subject: Subject.ScienceSubjectExample)
}

struct Subject: Identifiable {
    var id: String
    var name: String
    var teacher: String
    var color: LinearGradient
    var roomNumber: String
    
    static let MathSubjectExample = Subject(id: "1", name: "Math", teacher: "Ari Reitman", color: .bluePink, roomNumber: "1")
    static let LanguageArtsSubjectExample = Subject(id: "2", name: "Language Arts", teacher: "John Reed", color: .yellowOrange, roomNumber: "2")
    static let ScienceSubjectExample = Subject(id: "3", name: "Science", teacher: "Steve Jobs", color: .orangePurple, roomNumber: "3")
}


struct DayModel: Identifiable {
    var id: String
    var day: Int
    var periods: [PeriodModel]
    
    static let ExampleDay1 = DayModel(id: "1", day: 4, periods: [PeriodModel.periodOneExample, PeriodModel.periodTwoExample, PeriodModel.periodThreeExample])
    /*
     day 1=Sunday
     day 2=Monday
     day 3=Tuesday
     day 4=Wednesday
     day 5=Thursday
     day 6=Friday
     day 7=Saturday
    */
    
}

struct FullSchedule: Identifiable {
    var id: String
    var allClasses: [DayModel]
    
    static let FullScheduleExample = FullSchedule(id: "1", allClasses: [DayModel.ExampleDay1])
}

