//
//  PeriodViewModel.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/23/22.
//

import Foundation


class PeriodViewModel: ObservableObject {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Published var todaysSchedule: DayModel?
    @Published var currentPeriodNumber: Int?
    @Published var currentTime = Date()
    @Published var currentWeekDay: Int?
    
    init() {
        setTodaysSchedule()
        setCurrentPeriod()
    }
    
    func updateTime(input: Date) {
        currentTime = input
        checkIfWeekDayChanged()
        setCurrentPeriod()
        endCurrentPeriod()
    }
    
    func setTodaysSchedule() {
        currentWeekDay = Calendar.current.dateComponents([.weekday], from: Date()).weekday
        
        for daySchedule in FullSchedule.FullScheduleExample.allClasses {
            if daySchedule.day == Calendar.current.dateComponents([.weekday], from: Date()).weekday {
                todaysSchedule = daySchedule
                print("Found correct schedule day")
                break
            }
            else {
                todaysSchedule = nil
                print("Not correct schedule day")
            }
        }

    }
    
    func checkIfWeekDayChanged() {
        if let currentWeekDayCheck = currentWeekDay {
            if currentWeekDayCheck != Calendar.current.dateComponents([.weekday], from: Date()).weekday {
                print("Current weekday updated")
                setTodaysSchedule()
            }
        }
        else {
            print("Current weekday returned nil -> Updated weekday")
            setTodaysSchedule()
        }
    }
    
    func setCurrentPeriod() {
        if let todaysScheduleCheck = todaysSchedule {
            for period in todaysScheduleCheck.periods {
                if period.fullEndTimeParsed.timeIntervalSinceReferenceDate > Date().timeIntervalSinceReferenceDate && Date().timeIntervalSinceReferenceDate >  period.fullStartTimeParsed.timeIntervalSinceReferenceDate {
                    currentPeriodNumber = period.periodNumber
                }
            }
        }
    }
    
    func endCurrentPeriod() {
        if let todaysScheduleCheck = todaysSchedule {
            if let currentPeriodNumberCheck = self.currentPeriodNumber {
                if let period = todaysScheduleCheck.periods.first(where: {$0.periodNumber == currentPeriodNumberCheck}) {
                    if period.fullEndTimeParsed.timeIntervalSinceReferenceDate < Date().timeIntervalSinceReferenceDate {
                        currentPeriodNumber = nil
                        print("Period Ended")
                    }
                }
                else {
                    print("Did not find period in schedule")
                    currentPeriodNumber = nil
                }
            }
        }
    }

}
