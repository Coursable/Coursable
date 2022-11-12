//
//  SlideUpView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/11/22.
//

import SwiftUI

struct SlideUpView: View {
    
    
    var body: some View {
        
        SlideUp(startingOffset: 370, endingOffset: 115, backgroundColor: .white, barColor: .secondary) {
            List {
                Text("test")
            }
            .scrollContentBackground(.hidden)
            .background(.white)
        }
        
    }
}

struct SlideUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SlideUpView()
                .background(.secondary)
        }
    }
}
