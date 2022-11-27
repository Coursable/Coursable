//
//  LoginView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/22/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var signInViewModel: SignInViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    @State var email = "a.reitman@icloud.com"
    @State var password = "Chess123"
    @State var isLoading: Bool = false
    @State var hasError: Bool = false
    @State var isSecured: Bool = true
    @FocusState var isUsernameInputActive: Bool
    @FocusState var isPasswordInputActive: Bool
    
    
    var body: some View {
        ZStack {
            ScrollView {
                    VStack {
                        LoginTopInfoView()
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        VStack {
                            VStack(spacing: 17) {
                                Group {
                                    LoginEmailCardView(email: $email, focused: $isUsernameInputActive, hasError: hasError)
                                        .fontWeight(.semibold)

                                    VStack {
                                        LoginPasswordCardView(isSecured: $isSecured, password: $password, focused: $isPasswordInputActive, hasError: hasError)
                                            .fontWeight(.semibold)
                                        
                                        
                                        HStack {
                                            Spacer()
                                            Text("Forgot Password?")
                                                .underline()
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                .fontWeight(.semibold)
                                        }
                                    }
                                }
                            }

                            Button {
                                isUsernameInputActive = false
                                isPasswordInputActive = false
                                if !isLoading {
                                    signInUIHandler()
                                }
                                
                                
                            } label: {
                                SignInButtonView(isLoading: isLoading)
                            }
                            .disabled(isLoading)
                            .padding(.top, 50)
                            
                            
                            LoginOtherOptionsDividerView()
                                .foregroundColor(.white)
                                .padding(.top)
                            
                            Button {
                                
                            } label: {
                                SignInWithGoogle()
                            }
                            .padding(.top)
                            
                            
                            HStack(spacing: 0) {
                                Text("Don't have an account? ")
                                    .foregroundColor(.white)

                                
                                NavigationLink {
                                    SignUpView()
                                } label: {
                                    Text("Sign Up")
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .underline()
                                }
       
                            }
                            .padding(.top)

                            Spacer()
                            
                        }
                        .padding()
                        
             
                    }

            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        isUsernameInputActive = false
                        isPasswordInputActive = false
                    }
                }
                
            }
            .background(Color("Background"))
            .scrollDisabled(true)
            
            if isLoading {
                CustomLoading()
            }
        }
        
        
    }
    
    func signInUIHandler() {
        if !self.email.isEmpty && !self.password.isEmpty {
            Task {
                withAnimation {
                    isLoading = true
                }
                
                switch await signInViewModel.signIn(email: email, password: password) {
                case .invalidEmailPassword:
                    viewRouter.currentPage = .signInPage
                    withAnimation(.linear(duration: 0.2)) {
                        hasError = true
                    }
                case .success:
                    viewRouter.currentPage = .mainPage
                    withAnimation(.linear(duration: 0.2)) {
                        hasError = false
                    }
                    
                }
                    
                withAnimation {
                    isLoading = false
                }
                
            }
        }
        else {
            withAnimation {
                hasError = true
            }
        }
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SignInViewModel())
            .environmentObject(ViewRouter())
    }
}
