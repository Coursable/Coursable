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
    
    
    func signIn(email: String, password: String) async -> Bool {
        do {
            try await auth.signIn(withEmail: email, password: password)
            
            DispatchQueue.main.async {
                self.isSignedIn = true
                print(self.isSignedIn)
            }
            
            print("Successfully logged in under user: \(email)")
            
            return true
            
        } catch {
            DispatchQueue.main.async {
                self.isSignedIn = false
            }
            
            print(error.localizedDescription)
            return false
        }
        
        
        
//        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
//            if let error = error {
//                print(error.localizedDescription)
//                DispatchQueue.main.async {
//                    self?.didSucceed = false
//                }
//
//            }
//            else {
//                DispatchQueue.main.async {
//                    self?.didSucceed = true
//                    self?.isSignedIn = true
//                }
//            }
//
//
//        }
        
        
    }
}
