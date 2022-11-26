//
//  SignUpView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/25/22.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var signInViewModel: SignInViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    
    @State var name = "Ari"
    @State var lastName = "Reitman"
    @State var email = "a.reitman@icloud.com"
    @State var password = "Chess123"
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
        ScrollView {

            HStack {
                Button {
                    isUsernameInputActive = false
                    isPasswordInputActive = false
                    isNameInputActive = false
                    isLastNameInputActive = false
                    viewRouter.currentPage = .signInPage
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .font(.title2)
                }
                .padding(.leading)
                Spacer()
            }
            
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
                
                SignUpOtherOptionsDividerView()
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
            
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    isUsernameInputActive = false
//                    isPasswordInputActive = false
//                    isNameInputActive = false
//                    isLastNameInputActive = false
//                    viewRouter.currentPage = .signInPage
//
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                }
//            }
            

        }
        .background {
            Color("Background")
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width * 10) //extend the frame to prevent background clashing
        }
        .alert(errorMessage, isPresented: $showErrorAlert, actions: {
            Button {
                showErrorAlert = false
            } label: {
                Text("Ok")
            }

        })
        
    }
    
    func signUpUIHandler() {
        if !nameError && !lastNameError && !emailError && !passwordError {
            Task {
                withAnimation {
                    isLoading = true
                }
                
                switch await signInViewModel.signUp(email: email, password: password, name: name, lastName: lastName) {
                case .success:
                    viewRouter.currentPage = .mainPage
                case .error:
                    viewRouter.currentPage = .signUpPage
                    showErrorAlert = true
                    errorMessage = "Unable to create account"
                case .emailAlreadyTaken:
                    viewRouter.currentPage = .signUpPage
                    showErrorAlert = true
                    errorMessage = "The email address is already in use by another account"
                }
                
                
                    
                withAnimation {
                    isLoading = false
                }
                
            }
        }
    }
    
    
    
    func checkRequirments() {
        if !isValidEmailAddress(emailAddressString: email) {
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
        
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(SignInViewModel())
            .environmentObject(ViewRouter())
    }
}
