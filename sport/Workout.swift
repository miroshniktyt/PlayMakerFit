//
//  WorkoutNew.swift
//  TrainTrackPro
//
//  Created by pc on 07.11.24.
//

import SwiftUI

#Preview {
    WorkoutsListView()
}

struct WorkoutModule: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String?
    var category: WorkoutCategory
    var exercises: [Exercise]
    var adjustments: String?

    init(id: UUID = UUID(), name: String, description: String, category: WorkoutCategory, exercises: [Exercise], adjustments: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.category = category
        self.exercises = exercises
        self.adjustments = adjustments
    }

    // Methods for saving and loading from UserDefaults
    static func loadFromUserDefaults() -> [WorkoutModule]? {
        if let savedData = UserDefaults.standard.data(forKey: "savedWorkouts") {
            if let decoded = try? JSONDecoder().decode([WorkoutModule].self, from: savedData) {
                return decoded
            }
        }
        return nil
    }

    static func saveToUserDefaults(_ workouts: [WorkoutModule]) {
        if let encoded = try? JSONEncoder().encode(workouts) {
            UserDefaults.standard.set(encoded, forKey: "savedWorkouts")
        }
    }
}

enum WorkoutCategory: String, CaseIterable, Codable, Identifiable {
    case warmUp = "Warm-Up"
    case strengthTraining = "Strength Training"
    case cardio = "Cardio"
    case flexibilityAndMobility = "Flexibility & Mobility"
    case coolDown = "Cool-Down"

    var id: String { self.rawValue }
}

struct WorkoutsListView: View {
    @State private var workouts: [WorkoutModule] = WorkoutModule.loadFromUserDefaults() ?? ExerciseManager().allWorkoutModules
    @State private var selectedWorkoutIndex: Int? = nil
    @State private var isAddingWorkout = false
    @State private var startWorkoutIndex: Int? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workouts.indices, id: \.self) { index in
                    WorkoutCellView2(
                        workout: workouts[index],
                        onPreview: {
                            selectedWorkoutIndex = index
                        },
                        onStart: {
                            startWorkoutIndex = index
                        },
                        onDelete: {
                            deleteWorkout(at: index)
                        }
                    )
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteWorkout(at: index)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddingWorkout = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $selectedWorkoutIndex) { index in
                WorkoutDetailView(
                    workout: $workouts[index],
                    isNewWorkout: false
                )
            }
            .sheet(isPresented: $isAddingWorkout) {
                let newWorkout = WorkoutModule(name: "", description: "", category: .strengthTraining, exercises: [], adjustments: nil)
                WorkoutDetailView(
                    workout: .constant(newWorkout),
                    isNewWorkout: true,
                    onSave: { workout in
                        workouts.insert(workout, at: 0)
                        isAddingWorkout = false
                        saveWorkouts()
                    },
                    onCancel: {
                        isAddingWorkout = false
                    }
                )
            }
            .sheet(item: $startWorkoutIndex) { index in
                NavigationView {
                    WorkoutSessionView(viewModel: WorkoutSessionViewModel(session: workouts[index]))
                }
            }
            .onChange(of: workouts) { _ in
                saveWorkouts()
            }
        }
    }

    func saveWorkouts() {
        WorkoutModule.saveToUserDefaults(workouts)
    }

    func deleteWorkout(at index: Int) {
        workouts.remove(at: index)
        saveWorkouts()
    }
}

struct WorkoutDetailView: View {
    @Binding var workout: WorkoutModule
    let isNewWorkout: Bool
    var onSave: ((WorkoutModule) -> Void)?
    var onCancel: (() -> Void)?
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var tempWorkout: WorkoutModule
    @State private var isModified = false
    @State private var showDiscardChangesAlert = false
    
