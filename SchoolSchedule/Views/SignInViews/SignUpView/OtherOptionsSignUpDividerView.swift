//
//  OtherOptionsSignUpDivider.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/25/22.
//

import SwiftUI

import SwiftUI

struct OtherOptionsSignUpDividerView: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 1)
            
            Text("or sign up with")
            
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 1)
        }
    }
}

struct OtherOptionsSignUpDividerView_Previews: PreviewProvider {
    static var previews: some View {
        OtherOptionsSignUpDividerView()
    }
}

