//
//  OtherOptionsDividerView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/22/22.
//

import SwiftUI

struct OtherOptionsDividerView: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 1)
                .foregroundColor(.secondary)
            
            Text("or sign in with")
                .foregroundColor(.secondary)
            
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 1)
                .foregroundColor(.secondary)
        }
    }
}

struct OtherOptionsDividerView_Previews: PreviewProvider {
    static var previews: some View {
        OtherOptionsDividerView()
    }
}
