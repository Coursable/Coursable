//
//  SlideUpView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/11/22.
//

import SwiftUI

struct SlideUpView: View {
    
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
   
    
    var body: some View {
        
        
        
        SlideUp(startingOffset: UIScreen.main.bounds.height*0.35, endingOffset: UIScreen.main.bounds.height*0.13, backgroundColor: .white, barColor: .secondary) {
            
            
            Form {
                if let todaysSchedule = periodViewModel.todaysSchedule {
                    Section("Progress") {

                        VStack(spacing: 20) {
                            
                            
                            
                            VStack(alignment: .leading) {
                                DayProgressBarView(value: Float(periodViewModel.currentDayCompletedPercentage)).frame(height: 20)
                                Text(String(format: "%g", floor(periodViewModel.currentDayCompletedPercentage*100)) + "% Done With The Day")
                                    .fontWeight(.bold)
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                                    
                            }
                            
                            
                            HStack {
                                CompletedCoursesCardView(numberOfCoursesCompleted: periodViewModel.completedClassesToday.count)
                                    .padding()
                                    .modifier(StatsCardModifierView())
                                RemainingCoursesCardView(remainingCourses: periodViewModel.numberOfClassesToday - periodViewModel.completedClassesToday.count)
                                    .padding()
                                    .modifier(StatsCardModifierView())
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
                        
                        
                    }
                    
                    
                    
                    Section("Courses Meeting Today (\(periodViewModel.numberOfClassesToday))") {
                        ForEach(todaysSchedule.periods.sorted { $0.periodNumber < $1.periodNumber}) { period in
                            ZStack {
                                NavigationLink(destination: Text("test")) {
                                    Rectangle().opacity(0.0)
                                }
                                .padding(.trailing, 20)
                                CourseCardView(period: period)
                            }
                            .listStyle(InsetGroupedListStyle())
                            .listRowBackground(Color(UIColor.clear))
                            .listRowInsets(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
                            .buttonStyle(PlainButtonStyle())
                            .padding(.bottom, 10)
                            .listRowSeparator(.hidden)
                        }
                    }
                    

                }
                else {
                    Text("No Periods Today")

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
            SlideUpView()
                .background(.secondary)
                .environmentObject(PeriodViewModel())
        }
    }
}
