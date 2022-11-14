//
//  DayProgressBarView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/13/22.
//

import SwiftUI

struct DayProgressBarView: View {
    
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear, value: value)
            }.cornerRadius(45.0)
        
        }
    }
}

struct DayProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        DayProgressBarView(value: .constant(10))
    }
}
