//
//  SignInViewModel.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/21/22.
//

import Foundation
import Firebase
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
    
    func signIn(email: String, password: String) async -> signInCodes {
        do {
            try await auth.signIn(withEmail: email, password: password)
            
            DispatchQueue.main.async {
                self.isSignedIn = true
            }
            
            print("Successfully logged in under user: \(email)")
            
            return signInCodes.success
            
        } catch {
            DispatchQueue.main.async {
                self.isSignedIn = false
            }
            
            print(error.localizedDescription)
            
            return signInCodes.invalidEmailPassword
        }
    }
    
    
    func signOut() {
        do {
            try auth.signOut()
            
            DispatchQueue.main.async {
                self.isSignedIn = false
            }
            
            print("Successfully logged out user")
            
            return
            
        } catch {
            DispatchQueue.main.async {
                self.isSignedIn = false
            }
            
            print(error.localizedDescription)
            
            return
        }

            
    }
}
