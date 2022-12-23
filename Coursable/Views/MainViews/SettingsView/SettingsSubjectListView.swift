//
//  SettingsSubjectListView.swift
//  Coursable
//
//  Created by Ari Reitman on 12/22/22.
//

import SwiftUI

struct SettingsSubjectListView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    @Binding var subjectFolded: Bool
    @Binding var showAddSubjectSheet: Bool
    @Binding var subjectToEdit: Subject?
    @Binding var isEdittingSubjects: Bool
    
    var body: some View {
        Section {
            
            ForEach(Array(periodViewModel.usersSubjects.enumerated()), id: \.offset) { index, subject in
                if !subjectFolded || index + 1 <= 3 {
                    
                    SettingsCourseCardView(isEditingSubjects: isEdittingSubjects, subject: subject, showAddSubjectSheet: $showAddSubjectSheet, subjectToEdit: $subjectToEdit)
                        .foregroundColor(.white)
                        .background(Color(UIColor.secondaryLabel))
                        .cornerRadius(15)
                }
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
                Text("Subjects (\(periodViewModel.usersSubjects.count))")
                    .foregroundColor(.white)
                
                Spacer()
                
                if isEdittingSubjects {
                    Button {
                        showAddSubjectSheet = true
                        
                    } label: {
                        Text("Add")
                            .textCase(.none)
                            .font(.footnote)
                            .padding([.leading,.trailing], 10)
                            .padding([.top, .bottom], 4)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .background {
                                
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.green.gradient)
                                
                            }
                    }
                }
                
                Button {
                    withAnimation {
                        isEdittingSubjects.toggle()
                    }
                } label: {
                    
                    Group {
                        if !isEdittingSubjects {
                            Text("Edit")
                            
                        }
                        else {
                            Text("Done")
                        }
                    }
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
                
                if periodViewModel.usersSubjects.count > 3 {
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            subjectFolded.toggle()
                        }
                        
                    } label: {
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees(subjectFolded ? 180 : 0))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.leading)
                        
                    }
                }
 
            }
        }
    }
}


struct SettingsSubjectListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Form {
                SettingsSubjectListView(subjectFolded: .constant(false), showAddSubjectSheet: .constant(false), subjectToEdit: .constant(nil), isEdittingSubjects: .constant(false))
                    .environmentObject(PeriodViewModel())
                
            }
            .scrollContentBackground(.hidden)
            
        }
        .background {
            Color("Background")
                .ignoresSafeArea()
        }
        
    }
}
