//
//  ViewRouter.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/25/22.
//

import Foundation

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .signInPage
}

enum Page {
    case signInPage
    case signUpPage
    case mainPage
}
