//
//  SlideUpView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/11/22.
//

import SwiftUI

struct SlideUpView: View {
    
    @EnvironmentObject var periodViewModel: PeriodViewModel
    @State var hideCompletedCourses: Bool = true
    
    var filteredCourses: [PeriodModel] {
        if let todaysSchedule = periodViewModel.todaysSchedule {

            return todaysSchedule.periods.filter { period in
                (!hideCompletedCourses || !periodViewModel.completedClassesToday.contains(where: { period.id == $0.id }))
            }
        }
        return [] // no schedule
    }
    
    var isTodaysScheduleValid: Bool {
        if periodViewModel.todaysSchedule != nil {
            return true
        }
        else {
            return false
        }
    }
    
    
    var body: some View {
        
        
        
        SlideUp(startingOffset: UIScreen.main.bounds.height*0.35, endingOffset: UIScreen.main.bounds.height*0.16, backgroundColor: .white, barColor: .secondary) {

            Form {
                Section("Progress") {

                    VStack(spacing: 20) {
                        //if isTodaysScheduleValid {
                            ProgressBarStatsView()
                        //}
                        
                        
                        StatsCardView()
                    }
                    .listRowInsets(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
                    
                    
                }
                Section {
                    ForEach(filteredCourses.sorted { $0.startTimeParsed.timeIntervalSinceReferenceDate < $1.startTimeParsed.timeIntervalSinceReferenceDate || $0.periodNumber < $1.periodNumber}) { period in
                            ZStack {
                                NavigationLink(destination: DestinationView(periodModel: period)) {
                                    Rectangle().opacity(0.0)
                                }
                                .padding(.trailing, 20)
                                CourseCardView(period: period)
                            }
                            .transition(AnyTransition.scale)
                            .listStyle(InsetGroupedListStyle())
                            .listRowBackground(Color(UIColor.clear))
                            .listRowInsets(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
                            .buttonStyle(PlainButtonStyle())
                            .padding(.bottom, 10)
                            .listRowSeparator(.hidden)
                    }
                } header: {
                    FilterTopBarSectionView(hideCompletedCourses: $hideCompletedCourses)

                }

            }
            .scrollContentBackground(.hidden)
            .background(.white)
        }
    }
    

}

struct SlideUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ZStack {
                MainPage_FirstLayerView()
                    .environmentObject(PeriodViewModel())
                SlideUpView()
                    //.background(.secondary)
                
                    .environmentObject(PeriodViewModel())
            }
            
        }
    }
}
