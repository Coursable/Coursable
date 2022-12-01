//
//  AddSubjectView.swift
//  Coursable
//
//  Created by Ari Reitman on 11/30/22.
//

import SwiftUI

struct AddSubjectView: View {
    @Binding var showAddSubjectSheet: Bool
    
    @FocusState var isNameTextFieldFocused: Bool
    @State var name = ""
    @State var roomNumber = ""
    @State var teacher = ""
    
    var body: some View {
        ZStack {
            VStack {
                AddSubjectTopBarView(showAddSubjectSheet: $showAddSubjectSheet)
                    .padding(.top)
                
                ScrollView {
                    VStack(spacing: 17) {
                        SettingsTextField {
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
                        
                        SettingsTextField {
                            TextField(text: $roomNumber) {
                                Text("Room Number")
                                    .foregroundColor(Color(.gray))
                            }
                            .textContentType(.oneTimeCode)
                            .keyboardType(.numberPad)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .focused($isNameTextFieldFocused)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                        }
                        
                        SettingsTextField {
                            TextField(text: $teacher) {
                                Text("Teacher")
                                    .foregroundColor(Color(.gray))
                            }
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .focused($isNameTextFieldFocused)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                        }
                        
                        AddSubjectCustomColorView()
                            .background(.secondary)
                            .fontWeight(.semibold)
                            .cornerRadius(16)
                            .scrollDisabled(false)
                        //.foregroundColor(.white)
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
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .interactiveDismissDisabled(true)

    }
}

struct AddSubjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubjectView(showAddSubjectSheet: .constant(false))
    }
}
