//
//  AddSubjectView.swift
//  Coursable
//
//  Created by Ari Reitman on 11/30/22.
//

import SwiftUI

struct AddSubjectView: View {
    
    enum AddSubjectErrors: Error {
        case alreadyCreated
        case formNotCompleted
        case generalError
    }
    
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    @Binding var showAddSubjectSheet: Bool
    
    @FocusState var isNameTextFieldFocused: Bool
    @FocusState var isRoomNumberTextFieldFocused: Bool
    @FocusState var isTeacherTextFieldFocused: Bool
    @State var name = ""
    @State var roomNumber = ""
    @State var teacher = ""
    @State var gradientPrimaryColor: Color = colors[0]
    @State var gradientSecondaryColor: Color = colors[2]
    @State var showAlert: Bool = false
    @State var isLoading: Bool = false
    @State var errorMessage: AddSubjectErrors = .generalError
    
    
    
    
    
    var body: some View {
        ZStack {
            VStack {
                AddSubjectTopBarView(showAddSubjectSheet: $showAddSubjectSheet)
                    .padding(.top)
                
                ScrollView {
                    VStack(spacing: 17) {
                        CustomTextField {
                            TextField(text: $name) {
                                Text("Name")
                                    .foregroundColor(Color(.gray))
                            }
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .focused($isNameTextFieldFocused)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                        }
                        
                        CustomTextField {
                            TextField(text: $roomNumber) {
                                Text("Room Number")
                                    .foregroundColor(Color(.gray))
                            }
                            .textContentType(.oneTimeCode)
                            .keyboardType(.numberPad)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .focused($isRoomNumberTextFieldFocused)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                        }
                        
                        CustomTextField {
                            TextField(text: $teacher) {
                                Text("Teacher")
                                    .foregroundColor(Color(.gray))
                            }
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .focused($isTeacherTextFieldFocused)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                        }
                        
                        AddSubjectCustomColorView(subjectName: name, colorPrimary: $gradientPrimaryColor, colorSecondary: $gradientSecondaryColor)
                            .background(.secondary)
                            .fontWeight(.semibold)
                            .cornerRadius(16)
                            .scrollDisabled(false)
                        
                        Button {
                            isNameTextFieldFocused = false
                            isRoomNumberTextFieldFocused = false
                            isTeacherTextFieldFocused = false
                            
                            Task {
                                withAnimation {
                                    isLoading = true
                                }
                                if checkRequirments() {
                                    
                                    let newSubject = Subject(id: UUID().uuidString, name: name, teacher: teacher, colorGradientPrimary: [gradientPrimaryColor.components.red, gradientPrimaryColor.components.green, gradientPrimaryColor.components.blue], colorGradientSecondary: [gradientSecondaryColor.components.red, gradientSecondaryColor.components.green, gradientSecondaryColor.components.blue], roomNumber: roomNumber)
                                    
                                    
                                    if !periodViewModel.usersSubjects.contains(where:  { $0.name.lowercased() == name.lowercased() } ) {
                                        if periodViewModel.setIndividualSubjectData(subjectToSave: newSubject) {
                                            await periodViewModel.retrieveSubjectData()
                                            showAddSubjectSheet = false
                                        }
                                        else {
                                            errorMessage = .generalError
                                            withAnimation(.easeInOut) {
                                                
                                                showAlert = true
                                            }
                                        }
                                    }
                                    else {
                                        errorMessage = .alreadyCreated
                                        withAnimation(.easeInOut) {
                                            showAlert = true
                                        }
                                    }
                                    
                                }
                                else {
                                    errorMessage = .formNotCompleted
                                    withAnimation(.easeInOut) {
                                        showAlert = true
                                    }
                                }
                                
                                withAnimation {
                                    isLoading = false
                                }
                            }
                            
                            
                        } label: {
                            Group {
                                Text("Add Subject")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                            }
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width*0.9, height: 65)
                            .background(LinearGradient.bluePink)
                            //.opacity(isLoading ? 0.6 : 1)
                            .cornerRadius(16)
                            
                        }
                        .padding(.top)

                    }
                    
                    
                    
                    Spacer()
                }
                .padding()
                //.scrollDisabled(true)
                
                
                
            }
            .background {
                Color("Background")
                    .ignoresSafeArea()
            }
            
            if isLoading {
                CustomLoading()
            }
            
            if showAlert {
                CustomAlert(presentAlert: $showAlert, title: "Error", bodyText: convertErrorToStringMessage(errorEnum: errorMessage), rightButtonText: "Ok", rightButtonAction:  {
                    withAnimation(.easeInOut) {
                        showAlert = false
                    }
                    
                })
            }

            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .interactiveDismissDisabled(true)
    }
    
    func checkRequirments() -> Bool {
        
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
            
        }
        
        if roomNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        if teacher.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        return true
    }
    
    func convertErrorToStringMessage(errorEnum: AddSubjectErrors) -> String {
        switch errorEnum {
        case .generalError:
            return "Unable to add subject. Please try again later."
        case .alreadyCreated:
            return "Unable to add subject. This subject was already created."
        case .formNotCompleted:
            return "Unable to add subject. Some fields were not filled out."
        }
    }
}

struct AddSubjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubjectView(showAddSubjectSheet: .constant(false))
            .environmentObject(PeriodViewModel())
    }
}
