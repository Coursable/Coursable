//
//  SlideUpCircle.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/12/22.
//

import SwiftUI

struct SlideUpCircle: View {
    
    var isSlideUp: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .shadow(radius: 5, x: 0, y: 2)
            
            
            Image(systemName: "chevron.up")
                .fontWeight(.bold)
                .scaleEffect(isSlideUp ? -1 : 1)
        }
    }
}

struct SlideUpCircle_Previews: PreviewProvider {
    static var previews: some View {
        SlideUpCircle(isSlideUp: true)
    }
}
