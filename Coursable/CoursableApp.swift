//
//  SchoolScheduleApp.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/23/22.
//

import SwiftUI
import Firebase

@main
struct CoursableApp: App {
    @Environment(\.colorScheme) var colorScheme
    
    init() {
        UITextField.appearance().keyboardAppearance = .dark
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var periodViewModel = PeriodViewModel()
    @StateObject var signInViewModel = SignInViewModel()
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        
        
        WindowGroup {
            MainSignInView()
                .environmentObject(periodViewModel)
                .environmentObject(signInViewModel)
                .environmentObject(viewRouter)
                .preferredColorScheme(.light)
                .onReceive(periodViewModel.timer) { input in
                    periodViewModel.updateTime(input: input)
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
