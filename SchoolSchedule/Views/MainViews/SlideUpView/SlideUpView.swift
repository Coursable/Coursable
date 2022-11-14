//
//  SlideUpView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/11/22.
//

import SwiftUI

struct SlideUpView: View {
    
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    @State var progressValue: Float = 0.2
   
    
    var body: some View {
        
        
        
        SlideUp(startingOffset: UIScreen.main.bounds.height*0.37, endingOffset: UIScreen.main.bounds.height*0.13, backgroundColor: .white, barColor: .secondary) {
            
            
            Form {
                if let todaysSchedule = periodViewModel.todaysSchedule {
                    Section("Stats") {

                        VStack(spacing: 12) {
                            DayProgressBarView(value: $progressValue).frame(height: 20)
                            
                            HStack {
                                CompletedCoursesCardView()
                                    .padding()
                                    .modifier(StatsCardView())
                                CompletedCoursesCardView()
                                    .padding()
                                    .modifier(StatsCardView())
                            }
                            CompletedCoursesCardView()
                                .padding()
                                .modifier(StatsCardView())
                        }
                        
                        
                    }
                    
                    
                    Section("Courses") {
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
