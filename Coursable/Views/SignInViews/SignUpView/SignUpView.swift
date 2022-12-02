//
//  SignUpView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/25/22.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var signInViewModel: SignInViewModel
    
    @State var name = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""
    @State var isLoading: Bool = false
    @State var hasError: Bool = false
    @State var isSecured: Bool = true

    @FocusState var isNameInputActive: Bool
    @FocusState var isLastNameInputActive: Bool
    @FocusState var isUsernameInputActive: Bool
    @FocusState var isPasswordInputActive: Bool
    
    @State var nameError: Bool = false
    @State var lastNameError: Bool = false
    @State var emailError: Bool = false
    @State var passwordError: Bool = false
    
    @State var showErrorAlert: Bool = false
    @State var errorMessage: String = ""
    
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        ZStack {
            ScrollView {
                SignUpTopInfoView()
                    .foregroundColor(.white)
                
                VStack {
                    VStack(spacing: 17) {
                        Group {
                            HStack(spacing: 17) {
     
                                SignUpNameCardView(name: $name, focused: $isNameInputActive, hasError: nameError)
                                
                                SignUpLastNameCardView(lastName: $lastName, focused: $isLastNameInputActive, hasError: lastNameError)
                            }
                            
                            SignUpEmailCardView(email: $email, focused: $isUsernameInputActive, hasError: emailError)
                            
                            SignUpPasswordCardView(isSecured: $isSecured, password: $password, focused: $isPasswordInputActive, hasError: passwordError)
                            

                            
                        }

                    }
                    
                    Button {
                        isUsernameInputActive = false
                        isPasswordInputActive = false
                        isNameInputActive = false
                        isLastNameInputActive = false
                        
                        if !isLoading {
                            checkRequirments()
                            signUpUIHandler()
                        }
                    } label: {
                        
                        SignUpButtonView(isLoading: isLoading)
                        
                    }
                    .padding(.top, 20)
                    .disabled(isLoading)
                    
                    SignUpOtherOptionsDividerView()
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    Button {
                        signInViewModel.signInWithGoogle()
                    } label: {
                        SignInWithGoogle()
                    }
                    .padding(.top)
                }
                .padding()
            }
            .navigationBarBackButtonHidden()
            .scrollDisabled(true)
            .toolbar {
        
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        isUsernameInputActive = false
                        isPasswordInputActive = false
                        isNameInputActive = false
                        isLastNameInputActive = false
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isUsernameInputActive = false
                        isPasswordInputActive = false
                        isNameInputActive = false
                        isLastNameInputActive = false
                        
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

            
            if showErrorAlert {
                CustomAlert(presentAlert: $showErrorAlert, title: "Error", bodyText: "An account has already been created under this email", leftButtonText: "", rightButtonText: "Ok", rightButtonAction:  {
                    withAnimation(.easeInOut) {
                        showErrorAlert = false
                    }
                })
            }
            
            if isLoading {
                CustomLoading()
            }
        }
        
    }
    
    func signUpUIHandler() {
        if !nameError && !lastNameError && !emailError && !passwordError {
            Task {
                withAnimation {
                    isLoading = true
                }
                
                switch await signInViewModel.signUp(email: email, password: password, name: name, lastName: lastName) {
                case .success:
                    break
                case .error:
                    withAnimation(.easeInOut) {
                        showErrorAlert = true
                    }
                    errorMessage = "Unable to create account"
                case .emailAlreadyTaken:
                    withAnimation(.easeInOut) {
                        showErrorAlert = true
                    }
                    errorMessage = "The email address is already in use by another account"
                }
                
                
                    
                withAnimation {
                    isLoading = false
                }
                
            }
        }
    }
    
    
    
    func checkRequirments() {
        if !signInViewModel.isValidEmailAddress(emailAddressString: email) {
            withAnimation() {
                emailError = true
            }
        }
        else {
            withAnimation() {
                emailError = false
            }
        }
        
        if password.count < 8 {
            withAnimation {
                passwordError = true
            }
        }
        else {
            withAnimation {
                passwordError = false
            }
        }
        
        if lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            withAnimation(.linear(duration: 0.1)) {
                lastNameError = true
            }
            
        }
        else {
            withAnimation(.linear(duration: 0.1)) {
                lastNameError = false
            }
        }
        
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            withAnimation(.linear(duration: 0.1)) {
                nameError = true
            }
            
        }
        else {
            withAnimation(.linear(duration: 0.1)) {
                nameError = false
            }
        }
        
        
        
        
    }
        
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(SignInViewModel())
    }
}
