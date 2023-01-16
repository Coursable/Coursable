//
//  SettingsView.swift
//  Coursable
//
//  Created by Ari Reitman on 11/28/22.
//

import SwiftUI
import FirebaseFirestore

struct SettingsView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    @EnvironmentObject var signInViewModel: SignInViewModel
    @Binding var showSettingsSheet: Bool
    @State var isLoading: Bool = false
    @State var showAddSubjectSheet: Bool = false
    @State var showScheduleInfoSheet: Bool = false
    @State var isEditingSubjects: Bool = false
    
    @State var subjectToEdit: Subject?
    @State var subjectFolded: Bool = true
    
    @State var weekdaySelected: Int = 4
    @Namespace var animation
    
    
    var body: some View {
        ZStack {
            VStack {
                
                ZStack {
                    HStack {
                        Spacer()
                        Text("Settings")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                }
                .overlay(
                    Button {
                        showSettingsSheet.toggle()
                    } label: {
                        Image(systemName: "chevron.down")
                            .font(.title2)
                    }
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(.top, 5)
                        .padding(.trailing, 30)
                    
                    ,alignment: .topTrailing
                )
                .padding(.bottom,8)
                .padding(.top,8)
                
                Form {
                    
                    SettingsSubjectListView(subjectFolded: $subjectFolded, showAddSubjectSheet: $showAddSubjectSheet, subjectToEdit: $subjectToEdit, isEditingSubjects: $isEditingSubjects)
                    
                    Section {
                        
                        HStack(spacing: 1) {
                            Spacer()
                            ForEach(1...5, id: \.self) {day in
                                Button {
                                    withAnimation {
                                        weekdaySelected = day
                                    }
                                } label: {
                                    VStack {
                                        switch(day) {
                                        case 1: 
                                            Text("Mon")
                                        case 2:
                                            Text("Tue")
                                        case 3:
                                            Text("Wed")
                                        case 4:
                                            Text("Thu")
                                        default:
                                            Text("Fri")
                                        }
                                        
                                        if weekdaySelected == day {
                                            Circle()
                                                .frame(width: 8)
                                        }
                                    }
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .frame(width: 50, height: weekdaySelected == day ? 90 : 50)
                                    .background(
                                        ZStack {
                                            Capsule()
                                                .fill( weekdaySelected == day ? Color.accentColor : Color("SecondaryBackground"))
                                        }
                                    )
                                    
                                }
                                Spacer()
                            }
                            
                            
                            
                            
                        }
                        
                        if let dayModel = periodViewModel.usersFullSchedule.first { $0.day == weekdaySelected } {
                            ForEach(dayModel.periods) { period in
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    HStack {
                                        SettingsScheduleInfoIconView(period: period)
                                        
                                        VStack(alignment: .leading) {
                                            Text("Period \(period.periodNumber)")
                                                .font(.title3)
                                                .fontWeight(.semibold)
                                            HStack {
                                                //Image(systemName: "book")
                                                Text("\(period.subject.name) - \(DateFormatter.localizedString(from: period.startTimeParsed, dateStyle: .none, timeStyle: .short))-\(DateFormatter.localizedString(from: period.endTimeParsed, dateStyle: .none, timeStyle: .short))")
                                                Spacer()
                                            }
                                            .font(.subheadline)
                                            .fontWeight(.regular)
                                        }
                                        .padding(.leading, 3)
                                        
                                    }
                                }
                                
                                
                                
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("SecondaryBackground"))
                            .cornerRadius(15)
                        }
                    
                    
                    
                    
                    
                }
            header: {
                Text("Schedule")
                    .foregroundColor(.white)
            }
            .listStyle(InsetGroupedListStyle())
            .listRowBackground(Color(UIColor.clear))
            .listRowInsets(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, 10)
            .listRowSeparator(.hidden)
                
                
                Section {
                    Button {
                        signInViewModel.signOut()
                    } label: {
                        Text("Sign Out")
                    }
                    .listRowBackground(Color("SecondaryBackground"))
                    
                    
                }
                
            }
            
            .scrollContentBackground(.hidden)
            
            
            Spacer()
        }
        
        
        if isLoading {
            CustomLoading()
        }
        
        
    }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color("Background")
                .ignoresSafeArea()
        }
        .sheet(isPresented: $showAddSubjectSheet, content: {
            
            AddSubjectView(showAddSubjectSheet: $showAddSubjectSheet, subjectToEdit: $subjectToEdit)
        })
        .sheet(isPresented: $showScheduleInfoSheet, content: {
            //SettingsScheduleInfoView(dayModel: )
        })
        .onAppear {
            
            Task {
                withAnimation {
                    isLoading = true
                }
                
                await periodViewModel.retrieveSubjectData()
                
                //periodViewModel.setSubjectData()
                
                
                withAnimation {
                    isLoading = false
                }
            }
            
        }
    
}

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettingsSheet: .constant(false))
            .environmentObject(PeriodViewModel())
            .environmentObject(SignInViewModel())
    }
}


private struct SettingsScheduleInfoIconView: View {
    
    var period: PeriodModel
    
    var body: some View {
        Circle()
            .fill(LinearGradient(colors: [Color(red: period.subject.colorGradientPrimary[0]/255, green: period.subject.colorGradientPrimary[1]/255, blue: period.subject.colorGradientPrimary[2]/255), Color(red: period.subject.colorGradientSecondary[0]/255, green: period.subject.colorGradientSecondary[1]/255, blue: period.subject.colorGradientSecondary[2]/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 50)
            .overlay {
                Text(String(period.periodNumber))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
            }
    }
}
