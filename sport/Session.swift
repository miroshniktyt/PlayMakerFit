//
//  WorkoutSession.swift
//  sport
//
//  Created by pc on 09.10.24.
//

import SwiftUI
import Combine
import AudioToolbox

protocol Session: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var description: String? { get }
    var modules: [WorkoutModule] { get }
}

extension WorkoutModule: Session {
    var modules: [WorkoutModule] {
        return [self]
    }
}

extension TrainingPlan: Session {}

enum ExerciseState {
    case completed
    case active
    case notStarted
}

class WorkoutSessionViewModel: ObservableObject {
    @Published var isWorkoutFinished: Bool = false
    @Published var isModuleFinished: Bool = false
    @Published var currentModuleIndex: Int = 0
    @Published var activeExerciseId: UUID?
    @Published var isPaused: Bool = false
    @Published var isBlinking: Bool = false
    
    let session: any Session
    @Published var moduleGroupedExercises: [[ExerciseSessionData]] = []
    
    class ExerciseSessionData: ObservableObject, Identifiable {
        let id = UUID()
        let exercise: Exercise
        let indexInModule: Int
        let totalExercisesInModule: Int
        @Published var progress: Int = 0
        var timer: Timer?
        
        init(exercise: Exercise, indexInModule: Int, totalExercisesInModule: Int) {
            self.exercise = exercise
            self.indexInModule = indexInModule
            self.totalExercisesInModule = totalExercisesInModule
        }
        
        func startTimer() {
            guard let duration = exercise.duration else { return }
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                if self.progress < duration {
                    self.progress += 1
                } else {
                    self.stopTimer()
                }
            }
            RunLoop.current.add(timer!, forMode: .common)
        }
        
        func stopTimer() {
            timer?.invalidate()
            timer = nil
        }
    }
    
    init(session: any Session) {
        self.session = session
        self.moduleGroupedExercises = session.modules.enumerated().map { (moduleIndex, module) in
            module.exercises.enumerated().map { (exerciseIndex, exercise) in
                ExerciseSessionData(
                    exercise: exercise,
                    indexInModule: exerciseIndex,
                    totalExercisesInModule: module.exercises.count)
            }
        }
    }
    
    func getExerciseState(_ exerciseData: ExerciseSessionData) -> ExerciseState {
        if let moduleIndex = moduleGroupedExercises.firstIndex(where: { exercises in
            exercises.contains { $0.id == exerciseData.id }
        }) {
            if moduleIndex < currentModuleIndex {
                return .completed
            }
        }
        
        if activeExerciseId == exerciseData.id {
            return .active
        }
        
        let moduleExercises = moduleGroupedExercises[currentModuleIndex]
        if let activeIndex = moduleExercises.firstIndex(where: { $0.id == activeExerciseId }),
           let exerciseIndex = moduleExercises.firstIndex(where: { $0.id == exerciseData.id }) {
            return exerciseIndex < activeIndex ? .completed : .notStarted
        }
        
        return .notStarted
    }
    
    func activateExercise(_ exerciseData: ExerciseSessionData) {
        // Stop any existing timers and reset progress
        if let currentExercise = getCurrentExercise() {
            currentExercise.stopTimer()
            currentExercise.progress = 0
        }
        
        if let moduleIndex = moduleGroupedExercises.firstIndex(where: { exercises in
            exercises.contains { $0.id == exerciseData.id }
        }) {
            currentModuleIndex = moduleIndex
        }
        
        // Reset progress of the exercise we're activating
        exerciseData.progress = 0
        activeExerciseId = exerciseData.id
        isPaused = false
        
        // Start timer if exercise has duration
        exerciseData.startTimer()
    }
    
    func togglePause() {
        isPaused.toggle()
        if let exercise = getCurrentExercise() {
            if isPaused {
                exercise.stopTimer()
            } else {
                exercise.startTimer()
            }
        }
    }
    
    func getCurrentExercise() -> ExerciseSessionData? {
        guard let activeId = activeExerciseId else { return nil }
        return moduleGroupedExercises.flatMap({ $0 }).first(where: { $0.id == activeId })
    }
    
    func completeActiveExercise() {
        if let exercise = getCurrentExercise() {
            exercise.stopTimer()
            exercise.progress = 0
        }
        
        guard let currentExerciseId = activeExerciseId,
              let currentModuleExercises = moduleGroupedExercises[safe: currentModuleIndex],
              let currentIndex = currentModuleExercises.firstIndex(where: { $0.id == currentExerciseId }) else {
            return
        }
        
        // Check if this is the last exercise in the last module
        let isLastModule = currentModuleIndex == moduleGroupedExercises.count - 1
        let isLastExerciseInModule = currentIndex + 1 == currentModuleExercises.count
        
        if isLastModule && isLastExerciseInModule {
            finishWorkout()
        } else if isLastExerciseInModule {
            finishCurrentModule()
        } else {
            let nextExercise = currentModuleExercises[currentIndex + 1]
            activeExerciseId = nextExercise.id
            nextExercise.progress = 0
            nextExercise.startTimer()
        }
    }
    
    func finishCurrentModule() {
        if currentModuleIndex >= moduleGroupedExercises.count - 1 {
            finishWorkout()
        } else {
            isModuleFinished = true
        }
    }
    
    func proceedToNextModule() {
        currentModuleIndex += 1
        isModuleFinished = false
        
        if let firstExercise = moduleGroupedExercises[currentModuleIndex].first {
            activeExerciseId = firstExercise.id
        }
    }
    
    func finishWorkout() {
        // Stop all timers
        moduleGroupedExercises.forEach { exercises in
            exercises.forEach { $0.stopTimer() }
        }
        activeExerciseId = nil
        isWorkoutFinished = true
        
        let record = WorkoutRecord(session: session, date: Date())
        WorkoutHistoryManager().saveWorkoutRecord(record)
    }
    
    func completeModule() {
        if let currentExercises = moduleGroupedExercises[safe: currentModuleIndex] {
            for exercise in currentExercises {
                if getExerciseState(exercise) != .completed {
                    activeExerciseId = exercise.id
                    completeActiveExercise()
                }
            }
        }
        
        currentModuleIndex += 1
        activeExerciseId = nil
        isModuleFinished = false
    }
    
    var totalDuration: TimeInterval {
        let allExercises = moduleGroupedExercises.flatMap { $0 }
        return TimeInterval(allExercises.reduce(0) { $0 + ($1.exercise.duration ?? 0) })
    }
    
    var totalExerciseCount: Int {
        moduleGroupedExercises.flatMap { $0 }.count
    }
}

