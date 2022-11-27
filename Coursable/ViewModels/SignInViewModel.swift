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
}
