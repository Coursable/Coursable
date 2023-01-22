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

struct Subject: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var teacher: String
    var colorGradientPrimary: [Double]
    var colorGradientSecondary: [Double]
    var roomNumber: String
    
    static let MathSubjectExample = Subject(id: "1", name: "Math", teacher: "Ari Reitman", colorGradientPrimary: Subject.Blue, colorGradientSecondary: Subject.Pink, roomNumber: "1")
    static let LanguageArtsSubjectExample = Subject(id: "2", name: "Language Arts", teacher: "John Reed", colorGradientPrimary: Subject.Yellow, colorGradientSecondary: Subject.Orange, roomNumber: "2")
    static let ScienceSubjectExample = Subject(id: "3", name: "Science", teacher: "Steve Jobs", colorGradientPrimary: Subject.Orange, colorGradientSecondary: Subject.Pink, roomNumber: "3")
    
    static let Blue = [23.0, 120.0, 248.0]
    static let Pink = [250.0, 55.0, 86.0]
    static let Yellow = [254.0, 209.0, 58.0]
    static let Orange = [252.0, 150.0, 46.0]
    static let Purple = [180.0, 82.0, 832.0]
}

//struct RGBModel: Identifiable, Codable {
//    var id = UUID()
//    var colorR, colorG, colorB: Double
//
//    static let Blue = RGBModel(colorR: 23, colorG: 120, colorB: 248)
//    static let Pink = RGBModel(colorR: 250, colorG: 55, colorB: 86)
//    static let Yellow = RGBModel(colorR: 254, colorG: 209, colorB: 58)
//    static let Orange = RGBModel(colorR: 252, colorG: 150, colorB: 46)
//    static let Purple = RGBModel(colorR: 180, colorG: 82, colorB: 832)
//}


struct DayModel: Identifiable {
    var id: String
    var day: Int
    var periods: [PeriodModel]
    
    static let ExampleDay1 = DayModel(id: "1", day: 2, periods: [PeriodModel.periodOneExample, PeriodModel.periodTwoExample, PeriodModel.periodThreeExample])
    
    
    /*
     day 1=Sunday
     day 2=Monday
     day 3=Tuesday
     day 4=Wednesday
     day 5=Thursday
     day 6=Friday
     day 7=Saturday
    */
    
    static let dayColors: [Color] = [.red, .blue, .green, .pink, .yellow, .orange, .teal]
    
}

struct FullSchedule: Identifiable{
    var id: String
    var allClasses: [DayModel]
    
    static let FullScheduleExample = FullSchedule(id: "1", allClasses: [DayModel.ExampleDay1])
}

