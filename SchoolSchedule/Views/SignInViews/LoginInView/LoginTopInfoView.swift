//
//  TopInfoLoginView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/22/22.
//

import SwiftUI

struct LoginTopInfoView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Welcome")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    
                Text("To begin using the app, please sign in")
                    .font(.subheadline)
            }
            .padding()
            Spacer()
        }
    }
}

struct TopInfoLoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginTopInfoView()
    }
}
