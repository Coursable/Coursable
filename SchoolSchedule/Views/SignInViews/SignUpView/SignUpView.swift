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
    
    @State var isAllowedToSubmit = true
    
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
                                .onChange(of: name, perform: { newValue in
                                    checkRequirments()
                                })
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
                                .onChange(of: lastName, perform: { newValue in
                                    checkRequirments()
                                })
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .focused($isLastNameInputActive)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                            }
                            .fontWeight(.semibold)
                        }
                        
                        VStack {
                            LoginTextField {
                                TextField(text: $email) {
                                    Text("Email")
                                        .foregroundColor(Color(.gray))
                                }
                                .onChange(of: email, perform: { newValue in
                                    checkRequirments()
                                })
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .focused($isUsernameInputActive)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                            }
                            .fontWeight(.semibold)

                        }
                        
                        VStack {
                            LoginTextField {
                                TextField(text: $password) {
                                    Text("Password")
                                        .foregroundColor(Color(.gray))
                                }
                                .onChange(of: password, perform: { newValue in
                                    checkRequirments()
                                })
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .focused($isPasswordInputActive)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                            }
                            .fontWeight(.semibold)
                            
                            
                        }
                        

                        
                    }

                }
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack {
                        
                        Image(systemName: "checkmark.seal.fill")
                        Text("Name Must Be Valid")
                        Spacer()
                    }
                    .foregroundColor(!name.isEmpty ? .green : .red)
                    
                    HStack {
                        
                        Image(systemName: "checkmark.seal.fill")
                        Text("Last Name Must Be Valid")
                        Spacer()
                    }
                    .foregroundColor(!lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .green : .red)
                    
                    HStack {
                        
                        Image(systemName: "checkmark.seal.fill")
                        Text("Email Must Be Valid")
                        Spacer()
                    }
                    .foregroundColor(isValidEmailAddress(emailAddressString: email) ? .green : .red)
                    
                    
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                        Text("Password must 8 or more characters")
                        Spacer()
                    }
                    .foregroundColor(password.count >= 8 ? .green : .red)
                }
                .padding(.top)
                .fontWeight(.semibold)
                .font(.subheadline)
                
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
                .disabled(!isAllowedToSubmit)
                .opacity(isAllowedToSubmit ? 1 : 0.5)
                .padding(.top, 20)
                
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
    
    func checkRequirments() {
        var allRequirementsMet = true

        
        if !isValidEmailAddress(emailAddressString: email) {
            allRequirementsMet = false
        }
        
        if password.count < 8 {
            allRequirementsMet = false
        }
        
        if lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            allRequirementsMet = false
        }
        
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            allRequirementsMet = false
        }
        
        withAnimation(.linear(duration: 0.1)) {
            isAllowedToSubmit = allRequirementsMet
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
        NavigationView {
            SignUpView()
        }
    }
}
