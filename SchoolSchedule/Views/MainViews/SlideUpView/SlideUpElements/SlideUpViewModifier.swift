//
//  SlideUpViewModifier.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/11/22.
//

import SwiftUI


struct SlideUpViewModifier: ViewModifier {
    
    @State private var dragging = false
    @GestureState private var dragTracker: CGSize = CGSize.zero
    @State private var position: CGFloat
    @State var isSlideUp: Bool = false
    private var startingOffsetValue: CGFloat
    private var endingOffsetValue: CGFloat
    private var backgroundColorValue: Color
    private var barColorValue: Color
    
    
    init(startingOffset: CGFloat, endingOffset: CGFloat, backgroundColor: Color, barColor: Color) {
        position = UIScreen.main.bounds.height - startingOffset
        self.startingOffsetValue = startingOffset
        self.endingOffsetValue = endingOffset
        self.backgroundColorValue = backgroundColor
        self.barColorValue = barColor
    }
    
    
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            
            ZStack(alignment: .top) {
                
                SlideUpCircle(isSlideUp: isSlideUp)
                    .offset(y: -20)
                    .zIndex(1)
                    .onTapGesture {
                        toggleSlidePosition()
                    }
                
                ZStack(alignment: .top) {
                    content.padding(.top, 30)
                }
                .background(backgroundColorValue)
                .cornerRadius(30)
                //.frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
            }
            
            
        }
        .offset(y: max(0, position + self.dragTracker.height))
        .animation(Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0), value: dragging)
        .gesture(DragGesture()
                    .updating($dragTracker) { drag, state, transaction in
                        state = drag.translation
                    }
                    .onChanged {_ in  dragging = true }
                    .onEnded(onDragEnded))
        
    }
    
    private func toggleSlidePosition() {
        let high = UIScreen.main.bounds.height - startingOffsetValue
        let low: CGFloat = endingOffsetValue
        
        if (isSlideUp) {
            withAnimation(Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0)) {
                position = high
                
            }
            
        }
        else {
            withAnimation(Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0)) {
                position = low
            }
        }
        withAnimation(.easeInOut(duration: 0.2)) {
            isSlideUp.toggle()
        }
        
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        dragging = false
        
        let high = UIScreen.main.bounds.height - startingOffsetValue
        let low: CGFloat = endingOffsetValue
        let dragDirection = drag.predictedEndLocation.y - drag.location.y
        //can also calculate drag offset to make it more rigid to shrink and expand
        
        if dragDirection > 0 {
            position = high
            withAnimation(.easeInOut(duration: 0.2)) {
                isSlideUp = false
            }
            
            
        } else {
            position = low
            withAnimation(.easeInOut(duration: 0.2)) {
                isSlideUp = true
            }
        }
    }
}

