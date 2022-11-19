//
//  PeriodViewModel.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/23/22.
//

import Foundation
import SwiftUI

class PeriodViewModel: ObservableObject {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Published var todaysSchedule: DayModel?
    @Published var currentPeriodNumber: Int?
    @Published var currentTime = Date()
    @Published var currentWeekDay: Int?
    @Published var currentTimeLeftInPeriod: Double = 0
    @Published var currentProgressInPeriod: Double = 0
    @Published var passingTime: Double = 0
    @Published var nextPeriod: PeriodModel?
    @Published var currentRingColor: LinearGradient = .defaultGray
    @Published var completedClassesToday: [PeriodModel] = []
    @Published var numberOfClassesToday: Int = 0
    @Published var currentDayCompletedPercentage: Double = 0.0
    @Published var showRingMoveAnimation: Bool = false
    
    enum PeriodError: Error {
        case invalidPeriod
        case noPeriodProvided
        case noEvents
    }
    
    
    enum ScheduleInfo {
        case NoEventsToday
        case NoMoreEventsToday
        case NextEvent
        case CurrentEvent
    }
    
    
    
    
    init() {
        updateTime(input: Date())
    }
    
    
    
    func updateTime(input: Date) {

        showRingMoveAnimation.toggle()
        currentTime = input
        checkIfWeekDayChanged()
        setCurrentPeriod()
        endCurrentPeriod()
        updateTimeLeftInPeriod()
        updateProgressInPeriod()
        setPassingTime()
        setNumberOfClassesToday()
        setCurrentDayCompletedPercentage()
        setClassesCompletedToday()
        
    }

    
    
    func getScheduleInfo() -> ScheduleInfo {
        if let todaysSchedule = self.todaysSchedule {
            if let currentPeriodNumber = self.currentPeriodNumber {
                
                
                if todaysSchedule.periods.first(where: {$0.periodNumber == currentPeriodNumber}) != nil {
                    return .CurrentEvent  
                }
                else {
                    if self.nextPeriod != nil {
                        return .NextEvent
                    }
                    else {
                        //Day Completed
                        return .NoMoreEventsToday
                    }

                }
            }
            else {
                if self.nextPeriod != nil {
                    return .NextEvent
                }
                else {
                    //Day Completed
                    return .NoMoreEventsToday
                }
            }
        }
        else {
            //Day Completed
            return .NoEventsToday
        }

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
    
    func setNumberOfClassesToday() {
        if let todaysSchedule = todaysSchedule {
            //Set the number of classes today
            numberOfClassesToday = todaysSchedule.periods.count
        }
        else {
            //No classes today
            numberOfClassesToday = 0
        }
    }
    
    func setClassesCompletedToday() { //currently working on
        if let todaysScheduleCheck = todaysSchedule {
            //completedClassesToday = []
            for period in todaysScheduleCheck.periods {
                if (!completedClassesToday.contains(where: { $0.id == period.id })) {
                    if (period.fullEndTimeParsed.timeIntervalSinceReferenceDate < Date().timeIntervalSinceReferenceDate) {
                        withAnimation {
                            completedClassesToday.append(period)
                        }
                            
                        
                        
                        
                        
                        
                    }
                }
                
            }
        }
        else {
            completedClassesToday = []
        }
    }
    
    
    func getCurrentPeriod() throws -> PeriodModel {
        if let todaysScheduleCheck = todaysSchedule {
            if let currentPeriodNumberCheck = self.currentPeriodNumber {
                if let period = todaysScheduleCheck.periods.first(where: {$0.periodNumber == currentPeriodNumberCheck}) {
                    return period
                }
                else {
                    throw PeriodError.invalidPeriod
                }
            }
            else {
                throw PeriodError.noPeriodProvided
            }
        }
        else {
            throw PeriodError.noEvents
        }
    }
    
    func updateTimeLeftInPeriod() {
        
        do {
            let period = try getCurrentPeriod()
            currentTimeLeftInPeriod = period.fullEndTimeParsed.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate
        } catch PeriodError.invalidPeriod {
            print("No period found -> Setting time left to 0")
            currentTimeLeftInPeriod = 0
        } catch {
            currentTimeLeftInPeriod = 0
        }
        

    }
    
    func updateProgressInPeriod() {
        
        do {
            let period = try getCurrentPeriod()
            currentProgressInPeriod = (currentTime.timeIntervalSinceReferenceDate-period.fullStartTimeParsed.timeIntervalSinceReferenceDate)/period.classLength
        } catch PeriodError.invalidPeriod {
            print("No period found -> Setting period progress left to 0")
            currentProgressInPeriod = 0
        } catch {
            currentProgressInPeriod = 0
        }
        

    }
    
    func setCurrentDayCompletedPercentage() {
        currentDayCompletedPercentage = Double(completedClassesToday.count)/Double(numberOfClassesToday)
    }
    
    func setPassingTime() {
        if let todaysScheduleCheck = todaysSchedule {
            if self.currentPeriodNumber == nil {
                //if there is no period running
                nextPeriod = nil //remove any previous values
                
                for period in todaysScheduleCheck.periods {
                    if let nextPeriodCheck = nextPeriod {
                        //compare current period
                        if period.fullStartTimeParsed.timeIntervalSinceReferenceDate < nextPeriodCheck.fullStartTimeParsed.timeIntervalSinceReferenceDate && period.fullStartTimeParsed.timeIntervalSinceReferenceDate > Date().timeIntervalSinceReferenceDate{
                            nextPeriod = period
                        }
                    }
                    else {
                        if period.fullStartTimeParsed.timeIntervalSinceReferenceDate > Date().timeIntervalSinceReferenceDate {
                            nextPeriod = period
                        }
                    }
                }
                
                
                if let nextPeriodCheck = nextPeriod {
                    if (nextPeriodCheck.fullStartTimeParsed.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate) > 0 {
                        passingTime = nextPeriodCheck.fullStartTimeParsed.timeIntervalSinceReferenceDate - Date().timeIntervalSinceReferenceDate
                    }
                    else {
                        nextPeriod = nil
                        passingTime = 0

                    }
                    
                }

            }
            else {
                //if there is a period running
                nextPeriod = nil
                passingTime = 0
            }
        }
        else {
            nextPeriod = nil
            passingTime = 0
        }
    }
    
    func setCurrentPeriod() {
        var foundCorrectPeriod: Bool = false
        
        if let todaysScheduleCheck = todaysSchedule {
            for period in todaysScheduleCheck.periods {
                if period.fullEndTimeParsed.timeIntervalSinceReferenceDate > Date().timeIntervalSinceReferenceDate && Date().timeIntervalSinceReferenceDate >  period.fullStartTimeParsed.timeIntervalSinceReferenceDate {
                    currentPeriodNumber = period.periodNumber
                    currentRingColor = period.subject.color
                    foundCorrectPeriod = true
                }
            }
            
        }
        
        if !foundCorrectPeriod {
            currentPeriodNumber = nil
        }
    }
    
    func endCurrentPeriod() {
        do {
            let period = try getCurrentPeriod()
            if period.fullEndTimeParsed.timeIntervalSinceReferenceDate < Date().timeIntervalSinceReferenceDate {
                print("Period Ended")
                currentPeriodNumber = nil
                currentRingColor = .defaultGray

            }
        } catch PeriodError.invalidPeriod {
            print("No period found -> Setting period number to nil")
            currentPeriodNumber = nil
            currentRingColor = .defaultGray
        } catch {
            currentPeriodNumber = nil
            currentRingColor = .defaultGray
        }

    }

}
