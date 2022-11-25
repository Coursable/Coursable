//
//  SlideUp.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/11/22.
//

import SwiftUI

struct SlideUp<Content> : View where Content : View {

    var content: () -> Content
    private var startingOffsetValue: CGFloat
    private var endingOffsetValue: CGFloat
    private var backgroundColorValue: Color
    private var barColorValue: Color
    private var screenHeight: CGFloat
    
    public init(startingOffset: CGFloat = 500, endingOffset: CGFloat = 100, backgroundColor: Color = .white, barColor: Color = .secondary, screenHeight: CGFloat, content: @escaping () -> Content) {
        self.content = content
        self.startingOffsetValue = startingOffset
        self.endingOffsetValue = endingOffset
        self.backgroundColorValue = backgroundColor
        self.barColorValue = barColor
        self.screenHeight = screenHeight
        
    }
    
    public var body: some View {
        ModifiedContent(content: self.content(), modifier: SlideUpViewModifier(startingOffset: startingOffsetValue, endingOffset: endingOffsetValue, backgroundColor: backgroundColorValue, barColor: barColorValue, screenHeight: screenHeight))
    }
}


struct SlideUpViewModifier: ViewModifier {
    
    @State private var dragging = false
    @GestureState private var dragTracker: CGSize = CGSize.zero
    @State private var position: CGFloat
    @State var isSlideUp: Bool = false
    private var startingOffsetValue: CGFloat
    private var endingOffsetValue: CGFloat
    private var backgroundColorValue: Color
    private var barColorValue: Color
    private var screenHeight: CGFloat
    private var high: CGFloat
    private var low: CGFloat
    init(startingOffset: CGFloat, endingOffset: CGFloat, backgroundColor: Color, barColor: Color, screenHeight: CGFloat) {
        self.screenHeight = screenHeight
        self.startingOffsetValue = startingOffset
        self.endingOffsetValue = endingOffset
        self.backgroundColorValue = backgroundColor
        self.barColorValue = barColor
        self.high = screenHeight - startingOffsetValue
        self.low = endingOffsetValue
        
        position = high
    }
    
    
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
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
                }.frame(height: UIScreen.main.bounds.height + 100, alignment: .bottom) //extend the view so the user can't see the bottom of the view
                
                
            }
            .offset(y: position + self.dragTracker.height)
            .animation(Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0), value: dragging)
            .gesture(DragGesture()
                        .updating($dragTracker) { drag, state, transaction in
                            state = drag.translation
                        }
                        .onChanged {_ in  dragging = true }
                        .onEnded(onDragEnded))
        }
        
        
    }
    
    private func toggleSlidePosition() {
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



