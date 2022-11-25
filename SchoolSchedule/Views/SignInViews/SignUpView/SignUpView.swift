//
//  SignUpView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/25/22.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var signInViewModel: SignInViewModel
    @State var name = "Ari"
    @State var lastName = "Reitman"
    @State var email = "a.reitman@icloud.com"
    @State var password = "Chess123"
    @State var isLoading: Bool = false
    @State var hasError: Bool = false
    @State var isSecured: Bool = true
    @State var hasFullFilledPasswordRequirments: Bool = false
    @FocusState var isNameInputActive: Bool
    @FocusState var isLastNameInputActive: Bool
    @FocusState var isUsernameInputActive: Bool
    @FocusState var isPasswordInputActive: Bool
    
    
    var body: some View {
        ScrollView {
            TopInfoSignUpView()
                .foregroundColor(.white)
            
            VStack {
                VStack(spacing: 17) {
                    Group {
                        HStack(spacing: 17) {
                            LoginTextField {
                                TextField(text: $name) {
                                    Text("Name")
                                        .foregroundColor(Color(.gray))
                                }
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .focused($isNameInputActive)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                            }
                            .fontWeight(.semibold)
                            
                            LoginTextField {
                                TextField(text: $lastName) {
                                    Text("Last Name")
                                        .foregroundColor(Color(.gray))
                                }
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .focused($isNameInputActive)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                            }
                            .fontWeight(.semibold)
                        }
                        
                        LoginTextField {
                            TextField(text: $email) {
                                Text("Email")
                                    .foregroundColor(Color(.gray))
                            }
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .focused($isNameInputActive)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                        }
                        .fontWeight(.semibold)
                        
                        VStack {
                            LoginTextField {
                                TextField(text: $password) {
                                    Text("Password")
                                        .foregroundColor(Color(.gray))
                                }
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .focused($isNameInputActive)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                            }
                            .fontWeight(.semibold)
                            
                            HStack {
                                Spacer()
                                Image(systemName: "checkmark.seal.fill")
                                Text("Password must be 8 characters")

                            }
                            .font(.subheadline)
                            .foregroundColor(password.count >= 8 ? .green : .red)
                            .fontWeight(.semibold)
                        }
                        
                    }
                }
                
                
                Button {
                    isUsernameInputActive = false
                    isPasswordInputActive = false
                    isNameInputActive = false
                    isLastNameInputActive = false
                    
                    
                } label: {
                    
                    Group {
                        if !isLoading {
                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .font(.title2)
                        }
                        else {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width*0.9, height: 65)
                    
                    .background(LinearGradient.bluePink)
                    .opacity(isLoading ? 0.6 : 1)
                    .cornerRadius(16)
                    
                }
                .padding(.top, 50)
                
                OtherOptionsSignUpDividerView()
                    .foregroundColor(.white)
                    .padding(.top)
                
                Button {
                    
                } label: {
                    SignInWithGoogle()
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
        }
        .background {
            Color("Background")
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width * 10) //extend the frame to prevent background clashing
        }

        .scrollDisabled(true)
            

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUpView()
        }
    }
}
