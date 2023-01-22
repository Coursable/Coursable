//
//  SettingsView.swift
//  Coursable
//
//  Created by Ari Reitman on 11/28/22.
//

import SwiftUI
import FirebaseFirestore

struct SettingsView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    @EnvironmentObject var signInViewModel: SignInViewModel
    @Binding var showSettingsSheet: Bool
    @State var isLoading: Bool = false
    @State var showAddSubjectSheet: Bool = false
    @State var showScheduleInfoSheet: Bool = false
    @State var isEditingSubjects: Bool = false
    @State var isEditingSchedule: Bool = false
    
    @State var subjectToEdit: Subject?
    @State var subjectFolded: Bool = true
    
    @State var weekdaySelected: Int = 2
    @Namespace var animation
    
    var body: some View {
        ZStack {
            VStack {
                
                ZStack {
                    HStack {
                        Spacer()
                        Text("Settings")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                }
                .overlay(
                    Button {
                        showSettingsSheet.toggle()
                    } label: {
                        Image(systemName: "chevron.down")
                            .font(.title2)
                    }
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(.top, 5)
                        .padding(.trailing, 30)
                    
                    ,alignment: .topTrailing
                )
                .padding(.bottom,8)
                .padding(.top,8)
                
                Form {
                    Group {
                        Section {
                            ForEach(Array(periodViewModel.usersSubjects.enumerated()), id: \.element) { index, subject in
                                if !subjectFolded || index + 1 <= 3 {
                                    SettingsCourseCardView(isEditingSubjects: isEditingSubjects, subject: subject, showAddSubjectSheet: $showAddSubjectSheet, subjectToEdit: $subjectToEdit)

                                }
                            }
                        }
                        header: {
                            HStack {
                                Text("Subjects (\(periodViewModel.usersSubjects.count))")
                                    .foregroundColor(.white)
                                
                                Spacer()
                                Button {
                                    showAddSubjectSheet = true
                                    
                                } label: {
                                    Text("Add")
                                        .textCase(.none)
                                        .font(.footnote)
                                        .padding([.leading,.trailing], 10)
                                        .padding([.top, .bottom], 4)
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                        .background {
                                            
                                            RoundedRectangle(cornerRadius: 16)
                                                .foregroundStyle(.green.gradient)
                                            
                                        }
                                }
                                

                                if periodViewModel.usersSubjects.count > 3 {
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            subjectFolded.toggle()
                                        }
                                        
                                    } label: {
                                        Image(systemName: "chevron.down")
                                            .rotationEffect(.degrees(subjectFolded ? 180 : 0))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(.leading)
                                        
                                    }
                                }
                
                            }
                    }
                        
                        Section {
                            
                            SettingsDaySelectionView(isEditingSchedule: $isEditingSchedule, weekdaySelected: $weekdaySelected)
                            
                            
                            if let dayModel = periodViewModel.usersFullSchedule.first { $0.day == weekdaySelected } {
                                ForEach(dayModel.periods) { period in
                                    SettingsScheduleCardView(period: period)
                                }
                                
                            }
                        }
                        
                        header: {
                            HStack {
                                Text("Schedule")
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                

                                Button {
                                    
                                    
                                } label: {
                                    Text("Add")
                                        .textCase(.none)
                                        .font(.footnote)
                                        .padding([.leading,.trailing], 10)
                                        .padding([.top, .bottom], 4)
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                        .background {
                                            RoundedRectangle(cornerRadius: 16)
                                                .foregroundStyle(.green.gradient)
                                        }
                                }
                                    
                                    
                                    
                                
                                
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .listRowBackground(Color(UIColor.clear))
                    .listRowInsets(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 10)
                    .listRowSeparator(.hidden)
                    

                    
                    
                    
                    Section {
                        Button {
                            signInViewModel.signOut()
                        } label: {
                            Text("Sign Out")
                        }
                        .listRowBackground(Color("SecondaryBackground"))
                        
                        
                    }
                    
                }
                
                
                .scrollContentBackground(.hidden)
                
                
                Spacer()
            }
            
            
            if isLoading {
                CustomLoading()
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color("Background")
                .ignoresSafeArea()
        }
        .sheet(isPresented: $showAddSubjectSheet, content: {
            
            AddSubjectView(showAddSubjectSheet: $showAddSubjectSheet, subjectToEdit: $subjectToEdit)
        })
        .sheet(isPresented: $showScheduleInfoSheet, content: {
            //SettingsScheduleInfoView(dayModel: )
        })
        .onAppear {
            
            Task {
                withAnimation {
                    isLoading = true
                }
                
                await periodViewModel.retrieveSubjectData()
                
                //periodViewModel.setSubjectData()
                
                
                withAnimation {
                    isLoading = false
                }
            }
            
        }
        
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettingsSheet: .constant(false))
            .environmentObject(PeriodViewModel())
            .environmentObject(SignInViewModel())
    }
}

private struct SettingsDaySelectionView: View {
    
    @Binding var isEditingSchedule: Bool
    @Binding var weekdaySelected: Int
    
    var body: some View {
        HStack(spacing: 1) {
            Spacer()
            ForEach(1...5, id: \.self) {day in
                Button {
                    withAnimation {
                        isEditingSchedule = false
                        weekdaySelected = day
                    }
                } label: {
                    VStack {
                        switch(day) {
                        case 1:
                            Text("Mon")
                        case 2:
                            Text("Tue")
                        case 3:
                            Text("Wed")
                        case 4:
                            Text("Thu")
                        default:
                            Text("Fri")
                        }
                        
                        if weekdaySelected == day {
                            Circle()
                                .frame(width: 8)
                        }
                    }
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .frame(width: 50, height: weekdaySelected == day ? 90 : 50)
                    .background(
                        ZStack {
                            Capsule()
                                .fill(weekdaySelected == day ? Color.blue :  Color("SecondaryBackground"))
                            //
                        }
                    )
                    
                    
                }
                Spacer()
            }
        }
    }
}

private struct SettingsCourseCardView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    var isEditingSubjects: Bool
    var subject: Subject
    @State var isLoading: Bool = false
    @Binding var showAddSubjectSheet: Bool
    @Binding var subjectToEdit: Subject?
    @State var dragging = false
    @State var position: CGFloat = 0
    @GestureState var dragTracker: CGSize = CGSize.zero
    @State var buttonOpacity = 0.0
    @State var button1SizeMultiplier = 0.8
    @State var button2SizeMultiplier = 0.8
    
    var body: some View {
        ZStack {
            HStack(spacing: 15) {
                Group {
                    Button {
                        withAnimation(Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0)) {
                            position = 0
                        }
                        showAddSubjectSheet.toggle()
                        subjectToEdit = subject
                        
                        
                    } label: {
                        Circle()
                            .frame(width: 50)
                            .foregroundStyle(.green.gradient)
                            .overlay {
                                Image(systemName: "pencil")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                    }
                    .scaleEffect(button1SizeMultiplier)
                    
                    Button {
                        
                        Task {
                            await periodViewModel.removeIndividualSubjectData(subjectToRemove: subject)
                        }
                        withAnimation(Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0)) {
                            position = 0
                        }
                    } label: {
                        Circle()
                            .frame(width: 50)
                            .foregroundStyle(.red.gradient)
                            .overlay {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                    }
                    .scaleEffect(button2SizeMultiplier)
                    
                }
                .animation(.easeInOut, value: button1SizeMultiplier)
                .animation(.easeInOut, value: button2SizeMultiplier)
                
                
                
                Spacer()
                
                
            }
            .padding(.leading)
            .opacity(buttonOpacity)
            
            VStack(alignment: .leading) {
                
                HStack {
                    Circle()
                        .fill(LinearGradient(colors: [Color(red: subject.colorGradientPrimary[0]/255, green: subject.colorGradientPrimary[1]/255, blue: subject.colorGradientPrimary[2]/255), Color(red: subject.colorGradientSecondary[0]/255, green: subject.colorGradientSecondary[1]/255, blue: subject.colorGradientSecondary[2]/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 50)
                        .overlay {
                            
                            Text(subject.name.prefix(1).capitalized)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                        }
                    VStack(alignment: .leading) {
                        Text(subject.name)
                            .font(.title3)
                            .fontWeight(.semibold)
                        HStack {
                            Text("\(subject.teacher) - Room \(subject.roomNumber)")
                            
                        }
                        .font(.subheadline)
                        
                        
                    }
                    .padding(.leading, 3)
                    
                    Spacer()
                    
                }
            }
            
            .padding()
            .foregroundColor(.white)
            .background(Color("SecondaryBackground"))
            .cornerRadius(15)
            .offset(x: position + self.dragTracker.width)
            .gesture(DragGesture()
                .updating($dragTracker) { value, state, transaction in
                    state = value.translation
                    adjustButtonSizes()
                }
                .onChanged { _ in  dragging = true }
                .onEnded(onEnd)
            )
            .animation(Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0), value: dragging)
        }
        
    }
    
    
    func onEnd(value: DragGesture.Value) {
        
        dragging = false
        
        let dragDirection = value.predictedEndLocation.x - value.location.x
        
        if dragDirection > 0 {
            position = 150
            button1SizeMultiplier = 1
            button2SizeMultiplier = 1
            withAnimation {
                buttonOpacity = 1
                
                
            }
        }
        else {
            position = 0
            button1SizeMultiplier = 0.8
            button2SizeMultiplier = 0.8
            withAnimation {
                buttonOpacity = 0
                
            }
            
            
        }
        
        
    }
    
    func adjustButtonSizes() {
        if dragTracker.width > 40 && position == 0 { // initial pull back
            
            button1SizeMultiplier = 1
            
        }
        else if dragTracker.width < -109 && position != 0 { // slide leftwards back to original spot
            
            button1SizeMultiplier = 0.8
            
        }
        else if dragTracker.width > -109 && position != 0 { // slide right from new spot
            button1SizeMultiplier = 1
        }
        else {
            
            button1SizeMultiplier = 0.8
            
        }
        
        if dragTracker.width > 106 && position == 0 { // initial pull back
            
            button2SizeMultiplier = 1
            
        }
        else if dragTracker.width < -40 && position != 0 { // slide leftwards back to original spot
            
            button2SizeMultiplier = 0.8
            
        }
        else if dragTracker.width > -40 && position != 0 { // slide right from new spot
            
            button2SizeMultiplier = 1
            
        }
        else {
            
            button2SizeMultiplier = 0.8
            
            
        }
        
        if dragTracker.width < -140 {
            buttonOpacity = 0
        }
        else {
            
            withAnimation {
                buttonOpacity = 1
            }
            
        }
    }
    
}

private struct SettingsScheduleInfoIconView: View {
    
    var period: PeriodModel
    
    var body: some View {
        Circle()
            .fill(LinearGradient(colors: [Color(red: period.subject.colorGradientPrimary[0]/255, green: period.subject.colorGradientPrimary[1]/255, blue: period.subject.colorGradientPrimary[2]/255), Color(red: period.subject.colorGradientSecondary[0]/255, green: period.subject.colorGradientSecondary[1]/255, blue: period.subject.colorGradientSecondary[2]/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 50)
            .overlay {
                Text(String(period.periodNumber))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
            }
    }
}

private struct SettingsScheduleCardView: View {
    @State var dragging = false
    @State var position: CGFloat = 0
    @GestureState var dragTracker: CGSize = CGSize.zero
    @State var buttonOpacity = 0.0
    @State var button1SizeMultiplier = 0.8
    @State var button2SizeMultiplier = 0.8
    
    
    var period: PeriodModel
    
    var body: some View {
        ZStack {
            HStack(spacing: 15) {
                Group {
                    Button {
                        withAnimation(Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0)) {
                            position = 0
                        }
                        
                        
                    } label: {
                        Circle()
                            .frame(width: 50)
                            .foregroundStyle(.green.gradient)
                            .overlay {
                                Image(systemName: "pencil")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                    }
                    .scaleEffect(button1SizeMultiplier)
                    
                    Button {

                        withAnimation(Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0)) {
                            position = 0
                        }
                    } label: {
                        Circle()
                            .frame(width: 50)
                            .foregroundStyle(.red.gradient)
                            .overlay {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                    }
                    .scaleEffect(button2SizeMultiplier)
                }
                .animation(.easeInOut, value: button1SizeMultiplier)
                .animation(.easeInOut, value: button2SizeMultiplier)
                
                
                
                
                Spacer()
                
                
            }
            .padding(.leading)
            .opacity(buttonOpacity)
            
            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    SettingsScheduleInfoIconView(period: period)
                    
                    VStack(alignment: .leading) {
                        Text("Period \(period.periodNumber)")
                            .font(.title3)
                            .fontWeight(.semibold)
                        HStack {
                            //Image(systemName: "book")
                            Text("\(period.subject.name) - \(DateFormatter.localizedString(from: period.startTimeParsed, dateStyle: .none, timeStyle: .short))-\(DateFormatter.localizedString(from: period.endTimeParsed, dateStyle: .none, timeStyle: .short))")
                            Spacer()
                        }
                        .font(.subheadline)
                        .fontWeight(.regular)
                    }
                    .padding(.leading, 3)
                    
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color("SecondaryBackground"))
            .cornerRadius(15)
            .offset(x: position + self.dragTracker.width)
            .gesture(DragGesture()
                .updating($dragTracker) { value, state, transaction in
                    state = value.translation
                    adjustButtonSizes()

                }
                .onChanged { _ in  dragging = true }
                .onEnded(onEnd)

            )
        .animation(Animation.interpolatingSpring(stiffness: 250.0, damping: 40.0, initialVelocity: 5.0), value: dragging)
        }
    }
        
    
    
    func onEnd(value: DragGesture.Value) {
        
        dragging = false
        
        let dragDirection = value.predictedEndLocation.x - value.location.x
        
        if dragDirection > 0 {
            position = 150
            button1SizeMultiplier = 1
            button2SizeMultiplier = 1
            withAnimation {
                buttonOpacity = 1
                
                
            }
        }
        else {
            position = 0
            button1SizeMultiplier = 0.8
            button2SizeMultiplier = 0.8
            withAnimation {
                buttonOpacity = 0
                
            }
            
            
        }
        
        
    }
    
    func adjustButtonSizes() {
        if dragTracker.width > 40 && position == 0 { // initial pull back
            
            button1SizeMultiplier = 1
            
        }
        else if dragTracker.width < -109 && position != 0 { // slide leftwards back to original spot
            
            button1SizeMultiplier = 0.8
            
        }
        else if dragTracker.width > -109 && position != 0 { // slide right from new spot
            button1SizeMultiplier = 1
        }
        else {
            
            button1SizeMultiplier = 0.8
            
        }
        
        if dragTracker.width > 106 && position == 0 { // initial pull back
            
            button2SizeMultiplier = 1
            
        }
        else if dragTracker.width < -40 && position != 0 { // slide leftwards back to original spot
            
            button2SizeMultiplier = 0.8
            
        }
        else if dragTracker.width > -40 && position != 0 { // slide right from new spot
            
            button2SizeMultiplier = 1
            
        }
        else {
            
            button2SizeMultiplier = 0.8
            
            
        }
        
        if dragTracker.width < -140 {
            buttonOpacity = 0
        }
        else {
            
            withAnimation {
                buttonOpacity = 1
            }
            
        }
    }
}
