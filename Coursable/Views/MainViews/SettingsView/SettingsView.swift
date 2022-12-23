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
    @Binding var showSheet: Bool
    @State var isLoading: Bool = false
    @State var showAddSubjectSheet: Bool = false
    @State var isEdittingSubjects: Bool = false
    @State var subjectToEdit: Subject?
    @State var subjectFolded: Bool = true
    
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
                        showSheet.toggle()
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
                    
                    SettingsSubjectListView(subjectFolded: $subjectFolded, showAddSubjectSheet: $showAddSubjectSheet, subjectToEdit: $subjectToEdit, isEdittingSubjects: $isEdittingSubjects)
                    
                    Section {
                        
                        ForEach(Array(periodViewModel.usersFullSchedule.enumerated()), id: \.offset) { index, day in
                            VStack(alignment: .leading) {
                                
                                HStack {
                                    
                                    Circle()
                                        .fill(DayModel.dayColors[day.day - 1])
                                        .frame(width: 50)
                                        .overlay {
                                            
                                            Text(day.day.convertWeekdayToString().prefix(1).capitalized)
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            
                                        }
                                    
                                    VStack(alignment: .leading) {
                                        Text(day.day.convertWeekdayToString())
                                            .font(.title3)
                                            .fontWeight(.bold)
                                        
                                    }
                                    .padding(.leading, 3)
                                    
                                    Spacer()
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                                
                                
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(UIColor.secondaryLabel))
                            .cornerRadius(15)
                            
                        }
                        .transition(AnyTransition.scale)
                        .listStyle(InsetGroupedListStyle())
                        .listRowBackground(Color(UIColor.clear))
                        .listRowInsets(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
                        .buttonStyle(PlainButtonStyle())
                        .padding(.bottom, 10)
                        .listRowSeparator(.hidden)
                    }
                header: {
                    HStack {
                        Text("Schedule (\(periodViewModel.usersFullSchedule.count))")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        
                        Button {
                            
                        } label: {
                            
                            Image(systemName: "plus")
                                .textCase(.none)
                                .font(.footnote)
                                .padding([.leading,.trailing], 10)
                                .padding([.top, .bottom], 4)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .background {
                                    
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.blue.gradient)
                                }
                        }
                        
                    }
                }
                    
                    Section {
                        Button {
                            signInViewModel.signOut()
                        } label: {
                            Text("Sign Out")
                        }
                        .listRowBackground(Color(UIColor.secondaryLabel))
                        
                        
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
        SettingsView(showSheet: .constant(false))
            .environmentObject(PeriodViewModel())
            .environmentObject(SignInViewModel())
    }
}