    init(workout: Binding<WorkoutModule>, isNewWorkout: Bool = false, onSave: ((WorkoutModule) -> Void)? = nil, onCancel: (() -> Void)? = nil) {
        self._workout = workout
        self.isNewWorkout = isNewWorkout
        self.onSave = onSave
        self.onCancel = onCancel
        self._tempWorkout = State(initialValue: workout.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            WorkoutEditForm(workout: $tempWorkout, isModified: $isModified)
                .navigationBarTitle(isNewWorkout ? "New Workout" : "Workout Details", displayMode: .inline)
                .navigationBarItems(
                    leading: Button("Cancel") {
                        handleCancel()
                    },
                    trailing: Button(isNewWorkout ? "Add" : "Done") {
                        saveChanges()
                        dismiss()
                    }
                    .disabled(tempWorkout.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                )
                .alert(isPresented: $showDiscardChangesAlert) {
                    Alert(
                        title: Text("Discard Changes?"),
                        message: Text("You have unsaved changes. Are you sure you want to discard them?"),
                        primaryButton: .destructive(Text("Discard")) {
                            dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }
                .interactiveDismissDisabled(isModified)
        }
    }
    
    func handleCancel() {
        if isModified {
            showDiscardChangesAlert = true
        } else {
            dismiss()
        }
    }
    
    func saveChanges() {
        workout = tempWorkout
        onSave?(tempWorkout)
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
        onCancel?()
    }
}

struct WorkoutEditForm: View {
    @Binding var workout: WorkoutModule
    @Binding var isModified: Bool
    
    @State private var isPresentingExercisePicker = false
    
    var body: some View {
        Form {
            Section(header: Text("Workout Info")) {
                TextField("Name", text: $workout.name)
                    .autocapitalization(.words)
                    .onChange(of: workout.name) { _ in isModified = true }
                
                Picker("Category", selection: $workout.category) {
                    ForEach(WorkoutCategory.allCases) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .onChange(of: workout.category) { _ in isModified = true }
                
                TextEditor(text: Binding(
                    get: { workout.description ?? "" },
                    set: { workout.description = $0.isEmpty ? nil : $0; isModified = true }
                ))
                .frame(height: 100)
            }
            
            Section(header: Text("Exercises")) {
                if workout.exercises.isEmpty {
                    Text("No exercises added yet")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(workout.exercises.indices, id: \.self) { index in
                        ExerciseCellViewSimple(exercise: workout.exercises[index])
                    }
                    .onDelete(perform: deleteExercises)
                    .onMove(perform: moveExercises)
                }
                Button(action: {
                    isPresentingExercisePicker = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Exercises")
                    }
                }
            }
            
            Section(header: Text("Adjustments")) {
                TextEditor(text: Binding(
                    get: { workout.adjustments ?? "" },
                    set: { workout.adjustments = $0.isEmpty ? nil : $0; isModified = true }
                ))
                .frame(height: 100)
            }
            
            Section(header: Text("Total Time")) {
                Text(totalDuration())
            }
        }
        .sheet(isPresented: $isPresentingExercisePicker) {
            NavigationView {
                ExercisePickerView(selectedExercises: $workout.exercises)
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            isPresentingExercisePicker = false
                        },
                        trailing: Button("Done") {
                            isPresentingExercisePicker = false
                        }
                    )
            }
        }
    }
    
    func deleteExercises(at offsets: IndexSet) {
        workout.exercises.remove(atOffsets: offsets)
        isModified = true
    }
    
    func moveExercises(from source: IndexSet, to destination: Int) {
        workout.exercises.move(fromOffsets: source, toOffset: destination)
        isModified = true
    }
    
    func totalDuration() -> String {
        let totalSeconds = workout.exercises.reduce(0) { $0 + ($1.duration ?? 0) }
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return "\(minutes) min \(seconds) sec"
    }
}

struct WorkoutCellView2: View {
    
    var workout: WorkoutModule
    var onPreview: () -> Void
    var onStart: () -> Void
    var onDelete: () -> Void
    
    var body: some View {
        Menu {
            Button(action: {
                onStart()
            }) {
                Label("Play", systemImage: "play.circle")
            }
            
            Button(action: {
                onPreview()
            }) {
                Label("View and Edit", systemImage: "pencil")
            }
            
            Divider()
            
            Button(role: .destructive, action: {
                onDelete()
            }) {
                Label("Delete", systemImage: "trash")
            }
        } label: {
            HStack {
                // Full-width label to make menu tappable across the entire cell
                VStack(alignment: .leading, spacing: 4) {
                    Text(workout.name)
                        .font(.headline)
                        .foregroundColor(.primary) // Primary color for main title

                    // Secondary information (category and details)
                    Text("\(workout.category.rawValue) • \(workout.exercises.count) exercises • \(totalDurationText())")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .truncationMode(.tail) // Ensures text doesn’t overflow
                }
            }
            .contentShape(Rectangle()) // Ensures the entire row is tappable
            .padding(.vertical, 8)
        }
        .buttonStyle(PlainButtonStyle()) // Removes button styling for a cleaner look
    }

    // Function for calculating total duration
    private func totalDurationText() -> String {
        let totalSeconds = workout.exercises.reduce(0) { $0 + ($1.duration ?? 0) }
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return minutes > 0 ? "\(minutes) min \(seconds) sec" : "\(seconds) sec"
    }
}
