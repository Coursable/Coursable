//
//  OtherOptionsDividerView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/22/22.
//

import SwiftUI

struct LoginOtherOptionsDividerView: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 1)
            
            Text("or sign in with")
            
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 1)
        }
    }
}

struct OtherOptionsDividerView_Previews: PreviewProvider {
    static var previews: some View {
        LoginOtherOptionsDividerView()
    }
}
