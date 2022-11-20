//
//  NavBarTest.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/19/22.
//

import SwiftUI

struct NavBarTest: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TopNavBar {
                Text("test")
                    .foregroundColor(.white)

            }
            
            Spacer()
        }
        .background(.red)
        .navigationBarHidden(true)

        
    }

}

struct NavBarTest_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NavBarTest()
            Spacer()
        }
    }
}
