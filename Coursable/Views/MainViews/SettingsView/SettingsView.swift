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
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var showSheet: Bool
    @State var isLoading: Bool = false
    @State var showAddSubjectSheet: Bool = false
    
    
    var body: some View {
        ZStack {
            VStack {
                
                ZStack {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "chevron.down")
                            .font(.title2)
                    }
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .offset(x: -155)
                    
                    HStack {
                        Spacer()
                        Text("Settings")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                }
                
                Form {
                    Section {
                        ForEach(periodViewModel.usersSubjects) { subject in
                            SettingsCourseCardView(subject: subject)
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
                            Text("Subjects (\(periodViewModel.usersSubjects.count))")
                                .foregroundColor(.white)
                            
                            Spacer()
                            
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
                                            .foregroundStyle(LinearGradient.bluePink)
                                    }
                            }
                            //}

                        }
                    }
                    
                    Section {
                        Button {
                            signInViewModel.signOut()
                            viewRouter.currentPage = .signInPage
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
            AddSubjectView(showAddSubjectSheet: $showAddSubjectSheet)
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
            .environmentObject(ViewRouter())
    }
}