struct WorkoutSessionView: View {
    @ObservedObject var viewModel: WorkoutSessionViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showQuitAlert = false
    
    var body: some View {
        List {
            ForEach(viewModel.session.modules.indices, id: \.self) { moduleIndex in
                let module = viewModel.session.modules[moduleIndex]
                let exercises = viewModel.moduleGroupedExercises[moduleIndex]
                
                Section(header: Text(module.name)) {
                    ForEach(exercises) { exerciseData in
                        let state = viewModel.getExerciseState(exerciseData)
                        
                        ExerciseSessionCell(
                            exerciseData: exerciseData,
                            viewModel: viewModel,
                            state: state,
                            onActivate: {
                                viewModel.activateExercise(exerciseData)
                            },
                            onComplete: {
                                viewModel.completeActiveExercise()
                            },
                            onBack: state == .active ? {
                                if let currentExercises = viewModel.moduleGroupedExercises[safe: moduleIndex],
                                   let currentIndex = currentExercises.firstIndex(where: { $0.id == exerciseData.id }) {
                                    if currentIndex > 0 {
                                        // Go to previous exercise in current module
                                        viewModel.activateExercise(currentExercises[currentIndex - 1])
                                    } else if moduleIndex > 0 {
                                        // Go to last exercise of previous module
                                        let previousModuleExercises = viewModel.moduleGroupedExercises[moduleIndex - 1]
                                        if let lastExercise = previousModuleExercises.last {
                                            viewModel.activateExercise(lastExercise)
                                        }
                                    }
                                }
                            } : nil
                        )
                    }
                }
            }
        }
        .navigationBarTitle(viewModel.session.name, displayMode: .inline)
        .navigationBarItems(trailing: Button("Quit") {
            showQuitAlert = true
        })
        .alert(isPresented: $showQuitAlert) {
            Alert(
                title: Text("Quit Workout"),
                message: Text("Are you sure you want to quit this workout session?"),
                primaryButton: .destructive(Text("Quit")) {
                    presentationMode.wrappedValue.dismiss()
                },
                secondaryButton: .cancel()
            )
        }
        .sheet(isPresented: $viewModel.isModuleFinished) {
            let isTrainingPlanComplete = viewModel.currentModuleIndex >= viewModel.moduleGroupedExercises.count - 1
            let moduleName = viewModel.session.modules[viewModel.currentModuleIndex].name
            let nextModuleName = isTrainingPlanComplete ? nil : viewModel.session.modules[viewModel.currentModuleIndex + 1].name
            
            ModuleDoneView(
                moduleName: moduleName,
                isTrainingPlanComplete: isTrainingPlanComplete,
                nextModuleName: nextModuleName,
                onNextModule: { viewModel.completeModule() },
                onFinish: {
                    viewModel.finishWorkout()
                    presentationMode.wrappedValue.dismiss()
                },
                duration: viewModel.totalDuration,
                exerciseCount: viewModel.totalExerciseCount
            )
        }
        .sheet(isPresented: $viewModel.isWorkoutFinished) {
            ModuleDoneView(
                moduleName: viewModel.session.name,
                isTrainingPlanComplete: true,
                nextModuleName: nil,
                onNextModule: { },
                onFinish: {
                    presentationMode.wrappedValue.dismiss()
                },
                duration: viewModel.totalDuration,
                exerciseCount: viewModel.totalExerciseCount
            )
        }
        .interactiveDismissDisabled(true)
        .gesture(
            DragGesture()
                .onEnded { gesture in
                    if gesture.translation.height > 50 {
                        showQuitAlert = true
                    }
                }
        )
    }
}

