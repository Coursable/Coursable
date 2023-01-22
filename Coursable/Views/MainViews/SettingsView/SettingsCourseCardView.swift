//
//  SettingsCourseCardView.swift
//  Coursable
//
//  Created by Ari Reitman on 11/28/22.
//

import SwiftUI

//struct SettingsCourseCardView: View {
//    @EnvironmentObject var periodViewModel: PeriodViewModel
//    var isEditingSubjects: Bool
//    var subject: Subject
//    @State var isLoading: Bool = false
//    @Binding var showAddSubjectSheet: Bool
//    @Binding var subjectToEdit: Subject?
//    @State var dragging = false
//    @State var position: CGFloat = 0
//    @GestureState var dragTracker: CGSize = CGSize.zero
//    @State var buttonOpacity = 0.0
//    @State var button1SizeMultiplier = 0.8
//    @State var button2SizeMultiplier = 0.8
//    
//    var body: some View {
//        ZStack {
//            HStack(spacing: 15) {
//                Group {
//                    Button {
//                        withAnimation(Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0)) {
//                            position = 0
//                        }
//                        showAddSubjectSheet.toggle()
//                        subjectToEdit = subject
//                        
//                        
//                    } label: {
//                        Circle()
//                            .frame(width: 50)
//                            .foregroundStyle(.green.gradient)
//                            .overlay {
//                                Image(systemName: "pencil")
//                                    .foregroundColor(.white)
//                                    .fontWeight(.bold)
//                            }
//                    }
//                    .scaleEffect(button1SizeMultiplier)
//                    
//                    Button {
//                        
//                        Task {
//                            await periodViewModel.removeIndividualSubjectData(subjectToRemove: subject)
//                        }
//                        withAnimation(Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0)) {
//                            position = 0
//                        }
//                    } label: {
//                        Circle()
//                            .frame(width: 50)
//                            .foregroundStyle(.red.gradient)
//                            .overlay {
//                                Image(systemName: "xmark")
//                                    .foregroundColor(.white)
//                                    .fontWeight(.bold)
//                            }
//                    }
//                    .scaleEffect(button2SizeMultiplier)
//                    
//                }
//                .animation(.easeInOut, value: button1SizeMultiplier)
//                .animation(.easeInOut, value: button2SizeMultiplier)
//                
//                
//                
//                Spacer()
//                
//                
//            }
//            .padding(.leading)
//            .opacity(buttonOpacity)
//            
//            VStack(alignment: .leading) {
//                
//                HStack {
//                    Circle()
//                        .fill(LinearGradient(colors: [Color(red: subject.colorGradientPrimary[0]/255, green: subject.colorGradientPrimary[1]/255, blue: subject.colorGradientPrimary[2]/255), Color(red: subject.colorGradientSecondary[0]/255, green: subject.colorGradientSecondary[1]/255, blue: subject.colorGradientSecondary[2]/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
//                        .frame(width: 50)
//                        .overlay {
//                            
//                            Text(subject.name.prefix(1).capitalized)
//                                .font(.title)
//                                .fontWeight(.bold)
//                                .foregroundColor(.white)
//                            
//                        }
//                    VStack(alignment: .leading) {
//                        Text(subject.name)
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                        HStack {
//                            Text("\(subject.teacher) - Room \(subject.roomNumber)")
//                            
//                        }
//                        .font(.subheadline)
//                        
//                        
//                    }
//                    .padding(.leading, 3)
//                    
//                    Spacer()
//                    
//                }
//            }
//            
//            .padding()
//            .foregroundColor(.white)
//            .background(Color("SecondaryBackground"))
//            .cornerRadius(15)
//            .offset(x: position + self.dragTracker.width)
//            .gesture(DragGesture()
//                .updating($dragTracker) { value, state, transaction in
//                    state = value.translation
//                    adjustButtonSizes()
//                }
//                .onChanged { _ in  dragging = true }
//                .onEnded(onEnd)
//            )
//            .animation(Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0), value: dragging)
//        }
//        
//    }
//    
//    
//    func onEnd(value: DragGesture.Value) {
//        
//        dragging = false
//        
//        let dragDirection = value.predictedEndLocation.x - value.location.x
//        
//        if dragDirection > 0 {
//            position = 150
//            button1SizeMultiplier = 1
//            button2SizeMultiplier = 1
//            withAnimation {
//                buttonOpacity = 1
//                
//                
//            }
//        }
//        else {
//            position = 0
//            button1SizeMultiplier = 0.8
//            button2SizeMultiplier = 0.8
//            withAnimation {
//                buttonOpacity = 0
//                
//            }
//            
//            
//        }
//        
//        
//    }
//    
//    func adjustButtonSizes() {
//        if dragTracker.width > 40 && position == 0 { // initial pull back
//            
//            button1SizeMultiplier = 1
//            
//        }
//        else if dragTracker.width < -109 && position != 0 { // slide leftwards back to original spot
//            
//            button1SizeMultiplier = 0.8
//            
//        }
//        else if dragTracker.width > -109 && position != 0 { // slide right from new spot
//            button1SizeMultiplier = 1
//        }
//        else {
//            
//            button1SizeMultiplier = 0.8
//            
//        }
//        
//        if dragTracker.width > 106 && position == 0 { // initial pull back
//            
//            button2SizeMultiplier = 1
//            
//        }
//        else if dragTracker.width < -40 && position != 0 { // slide leftwards back to original spot
//            
//            button2SizeMultiplier = 0.8
//            
//        }
//        else if dragTracker.width > -40 && position != 0 { // slide right from new spot
//            
//            button2SizeMultiplier = 1
//            
//        }
//        else {
//            
//            button2SizeMultiplier = 0.8
//            
//            
//        }
//        
//        if dragTracker.width < -140 {
//            buttonOpacity = 0
//        }
//        else {
//            
//            withAnimation {
//                buttonOpacity = 1
//            }
//            
//        }
//    }
//    
//}
//
//struct SettingsCourseCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsCourseCardView(isEditingSubjects: true, subject: Subject.LanguageArtsSubjectExample, showAddSubjectSheet: .constant(false), subjectToEdit: .constant(Subject.LanguageArtsSubjectExample))
//            .environmentObject(PeriodViewModel())
//    }
//}
