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
    @Published var currentTimeLeftInPeriod: Double = 0
    @Published var currentProgressInPeriod: Double = 0
    @Published var passingTime: Double = 0
    @Published var nextPeriod: PeriodModel?
    
    
    enum PeriodError: Error {
        case invalidPeriod
        case noPeriodProvided
        case noEvents
    }
    
    init() {
        updateTime(input: Date())
    }
    
    func updateTime(input: Date) {
        //Add loading feature
        currentTime = input
        checkIfWeekDayChanged()
        setCurrentPeriod()
        endCurrentPeriod()
        updateTimeLeftInPeriod()
        updateProgressInPeriod()
        setPassingTime()
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

            }
        } catch PeriodError.invalidPeriod {
            print("No period found -> Setting period number to nil")
            currentPeriodNumber = nil
        } catch {
            currentPeriodNumber = nil
        }

    }

}
