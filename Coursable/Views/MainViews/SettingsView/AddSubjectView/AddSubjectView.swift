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
//    @State var colorGradientPrimary = colors[0]
//    @State var colorGradientSecondary = colors[2]

    @State var colorGradients = [colors[0], colors[2]]
    
    @State var showAlert: Bool = false
    @State var isLoading: Bool = false
    @State var errorMessage: AddSubjectErrors = .generalError
    @Binding var subjectToEdit: Subject?
    

    var body: some View {
        ZStack {
            VStack {
                AddSubjectTopBarView(showAddSubjectSheet: $showAddSubjectSheet, subjectToEdit: $subjectToEdit)
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
                        
                        AddSubjectCustomColorView(subjectName: name, colorPrimary: $colorGradients[0], colorSecondary: $colorGradients[1])
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
                                    
                                    let newSubject = Subject(id: UUID().uuidString, name: name, teacher: teacher, colorGradientPrimary: [
                                        colorGradients[0].components.red, colorGradients[0].components.green, colorGradients[0].components.blue], colorGradientSecondary: [colorGradients[1].components.red, colorGradients[1].components.green, colorGradients[1].components.blue], roomNumber: roomNumber)
                                    
                                    if let subjectToEdit = subjectToEdit {
                                        Task {
                                            withAnimation {
                                                isLoading = true
                                            }
                                            await periodViewModel.overwriteIndividualSubjectData(subjectToOverwrite: subjectToEdit, newSubjectData: newSubject)
                                            showAddSubjectSheet = false
                                            withAnimation {
                                                isLoading = false
                                            }
                                        }
                                    }
                                    else {
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
                                if subjectToEdit != nil {
                                    Text("Confirm")
                                        .fontWeight(.semibold)
                                        .font(.title2)
                                }
                                else {
                                    Text("Add Subject")
                                        .fontWeight(.semibold)
                                        .font(.title2)
                                }
                                
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
        .onAppear {
            if let subjectToEdit = subjectToEdit {
                name = subjectToEdit.name
                roomNumber = subjectToEdit.roomNumber
                teacher = subjectToEdit.teacher
                
                let subjectToEditGradients = [subjectToEdit.colorGradientPrimary, subjectToEdit.colorGradientSecondary]
                
                for (index, _) in colorGradients.enumerated() {
                    setGradient(index: index)
                }
                
                func setGradient(index: Int) {
                    for color in colors {
                        let colorArray: [Double] = [color.components.red, color.components.green, color.components.blue]
                        if subjectToEditGradients[index] == colorArray {
                            colorGradients[index] = color
                        }
                    }
                }
                
            }
            else {
                name = ""
                roomNumber = ""
                teacher = ""
            }
        }
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
        AddSubjectView(showAddSubjectSheet: .constant(false), subjectToEdit: .constant(nil))
            .environmentObject(PeriodViewModel())
    }
}
