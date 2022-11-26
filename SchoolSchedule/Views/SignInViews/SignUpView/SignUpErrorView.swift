//
//  SignUpErrorView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/25/22.
//

import SwiftUI

struct SignUpErrorView: View {
    var systemImage: String
    var message: String
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle")
            Text(message)
        }
        .foregroundColor(.red)
        .fontWeight(.semibold)
    }
}

struct SignUpErrorView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpErrorView(systemImage: "exclamationmark.triangle", message: "Error")
    }
}
