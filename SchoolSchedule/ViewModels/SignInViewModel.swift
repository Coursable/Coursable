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
    
    @Published var isSignedIn: Bool = false
    @Published var didSucceed: Bool = false
    
    
    func signIn(email: String, password: String) {
        didSucceed = false
        
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.didSucceed = false
                }
                
            }
            else {
                DispatchQueue.main.async {
                    self?.didSucceed = true
                    self?.isSignedIn = true
                }
            }
            
            
        }
        
        
    }
}
