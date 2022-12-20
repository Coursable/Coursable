//
//  LoginView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/22/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var signInViewModel: SignInViewModel
    @State var email = ""
    @State var password = ""
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
                                    
                                    CustomTextField {
                                        TextField(text: $email) {
                                            Text("Email")
                                                .foregroundColor(Color(.gray))
                                        }
                                        .foregroundColor(.white)
                                        .focused($isUsernameInputActive)


                                        Image(systemName: "exclamationmark.triangle")
                                            .foregroundColor(.red)
                                            .opacity(hasError ? 1 : 0)


                                        Button {
                                            email = ""
                                        } label: {
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(Color(.gray))
                                        }

                                    }

                                    VStack {
                                        CustomTextField {
                                            Group {
                                                if isSecured {
                                                    SecureField(text: $password) {
                                                        Text("Password")
                                                            .foregroundColor(.gray)
                                                    }
                                                    .foregroundColor(.white)
                                                }
                                                else {
                                                    TextField(text: $password) {
                                                        Text("Password")
                                                            .foregroundColor(.gray)
                                                    }
                                                    .foregroundColor(.white)
                                                }
                                            }
                                            .autocorrectionDisabled(true)
                                            .autocapitalization(.none)
                                            .focused($isPasswordInputActive)

                                            
                                               

                                            
                                            if hasError {
                                                Image(systemName: "exclamationmark.triangle")
                                                    .foregroundColor(.red)
                                            }
                                            
                                            
                                            Button {
                                                isSecured.toggle()
                                            } label: {
                                                Group {
                                                    if isSecured { Image(systemName: "eye") }
                                                    else { Image(systemName: "eye.slash") }
                                                }
                                                .foregroundColor(Color(.gray))
                                                    
                                            }
                                        }
                                        
                                        
                                        HStack {
                                            Spacer()
                                            NavigationLink {
                                                ForgotPasswordView()
                                            } label: {
                                                Text("Forgot Password?")
                                                    .underline()
                                                    .font(.subheadline)
                                                    .foregroundColor(.white)
                                                    .fontWeight(.semibold)
                                            }

                                            
                                        }
                                    }
                                }
                                .fontWeight(.semibold)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
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
                                signInViewModel.signInWithGoogle()
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
                    withAnimation(.linear(duration: 0.2)) {
                        hasError = true
                    }
                case .success:
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
    }
}
