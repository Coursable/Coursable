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
    
    @Published var usersSubjects: [Subject] = [Subject.LanguageArtsSubjectExample, Subject.MathSubjectExample, Subject.ScienceSubjectExample] //Subject.LanguageArtsSubjectExample, Subject.MathSubjectExample, Subject.ScienceSubjectExample
    @Published var usersPeriods: [PeriodModel] = [PeriodModel.periodOneExample, PeriodModel.periodTwoExample, PeriodModel.periodThreeExample]
    @Published var usersFullSchedule: [DayModel] = [DayModel.ExampleDay1]
    
    
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
        
        for daySchedule in usersFullSchedule {
            if daySchedule.day == Calendar.current.dateComponents([.weekday], from: Date()).weekday {
                todaysSchedule = daySchedule
                break
            }
            else {
                todaysSchedule = nil
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
            withAnimation {
                for period in todaysScheduleCheck.periods {
                    if (period.fullEndTimeParsed.timeIntervalSinceReferenceDate < Date().timeIntervalSinceReferenceDate) {
                        if (!completedClassesToday.contains(where: { $0.id == period.id })) {
                            completedClassesToday.append(period)
                        }
                    }
                    else {
                        if completedClassesToday.contains(where: { $0.id == period.id }) {
                            
                            if let removeIndex =  completedClassesToday.firstIndex(where: { $0.id == period.id }) {
                                completedClassesToday.remove(at: removeIndex)
                            }
                            
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
                    if let currentPeriodNumberValue = currentPeriodNumber {
                        if (period.periodNumber == currentPeriodNumberValue) {
                            return //if the period is the same as the current period number, disregard
                        }
                    }
                    
                    //otherwise switch the period number

                    
                    withAnimation {
                        currentPeriodNumber = period.periodNumber
                    }
                    foundCorrectPeriod = true
                    
                    

                    
                    
                    
                    
                    
                }
            }
            
        }
        
        if !foundCorrectPeriod {
            //withAnimation {
                currentPeriodNumber = nil
            //}
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
    

    
    func setSubjectData() -> Bool {
        var valueToReturn = true
        
        DataHandler().setSubjectData(subjectsToSave: self.usersSubjects) { succeed in
            if succeed != true {
                print("Unable to set subject data to database")
                valueToReturn = false
            }
        }
        
        return valueToReturn
    }
    
    func setIndividualSubjectData(subjectToSave: Subject) -> Bool {
        var valueToReturn = true
        
        DataHandler().setIndividualSubjectData(subjectToSave: subjectToSave) { succeed in
            if succeed != true {
                print("Unable to set individual subject data to database")
                valueToReturn = false
            }
        }
        
        return valueToReturn
    }
    
    
    
    func retrieveSubjectData() async {
        await DataHandler().getSubjectData() { succeed, data in
            DispatchQueue.main.async {
                if succeed == true {
                    withAnimation {
                        self.usersSubjects = data
                    }
                    
                    
                }
                else {
                    print("Unable to write subject data")
                    
                }
            }
        }
    }
    
    func overwriteIndividualSubjectData(subjectToOverwrite: Subject, newSubjectData: Subject) async {
        DataHandler().overwriteIndividualSubjectData(subjectToOverwrite: subjectToOverwrite, newSubjectData: newSubjectData) { success in
            if success {
                Task {
                    await self.retrieveSubjectData()
                }
                
            }
            else {
                print("Unable to remove subject data")
            }
        }
    }
    
    func removeIndividualSubjectData(subjectToRemove: Subject) async {
        DataHandler().removeIndividualSubjectData(subjectToRemove: subjectToRemove) { success in
            if success == true {
                Task {
                    await self.retrieveSubjectData()
                }
            }
            else {
                print("Unable to remove subject data")
            }
        }
    }

}
