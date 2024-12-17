//////
//////  ArchiveView.swift
//////  sport
//////
//////  Created by pc on 02.10.24.
//////
//
//import SwiftUI
//import Combine
//import AudioToolbox
//
//protocol Session: Identifiable {
//    var id: UUID { get }
//    var name: String { get }
//    var description: String? { get }
//    var modules: [WorkoutModule] { get }
//}
//
//extension WorkoutModule: Session {
//    var modules: [WorkoutModule] {
//        return [self]
//    }
//}
//
//extension TrainingPlan: Session {}
//
//enum ExerciseState {
//    case completed
//    case active
//    case notStarted
//}
//
//class WorkoutSessionViewModel: ObservableObject {
//    @Published var isWorkoutFinished: Bool = false
//    @Published var isModuleFinished: Bool = false
//    @Published var currentModuleIndex: Int = 0
//    
//    let session: any Session
//    
//    @Published var moduleGroupedExercises: [[ExerciseSessionData]] = []
//    
//    class ExerciseSessionData: ObservableObject, Identifiable {
//        let id = UUID()
//        let exercise: Exercise
//        let indexInModule: Int
//        let totalExercisesInModule: Int
//        @Published var state: ExerciseState
//        @Published var currentTime: Int = 0
//        @Published var isBlinking: Bool = false
//        var timer: Timer?
//        
//        init(exercise: Exercise, indexInModule: Int, totalExercisesInModule: Int, state: ExerciseState) {
//            self.exercise = exercise
//            self.indexInModule = indexInModule
//            self.totalExercisesInModule = totalExercisesInModule
//            self.state = state
//        }
//        
//        func startTimer(onComplete: @escaping () -> Void) {
//            guard let duration = exercise.duration else { return }
//            currentTime = 0
//            isBlinking = true
//            AudioServicesPlaySystemSound(SystemSoundID(1054))
//            
//            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//                if self.currentTime < duration {
//                    self.currentTime += 1
//                } else {
//                    timer.invalidate()
//                    self.stopTimer()
//                    onComplete()
//                }
//            }
//            RunLoop.current.add(timer!, forMode: .common)
//        }
//        
//        func stopTimer() {
//            timer?.invalidate()
//            timer = nil
//            isBlinking = false
//        }
//    }
//    
//    init(session: any Session) {
//        self.session = session
//        self.moduleGroupedExercises = session.modules.enumerated().map { (moduleIndex, module) in
//            module.exercises.enumerated().map { (exerciseIndex, exercise) in
//                ExerciseSessionData(
//                    exercise: exercise,
//                    indexInModule: exerciseIndex,
//                    totalExercisesInModule: module.exercises.count,
//                    state: .notStarted)
//            }
//        }
//    }
//    
//    func startWorkout() {
//        startCurrentModule()
//    }
//    
//    func startCurrentModule() {
//        guard currentModuleIndex < moduleGroupedExercises.count else {
//            finishWorkout()
//            return
//        }
//        let exercises = moduleGroupedExercises[currentModuleIndex]
//        if let firstExercise = exercises.first, firstExercise.state == .notStarted {
//            firstExercise.state = .active
//            firstExercise.startTimer { [weak self] in
//                self?.handleExerciseCompletion()
//            }
//        }
//    }
//    
//    func moveToNextExercise() {
//        let exercises = moduleGroupedExercises[currentModuleIndex]
//        if let currentIndex = exercises.firstIndex(where: { $0.state == .active }) {
//            let currentExercise = exercises[currentIndex]
//            currentExercise.state = .completed
//            currentExercise.stopTimer()
//            
//            if currentIndex + 1 < exercises.count {
//                let nextExercise = exercises[currentIndex + 1]
//                nextExercise.state = .active
//                nextExercise.startTimer { [weak self] in
//                    self?.handleExerciseCompletion()
//                }
//            } else {
//                finishCurrentModule()
//            }
//        }
//    }
//    
//    func handleExerciseCompletion() {
//        DispatchQueue.main.async { [weak self] in
//            self?.moveToNextExercise()
//        }
//    }
//    
//    func finishCurrentModule() {
//        let exercises = moduleGroupedExercises[currentModuleIndex]
//
//        if let activeExercise = exercises.first(where: { $0.state == .active }) {
//            activeExercise.state = .completed
//            activeExercise.stopTimer()
//        }
//
//        if currentModuleIndex + 1 < moduleGroupedExercises.count {
//            isModuleFinished = true
//        } else {
//            finishWorkout()
//        }
//    }
//    
//    func proceedToNextModule() {
//        currentModuleIndex += 1
//        isModuleFinished = false
//
//        // Prepare the first exercise in the new module to be in notStarted state
//        let exercises = moduleGroupedExercises[currentModuleIndex]
//        if let firstExercise = exercises.first {
//            firstExercise.state = .notStarted
//        }
//    }
//    
//    func finishWorkout() {
//        moduleGroupedExercises.forEach { exercises in
//            exercises.forEach { $0.stopTimer() }
//        }
//        isWorkoutFinished = true
//        
//        let record = WorkoutRecord(session: session, date: Date())
//        WorkoutHistoryManager().saveWorkoutRecord(record)
//    }
//}
//
//struct WorkoutSessionView: View {
//    @ObservedObject var viewModel: WorkoutSessionViewModel
//    @Environment(\.presentationMode) var presentationMode
//    @State private var showFinishAlert = false
//    @State private var showModuleDoneView = false
//    
//    var body: some View {
//        List {
//            ForEach(viewModel.session.modules.indices, id: \.self) { moduleIndex in
//                let module = viewModel.session.modules[moduleIndex]
//                let exercises = viewModel.moduleGroupedExercises[moduleIndex]
//                Section(header: Text(module.name)) {
//                    ForEach(exercises) { exerciseData in
//                        ExerciseSessionCell(
//                            exerciseData: exerciseData,
//                            moduleIndex: moduleIndex,
//                            currentModuleIndex: viewModel.currentModuleIndex,
//                            onStart: {
//                                viewModel.startCurrentModule()
//                            },
//                            onNext: {
//                                viewModel.moveToNextExercise()
//                            },
//                            onFinish: {
//                                viewModel.finishCurrentModule()
//                            }
//                        )
//                    }
//                }
//            }
//        }
//        .navigationBarTitle(viewModel.session.name, displayMode: .inline)
//        .navigationBarItems(trailing: Button("Finish") {
//            showFinishAlert = true
//        })
//        .alert(isPresented: $showFinishAlert) {
//            Alert(
//                title: Text("Finish Workout"),
//                message: Text("Are you sure you want to cancel the session?"),
//                primaryButton: .destructive(Text("Yes")) {
//                    presentationMode.wrappedValue.dismiss()
//                },
//                secondaryButton: .cancel()
//            )
//        }
//        .interactiveDismissDisabled(true)
//        .sheet(isPresented: Binding(
//            get: { viewModel.isModuleFinished || viewModel.isWorkoutFinished },
//            set: { _ in }
//        )) {
//            let isTrainingPlanComplete = viewModel.currentModuleIndex + 1 >= viewModel.session.modules.count
//            let moduleName = viewModel.session.modules[viewModel.currentModuleIndex].name
//            let nextModuleName = isTrainingPlanComplete ? nil : viewModel.session.modules[viewModel.currentModuleIndex + 1].name
//            ModuleDoneView(
//                moduleName: moduleName,
//                isTrainingPlanComplete: isTrainingPlanComplete,
//                nextModuleName: nextModuleName,
//                onNextModule: { viewModel.proceedToNextModule() },
//                onFinish: {
//                    viewModel.finishWorkout()
//                    presentationMode.wrappedValue.dismiss()
//                }
//            )
//        }
//    }
//}
//
//struct ExerciseSessionCell: View {
//    @ObservedObject var exerciseData: WorkoutSessionViewModel.ExerciseSessionData
//    var moduleIndex: Int
//    var currentModuleIndex: Int
//    var onStart: () -> Void
//    var onNext: () -> Void
//    var onFinish: () -> Void
//
//    var body: some View {
//        HStack(alignment: .center) {
//            // Left: Checkmark Image
//            Image(systemName: "checkmark.circle.fill")
//                .resizable()
//                .frame(width: 40, height: 40)
//                .foregroundColor(exerciseData.state == .completed ? .green : .secondary)
//                .opacity(exerciseData.state == .active ? 1.0 : 0.5)
//
//            // Middle: Labels
//            VStack(alignment: .leading) {
//                HStack {
//                    Text(exerciseData.exercise.name)
//                        .font(.headline)
//                        .foregroundColor(.primary)
//
//                    if exerciseData.state == .active {
//                        // Blinking Red Indicator
//                        Image(systemName: "circle.fill")
//                            .resizable()
//                            .frame(width: 12, height: 12)
//                            .foregroundColor(.red)
//                            .opacity(exerciseData.isBlinking ? 1 : 0)
//                            .animation(
//                                Animation.linear(duration: 0.8)
//                                    .repeatForever(autoreverses: true),
//                                value: exerciseData.isBlinking
//                            )
//                    }
//                }
//
//                if let repetitions = exerciseData.exercise.repetitions {
//                    Text("Reps: \(repetitions)")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                }
//                if let weight = exerciseData.exercise.weight {
//                    Text("Weight: \(exerciseData.exercise.weight!, specifier: "%.1f") kg")
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                }
//            }
//            .padding(.leading, 8)
//            .opacity(exerciseData.state == .active ? 1.0 : 0.5)
//
//            Spacer()
//
//            // Right: Circular View and Button
//            VStack(alignment: .center, spacing: 12) {
//                // Circular View
//                if let duration = exerciseData.exercise.duration {
//                    CircularTimerView(
//                        progress: exerciseData.state == .active ? CGFloat(exerciseData.currentTime) / CGFloat(duration) : 0,
//                        timeLeft: timeString(from: duration - (exerciseData.state == .active ? exerciseData.currentTime : 0))
//                    )
//                    .frame(width: 60, height: 60)
//                    .opacity(exerciseData.state == .active ? 1.0 : 0.5)
//                } else {
//                    // No time set placeholder
//                    ZStack {
//                        Circle()
//                            .stroke(lineWidth: 6)
//                            .opacity(0.3)
//                            .foregroundColor(Color.blue)
//                        Text("No\nTime\nSet")
//                            .font(.caption2)
//                            .multilineTextAlignment(.center)
//                            .foregroundColor(.gray)
//                    }
//                    .frame(width: 60, height: 60)
//                    .opacity(exerciseData.state == .active ? 1.0 : 0.5)
//                }
//
//                // Button
//                if shouldShowButton() {
//                    Button(action: {
//                        handleButtonAction()
//                    }) {
//                        Text(buttonTitle())
//                            .font(.headline)
//                            .padding(4)
//                            .frame(maxWidth: .infinity)
//                            .background(buttonBackgroundColor())
//                            .foregroundColor(.white)
//                            .cornerRadius(8)
//                    }
//                }
//            }
//            .frame(width: 80)
//        }
//        .padding(.vertical, 8)
//    }
//
//    func shouldShowButton() -> Bool {
//        if moduleIndex != currentModuleIndex {
//            return false
//        }
//
//        if exerciseData.state == .active {
//            return true
//        } else if exerciseData.state == .notStarted && exerciseData.indexInModule == 0 {
//            return true
//        }
//        return false
//    }
//
//    func handleButtonAction() {
//        if exerciseData.state == .active {
//            exerciseData.stopTimer()
//            if exerciseData.indexInModule == exerciseData.totalExercisesInModule - 1 {
//                onFinish()
//            } else {
//                onNext()
//            }
//        } else if exerciseData.state == .notStarted && exerciseData.indexInModule == 0 {
//            onStart()
//        }
//    }
//
//    func buttonTitle() -> String {
//        if exerciseData.state == .active {
//            return exerciseData.indexInModule == exerciseData.totalExercisesInModule - 1 ? "Finish" : "Next"
//        } else if exerciseData.state == .notStarted && exerciseData.indexInModule == 0 {
//            return "Start"
//        }
//        return ""
//    }
//
//    func buttonBackgroundColor() -> Color {
//        if exerciseData.state == .active {
//            return exerciseData.indexInModule == exerciseData.totalExercisesInModule - 1 ? Color.red : Color.accentColor
//        } else {
//            return Color.green
//        }
//    }
//
//    func timeString(from seconds: Int) -> String {
//        let minutes = seconds / 60
//        let remainingSeconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, remainingSeconds)
//    }
//}
//
//struct CircularTimerView: View {
//    var progress: CGFloat
//    var timeLeft: String
//
//    var body: some View {
//        ZStack {
//            Circle()
//                .stroke(lineWidth: 6)
//                .opacity(0.3)
//                .foregroundColor(Color.blue)
//
//            Circle()
//                .trim(from: 0.0, to: progress)
//                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
//                .foregroundColor(Color.blue)
//                .rotationEffect(Angle(degrees: -90))
//
//            Text(timeLeft)
//                .font(.caption)
//                .fontWeight(.bold)
//        }
//    }
//}
//struct ModuleDoneView: View {
//    let moduleName: String
//    let isTrainingPlanComplete: Bool
//    let nextModuleName: String?
//    let onNextModule: () -> Void
//    let onFinish: () -> Void
//    
//    // Add these properties to track workout stats
//    let duration: TimeInterval = 1110 // 18:30 in seconds (for example)
//    let exerciseCount: Int = 12
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            Image(isTrainingPlanComplete ? "plan_complete_bg" : "workout_complete_bg")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(minHeight: 100, maxHeight: .infinity)
//                .clipped()
//            
//            VStack(spacing: 16) {
//                Text(isTrainingPlanComplete ? "Congratulations!" : "Workout Completed!")
//                    .font(.system(size: 34, weight: .bold))
//                    .foregroundColor(.white)
//                    .lineLimit(1)
//                
//                Text("Training Plan Complete")
//                    .font(.system(size: 20))
//                    .foregroundColor(.secondary)
//                    .padding(.bottom, 16)
//            }
//            
//            VStack(spacing: 16) {
//                if isTrainingPlanComplete {
//                    HStack(spacing: 20) {
//                        StatBox(value: formatTime(duration), label: "minutes")
//                        StatBox(value: "\(exerciseCount)", label: "exercises")
//                    }
//                    .padding(.bottom, 24)
//                } else {
//                    WorkoutInfoBox(title: "Previous Workout:", workoutName: moduleName)
//                    if let nextWorkout = nextModuleName {
//                        WorkoutInfoBox(title: "Next Workout:", workoutName: nextWorkout)
//                    }
//                }
//                
//                VStack(spacing: 16) {
//                    Button(action: isTrainingPlanComplete ? onFinish : onNextModule) {
//                        Text(isTrainingPlanComplete ? "Finish" : "Next")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 50)
//                            .background(Color.red)
//                            .cornerRadius(10)
//                    }
//                    
//                    Text("This session has been saved to your history")
//                        .font(.system(size: 14))
//                        .foregroundColor(.white)
//                }
//            }
//            .padding(.horizontal, 32)
//            .padding(.vertical, 16)
//        }
//        .background(Color.black.edgesIgnoringSafeArea(.all)) // Add background color for contrast
//    }
//    
//    private func formatTime(_ seconds: TimeInterval) -> String {
//        let minutes = Int(seconds) / 60
//        let remainingSeconds = Int(seconds) % 60
//        return "\(minutes):\(String(format: "%02d", remainingSeconds))"
//    }
//}
//
//struct StatBox: View {
//    let value: String
//    let label: String
//    
//    var body: some View {
//        VStack {
//            Text(value)
//                .font(.system(size: 34, weight: .bold))
//                .foregroundColor(.white)
//            Text(label)
//                .font(.system(size: 16))
//                .foregroundColor(.secondary)
//        }
//        .frame(minWidth: 140, maxWidth: .infinity)
//        .padding(.vertical, 20)
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(Color.cyan, lineWidth: 1)
//        )
//    }
//}
//
//struct WorkoutInfoBox: View {
//    let title: String
//    let workoutName: String
//    
//    var body: some View {
//        VStack(spacing: 8) {
//            Text(title)
//                .font(.system(size: 16))
//                .foregroundColor(.white)
//            Text(workoutName)
//                .font(.system(size: 16))
//                .foregroundColor(.red)
//        }
//        .frame(maxWidth: .infinity)
//        .padding(.vertical, 16)
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(Color.cyan, lineWidth: 1)
//        )
//    }
//}
//
//#Preview {
//    ModuleDoneView(
//        moduleName: "moduleName",
//        isTrainingPlanComplete: true,
//        nextModuleName: "nextModuleName",
//        onNextModule: {},
//        onFinish: {})
//}
