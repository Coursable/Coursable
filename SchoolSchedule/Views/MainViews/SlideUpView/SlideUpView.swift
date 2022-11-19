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
    
    
    var body: some View {
        
        
        
        SlideUp(startingOffset: UIScreen.main.bounds.height*0.35, endingOffset: UIScreen.main.bounds.height*0.13, backgroundColor: .white, barColor: .secondary) {
            
            
            Form {

                if let todaysSchedule = periodViewModel.todaysSchedule {
                    Section("Progress") {

                        VStack(spacing: 20) {

                            ProgressBarStatsView()
                            
                            StatsCardView()
                        }
                        .listRowInsets(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
                        
                        
                    }
                    Section {
                        //todaysSchedule.periods.filter { period in !periodViewModel.completedClassesToday.contains(where: { period.id == $0.id }) }
                        ForEach(periodViewModel.todaysSchedule!.periods.filter { period in
                            !periodViewModel.completedClassesToday.contains(where: { period.id == $0.id }) } ) { period in
                                ZStack {
                                    NavigationLink(destination: Text("test")) {
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
                        HStack {
                            Text(hideCompletedCourses ? "Courses Remaining Today (\(periodViewModel.numberOfClassesToday - periodViewModel.completedClassesToday.count))" : "Courses Meeting Today (\(periodViewModel.numberOfClassesToday))")
                            Spacer()
                            CourseFilterMenuView(hideCompletedCourses: $hideCompletedCourses)
                            .textCase(nil)
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
