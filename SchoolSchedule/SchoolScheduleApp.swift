//
//  SchoolScheduleApp.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/23/22.
//

import SwiftUI
import Firebase

@main
struct SchoolScheduleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var periodViewModel = PeriodViewModel()
    @StateObject var signInViewModel = SignInViewModel()
    
    var body: some Scene {
        
        
        WindowGroup {
            NavigationView {
                MainSignInView()
                    .environmentObject(periodViewModel)
                    .environmentObject(signInViewModel)
                .preferredColorScheme(.light)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
