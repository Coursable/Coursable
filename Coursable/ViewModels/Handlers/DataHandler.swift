//
//  DataViewModel.swift
//  Coursable
//
//  Created by Ari Reitman on 11/28/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class DataHandler {
    public func setSubjectData(subjectsToSave: [Subject],completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        
        
        if let currentUser = SignInViewModel().auth.currentUser {
            do {
                for subject in subjectsToSave {
                    try db.collection("users").document(currentUser.uid).collection("subjects").document(subject.name).setData(from: subject)
                }
                completion(true)
            }
            catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        else {
            completion(false)
        }
    }
    
    public func overwriteIndividualSubjectData(subjectToOverwrite: Subject, newSubjectData: Subject, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        
        if let currentUser = SignInViewModel().auth.currentUser {
            do {
                db.collection("users").document(currentUser.uid).collection("subjects").document(subjectToOverwrite.name).delete(completion: { error in
                    if let errorValue = error {
                        print(errorValue.localizedDescription)
                        completion(false)
                    }
                })

                completion(true)
                
                try db.collection("users").document(currentUser.uid).collection("subjects").document(newSubjectData.name).setData(from: newSubjectData)
                
                
                completion(true)
            }
            catch {
                print(error.localizedDescription)
                completion(false)
            }

            
            
        }
        else {
            completion(false)
        }
    }
    
    public func removeIndividualSubjectData(subjectToRemove: Subject, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        
        if let currentUser = SignInViewModel().auth.currentUser {
            db.collection("users").document(currentUser.uid).collection("subjects").document(subjectToRemove.name).delete(completion: { error in
                if let errorValue = error {
                    print(errorValue.localizedDescription)
                    completion(false)
                }
            })
            completion(true)
            
        }
        else {
            completion(false)
        }
    }
    
    public func setIndividualSubjectData(subjectToSave: Subject,completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        
        
        if let currentUser = SignInViewModel().auth.currentUser {
            do {
                
                try db.collection("users").document(currentUser.uid).collection("subjects").document(subjectToSave.name).setData(from: subjectToSave)
                completion(true)
            }
            catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        else {
            completion(false)
        }
    }
    
    public func getSubjectData(completion: @escaping (Bool, [Subject]) -> Void) async {
        let db = Firestore.firestore()
        
        if let currentUser = SignInViewModel().auth.currentUser {
            do {
                let querySnapshot = try await db.collection("users").document(currentUser.uid).collection("subjects").getDocuments()
                
                completion(true, querySnapshot.documents.map { d in
                    
                    return Subject(id: d.documentID, name: d["name"] as? String ?? "", teacher: d["teacher"] as? String ?? "", colorGradientPrimary: d["colorGradientPrimary"] as? [Double] ?? [0.0, 0.0, 0.0], colorGradientSecondary: d["colorGradientSecondary"] as? [Double] ?? [0.0, 0.0, 0.0], roomNumber: d["roomNumber"] as? String ?? "")
                    
                })
                
                
            }
            catch {
                print(error.localizedDescription)
                completion(false, [])
            }
        }
        else {
            print("No account signed in")
            completion(false, [])
        }
    }
}