struct ExerciseSessionCell: View {
    @ObservedObject var exerciseData: WorkoutSessionViewModel.ExerciseSessionData
    @ObservedObject var viewModel: WorkoutSessionViewModel
    let state: ExerciseState
    var onActivate: () -> Void
    var onComplete: () -> Void
    var onBack: (() -> Void)?
    
    @State private var isBlinking = false
    @State private var isPaused = false
    
    var body: some View {
        VStack {
            if state == .active {
                activeExerciseView
            } else {
                inactiveExerciseView
            }
        }
        .padding(.vertical, state == .active ? 16 : 8)
        .cornerRadius(12)
    }
    
    private var inactiveExerciseView: some View {
        HStack {
            CircularTimerView(
                progress: 0,
                timeLeft: exerciseData.exercise.duration.map { "\($0)s" } ?? "No\nTime\nSet",
                color: Color(.systemCyan)
            )
            .frame(width: 60, height: 60)
            .opacity(state == .completed ? 0.5 : 1.0)
            .padding(.leading, 3)
            
            VStack(alignment: .leading) {
                Text(exerciseData.exercise.name)
                    .font(.headline)
                
                if let repetitions = exerciseData.exercise.repetitions {
                    Text("\(repetitions) reps")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let weight = exerciseData.exercise.weight {
                    Text("\(weight, specifier: "%.1f") kg")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.leading, 8)
            
            Spacer()
            
            if state == .completed {
                Text("Done")
                    .foregroundColor(Color(.systemCyan))
            } else if state == .notStarted {
                Button("Start") {
                    onActivate()
                }
                .buttonStyle(CustomBorderedButtonStyle(filled: true))
            }
        }
        .opacity(state == .completed ? 0.5 : 1.0)
    }
    
    private var activeExerciseView: some View {
        VStack(spacing: 16) {
            HStack {
                Text(exerciseData.exercise.name)
                    .font(.title2)
                    .bold()
                
                if !isPaused {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.red)
                        .opacity(isBlinking ? 1 : 0)
                        .animation(Animation.easeInOut(duration: 1).repeatForever(), value: isBlinking)
                        .onAppear { isBlinking = true }
                        .onDisappear { isBlinking = false }
                }
            }
            
            if let repetitions = exerciseData.exercise.repetitions {
                Text("\(repetitions) reps")
                    .font(.headline)
            }
            
            if let weight = exerciseData.exercise.weight {
                Text("\(weight, specifier: "%.1f") kg")
                    .font(.headline)
            }
            
            // Timer circle (if exercise has duration)
            if let duration = exerciseData.exercise.duration {
                CircularTimerView(
                    progress: CGFloat(exerciseData.progress) / CGFloat(duration),
                    timeLeft: formatTime(duration - exerciseData.progress),
                    isLarge: true,
                    color: Color(.systemCyan),
                    lineWidth: 12
                )
                .frame(width: 120, height: 120)
                .padding(.bottom, 8)
            }
            
            // Control buttons
            HStack(spacing: 16) {
                Button(action: { onBack?() }) {
                    Text("Prev")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(CustomBorderedButtonStyle())
                
                if exerciseData.exercise.duration != nil {
                    Button(action: {
                        isPaused.toggle()
                        viewModel.togglePause()
                    }) {
                        Text(isPaused ? "Resume" : "Pause")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(CustomBorderedButtonStyle())
                }
                
                Button(action: onComplete) {
                    Text(isLastExercise ? "Finish" : "Next")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(CustomBorderedButtonStyle(filled: true))
            }
        }
        .padding()
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    private var isLastExercise: Bool {
        exerciseData.indexInModule == exerciseData.totalExercisesInModule - 1
    }
}

struct CircularTimerView: View {
    var progress: CGFloat
    var timeLeft: String
    var isLarge: Bool = false
    var color: Color = .blue
    var lineWidth: CGFloat = 6
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .opacity(0.3)
                .foregroundColor(color)
            
            if !timeLeft.contains("No") {
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .foregroundColor(color)
                    .rotationEffect(Angle(degrees: -90))
            }
            
            Text(timeLeft)
                .font(isLarge ? .title.bold() : .caption2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
    }
}

struct CustomBorderedButtonStyle: ButtonStyle {
    var filled: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Group {
                    if filled {
                        Color.red
                    } else {
                        Color(UIColor.label.withAlphaComponent(0.15))
                    }
                }
            )
            .foregroundColor(filled ? .white : .white)
            .cornerRadius(8)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

#Preview {
    WorkoutSessionView(viewModel: .init(session: ExerciseManager().allTrainingPlans.first!))
}
