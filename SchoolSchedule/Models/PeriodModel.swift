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
    var meetingDay: Int
    
    var startTimeParsed: Date {
        startTime.parseTimeStringToDate()
    }
    
    var endTimeParsed: Date {
        endTime.parseTimeStringToDate()
    }
    
    var classLength: Double {
        endTimeParsed.timeIntervalSinceReferenceDate - startTimeParsed.timeIntervalSinceReferenceDate
    }
    
    
    static let dayModelExample = [periodExample]
    
    static let periodExample = PeriodModel(id: "1", startTime: "20:00:00", endTime: "21:00:00", periodNumber: 3, meetingDay: 4)
}

