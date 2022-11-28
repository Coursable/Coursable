//
//  ForgotPasswordView.swift
//  Coursable
//
//  Created by Ari Reitman on 11/27/22.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var signInViewModel: SignInViewModel
    @FocusState var isEmailInputActive: Bool
    @State var email: String = ""
    @State var hasError: Bool = false
    @State var errorType: SignInViewModel.resetPasswordCodes = .success
    @State var isLoading: Bool = false
    @State var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ForgotPasswordTopInfoView()
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    VStack {

                        
                        ForgotPasswordEmailFieldView(email: $email, focused: $isEmailInputActive, hasError: hasError)
                        
                        Button {
                            isEmailInputActive = false
                            resetPasswordUIHandler()
                        } label: {
                            ForgotPasswordSubmitButtonView(isLoading: isLoading)
                        }
                        .disabled(isLoading)
                        .padding(.top, 25)

                    }
                    .padding()
                }
            }
            
            if isLoading {
                CustomLoading()
            }
            
            if showAlert {
                if hasError {
                    if errorType == .error {
                        CustomAlert(presentAlert: $showAlert, alertType: .resetPasswordErrorSent, rightButtonAction:  {
                            withAnimation {
                                showAlert = false
                            }
                        })
                    }
                    else {
                        CustomAlert(presentAlert: $showAlert, alertType: .resetPasswordNoEmailAssociated, rightButtonAction:  {
                            withAnimation {
                                showAlert = false
                            }
                            
                        })
                    }

                }
                else {
                    CustomAlert(presentAlert: $showAlert, alertType: .resetPasswordSuccessfullySent, rightButtonAction:  {
                        withAnimation {
                            showAlert = false
                        }
                        presentationMode.wrappedValue.dismiss()
                    })
                }

            }
            
        }
        .navigationBarBackButtonHidden()
        .scrollDisabled(true)
        .toolbar {
    
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()

                Button("Done") {
                    isEmailInputActive = false
                }
            }
            
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
    }
    
    func resetPasswordUIHandler() {
        if !self.email.isEmpty {
            if signInViewModel.isValidEmailAddress(emailAddressString: email) {
                Task {
                    withAnimation {
                        isLoading = true
                    }
                    
                    switch await signInViewModel.resetPassword(email: email) {
                    case .success:
                        withAnimation {
                            showAlert = true
                            hasError = false
                        }
                        
                        errorType = .success

                    case .error:
                        withAnimation {
                            showAlert = true
                            hasError = true
                        }
                        errorType = .error
                    case .noEmailAssociated:
                        withAnimation {
                            showAlert = true
                            hasError = true
                        }
                        errorType = .noEmailAssociated

                        
                        
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
        else {
            withAnimation {
                hasError = true
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .environmentObject(SignInViewModel())
    }
}
