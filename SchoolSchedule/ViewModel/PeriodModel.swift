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
    
    static let periodExample = PeriodModel(id: "1", startTime: "20:00", endTime: "21:00", periodNumber: 3)
}

