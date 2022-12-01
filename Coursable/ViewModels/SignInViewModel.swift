//
//  SignInViewModel.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/21/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class SignInViewModel: ObservableObject {
    let auth = Auth.auth()
    var viewRouter = ViewRouter()
    
    @Published var isSignedIn = false
    
    var signedIn: Bool {
        return auth.currentUser != nil
    }
    
    
    enum signInCodes {
        case success
        case invalidEmailPassword
    }
    
    enum signUpCodes {
        case success
        case emailAlreadyTaken
        case error
    }
    
    enum createUserCodes: Error {
        case error
    }
    
    enum resetPasswordCodes {
        case success
        case error
        case noEmailAssociated
    }
    
    func resetPassword(email: String) async -> resetPasswordCodes  {
        do {
            try await auth.sendPasswordReset(withEmail: email)
            print("Successfully sent an email to: \(email)")
            return .success
        }
        catch {
            print(error.localizedDescription)
            if error.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                return .noEmailAssociated
            } else {
                return .error
            }
        }
        
    }
    
    func signUp(email: String, password: String, name: String, lastName: String) async -> signUpCodes {
        do {
            //let db = Firestore.firestore()
            let userData: AuthDataResult = try await auth.createUser(withEmail: email, password: password)
            
            
            try createNewUserProfile(userData: userData, name: name, lastName: lastName)
            
            DispatchQueue.main.async {
                withAnimation {
                    self.isSignedIn = true
                }
            }
            
            print("Successfully signed up under user: \(email)")
            
            
            
            return signUpCodes.success
            
        } catch {
            DispatchQueue.main.async {
                withAnimation {
                    self.isSignedIn = false
                }
            }
            
            print(error.localizedDescription)
            
            if error.localizedDescription == "The email address is already in use by another account." {
                return signUpCodes.emailAlreadyTaken
            } else {
                return signUpCodes.error
            }
            
            
            
        }
    }
    
    private func createNewUserProfile(userData: AuthDataResult, name: String, lastName: String) throws {
        let db = Firestore.firestore()

        let valueToAdd = UserInfoModel(userId: userData.user.uid, name: name, lastName: lastName)
        
        do {
            try db.collection("users").document(userData.user.uid).setData(from: valueToAdd)
        }
        catch {
            throw createUserCodes.error
        }
        

            

    }
    
    
    func signOut() {
        do {
            try auth.signOut()
            
            DispatchQueue.main.async {
                withAnimation {
                    self.isSignedIn = false
                }
            }
            
            print("Successfully logged out user")
            
            
            
            return
            
        } catch {
            DispatchQueue.main.async {
                withAnimation {
                    self.isSignedIn = false
                }
            }
            
            
            print(error.localizedDescription)
            
            return
        }

            
    }
    
    func signIn(email: String, password: String) async -> signInCodes {
        do {
            try await auth.signIn(withEmail: email, password: password)
            
            DispatchQueue.main.async {
                withAnimation {
                    self.isSignedIn = true
                }
                
            }
            
            print("Successfully signed in user account under: \(email)")
            
            return signInCodes.success
            
        } catch {
            DispatchQueue.main.async {
                withAnimation {
                    self.isSignedIn = false
                }
            }
            
            print(error.localizedDescription)
            
            return signInCodes.invalidEmailPassword
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
