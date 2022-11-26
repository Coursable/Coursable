//
//  DayProgressBarView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/13/22.
//

import SwiftUI

struct DayProgressBarView: View {
    
    var value: Float
    var barColor: LinearGradient = .bluePink
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundStyle(barColor)
                                
                RoundedRectangle(cornerRadius: 20).frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
//                    .overlay(
//                        barColor
//                            .scaleEffect(x: 1)
//                    )
                    .foregroundStyle(barColor)
                    //.scaleEffect(x: 5)
                    .animation(.linear, value: value)
            }.cornerRadius(45.0)
        
        }
    }
}

struct DayProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        DayProgressBarView(value: 10)
    }
}
