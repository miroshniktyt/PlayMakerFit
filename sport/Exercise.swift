//
//  ExerciseNew.swift
//  TrainTrackPro
//
//  Created by pc on 07.11.24.
//

import SwiftUI

#Preview {
    ExerciseListView()
}


struct Exercise: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String?
    var adjustments: String? // Instructions on how to adjust for difficulty, optional
    var duration: Int? // Duration in seconds, optional
    var repetitions: Int? // Number of repetitions, optional
    var weight: Double? // Weight in kg, optional

    init(id: UUID = UUID(), name: String, description: String? = nil, adjustments: String? = nil, duration: Int? = nil, repetitions: Int? = nil, weight: Double? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.adjustments = adjustments
        self.duration = duration
        self.repetitions = repetitions
        self.weight = weight
    }

    static func loadFromUserDefaults() -> [Exercise]? {
        if let savedData = UserDefaults.standard.data(forKey: "savedExercises") {
            if let decoded = try? JSONDecoder().decode([Exercise].self, from: savedData) {
                return decoded
            }
        }
        return nil
    }

    static func saveToUserDefaults(_ exercises: [Exercise]) {
        if let encoded = try? JSONEncoder().encode(exercises) {
            UserDefaults.standard.set(encoded, forKey: "savedExercises")
        }
    }
}

struct ExerciseCellView: View {
    var exercise: Exercise

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(exercise.name)
                    .font(.headline)
                
                Text([durationText, weightText, repetitionsText].compactMap { $0 }.joined(separator: " • "))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
//                if let description = exercise.description {
//                    Text(description)
//                        .font(.footnote)
//                        .foregroundColor(.secondary)
//                        .lineLimit(1) // Truncates if text is too long
//                }
            }
            Spacer(minLength: 24)
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 2)
        .contentShape(Rectangle())
    }

    // Helper computed properties for secondary details
    var durationText: String? {
        if let duration = exercise.duration {
            let minutes = duration / 60
            let seconds = duration % 60
            return minutes > 0 ? "\(minutes) min \(seconds) sec" : "\(seconds) sec"
        }
        return nil
    }

    var weightText: String? {
        if let weight = exercise.weight {
            return "\(weight) kg"
        }
        return nil
    }

    var repetitionsText: String? {
        if let repetitions = exercise.repetitions {
            return "\(repetitions) reps"
        }
        return nil
    }
}

// Add this new cell view for workout details
struct ExerciseCellViewSimple: View {
    var exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(exercise.name)
                .font(.headline)
            
            Text([durationText, weightText, repetitionsText].compactMap { $0 }.joined(separator: " • "))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 2)
    }
    
    // Helper computed properties for secondary details
    var durationText: String? {
        if let duration = exercise.duration {
            let minutes = duration / 60
            let seconds = duration % 60
            return minutes > 0 ? "\(minutes) min \(seconds) sec" : "\(seconds) sec"
        }
        return nil
    }
    
    var weightText: String? {
        if let weight = exercise.weight {
            return "\(weight) kg"
        }
        return nil
    }
    
    var repetitionsText: String? {
        if let repetitions = exercise.repetitions {
            return "\(repetitions) reps"
        }
        return nil
    }
}

struct ExerciseListView: View {
    @State private var exercises: [Exercise] = Exercise.loadFromUserDefaults() ?? ExerciseManager().allExercises
    @State private var selectedExerciseIndex: Int? = nil
    @State private var isAddingExercise = false
    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredIndices, id: \.self) { index in
                    ExerciseCellView(exercise: exercises[index])
                        .onTapGesture {
                            selectedExerciseIndex = index
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteExercises(at: index)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Exercises")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddingExercise = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $selectedExerciseIndex) { index in
                ExerciseDetailView(
                    exercise: $exercises[index],
                    isNewExercise: false
                )
            }
            .sheet(isPresented: $isAddingExercise) {
                let newExercise = Exercise(name: "")
                ExerciseDetailView(
                    exercise: .constant(newExercise),
                    isNewExercise: true
                ) { exercise in
                    exercises.insert(exercise, at: 0)
                    isAddingExercise = false
                    saveExercises()
                }
            }
            .onChange(of: exercises) { _ in
                saveExercises()
            }
        }
    }

    var filteredIndices: [Int] {
        if searchText.isEmpty {
            return exercises.indices.map { $0 }
        } else {
            return exercises.indices.filter { index in
                exercises[index].name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    func deleteExercises(at index: Int) {
        exercises.remove(at: index)
        saveExercises()
    }

    func saveExercises() {
        Exercise.saveToUserDefaults(exercises)
    }
}

struct ExerciseDetailView: View {
    @Binding var exercise: Exercise
    @Environment(\.presentationMode) var presentationMode

    @State private var tempExercise: Exercise
    @State private var isModified = false
    @State private var showDiscardChangesAlert = false

    let isNewExercise: Bool
    var onSave: ((Exercise) -> Void)?

    init(exercise: Binding<Exercise>, isNewExercise: Bool = false, onSave: ((Exercise) -> Void)? = nil) {
        self._exercise = exercise
        self.isNewExercise = isNewExercise
        self.onSave = onSave
        self._tempExercise = State(initialValue: exercise.wrappedValue)
    }

    var body: some View {
        NavigationView {
            ExerciseEditForm(exercise: $tempExercise, isModified: $isModified)
                .navigationBarTitle(isNewExercise ? "New Exercise" : "Exercise Details", displayMode: .inline)
                .navigationBarItems(
                    leading: Button("Cancel") {
                        handleCancel()
                    },
                    trailing: Button(isNewExercise ? "Add" : "Done") {
                        saveChanges()
                        dismiss()
                    }
                    .disabled(tempExercise.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
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
        exercise = tempExercise
        onSave?(tempExercise)
    }

    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct ExerciseEditForm: View {
    @Binding var exercise: Exercise
    @Binding var isModified: Bool

    @State private var minutes: String = ""
    @State private var seconds: String = ""
    @State private var hasDuration: Bool = false

    var body: some View {
        Form {
            Section(header: Text("Basic Info")) {
                TextField("Enter name", text: $exercise.name)
                    .onChange(of: exercise.name) { _ in isModified = true }
            }

            Section(header: Text("Details")) {
                Toggle(isOn: $hasDuration) {
                    Text("Duration")
                }
                .onChange(of: hasDuration) { newValue in
                    if !newValue {
                        exercise.duration = nil
                    }
                    isModified = true
                }

                if hasDuration {
                    HStack {
                        Text("Minutes")
                        Spacer()
                        TextField("0", text: $minutes)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: minutes) { _ in
                                updateDuration()
                                isModified = true
                            }
                    }
                    HStack {
                        Text("Seconds")
                        Spacer()
                        TextField("0", text: $seconds)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: seconds) { _ in
                                updateDuration()
                                isModified = true
                            }
                    }
                }

                HStack {
                    Text("Repetitions")
                    Spacer()
                    TextField("Optional", text: Binding(
                        get: { exercise.repetitions != nil ? "\(exercise.repetitions!)" : "" },
                        set: {
                            exercise.repetitions = Int($0)
                            isModified = true
                        }
                    ))
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing)
                }

                HStack {
                    Text("Weight (kg)")
                    Spacer()
                    TextField("Optional", text: Binding(
                        get: { exercise.weight != nil ? String(format: "%.2f", exercise.weight!) : "" },
                        set: {
                            exercise.weight = Double($0)
                            isModified = true
                        }
                    ))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                }
            }

            Section(header: Text("Description")) {
                TextEditor(text: Binding(
                    get: { exercise.description ?? "" },
                    set: { exercise.description = $0; isModified = true }
                ))
                .frame(height: 100)
            }

            Section(header: Text("Adjustments")) {
                TextEditor(text: Binding(
                    get: { exercise.adjustments ?? "" },
                    set: { exercise.adjustments = $0; isModified = true }
                ))
                .frame(height: 100)
            }
        }
        .onAppear {
            loadData()
        }
        .onChange(of: exercise) { _ in
            isModified = true
        }
    }

    func loadData() {
        if let duration = exercise.duration {
            hasDuration = true
            let totalMinutes = duration / 60
            let remainingSeconds = duration % 60
            minutes = "\(totalMinutes)"
            seconds = "\(remainingSeconds)"
        } else {
            hasDuration = false
            minutes = ""
            seconds = ""
        }
    }

    func updateDuration() {
        let min = Int(minutes) ?? 0
        let sec = Int(seconds) ?? 0
        exercise.duration = (min * 60) + sec
    }
}

struct ExercisePickerView: View {
    @Binding var selectedExercises: [Exercise]
    @State private var availableExercises: [Exercise] = ExerciseManager().allExercises
    @State private var selectedExerciseIDs: Set<UUID> = []

    var body: some View {
        List {
            ForEach(availableExercises) { exercise in
                HStack {
                    Text(exercise.name)
                    Spacer()
                    if selectedExerciseIDs.contains(exercise.id) {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if selectedExerciseIDs.contains(exercise.id) {
                        selectedExerciseIDs.remove(exercise.id)
                        selectedExercises.removeAll { $0.id == exercise.id }
                    } else {
                        selectedExerciseIDs.insert(exercise.id)
                        selectedExercises.append(exercise)
                    }
                }
            }
        }
        .onAppear {
            selectedExerciseIDs = Set(selectedExercises.map { $0.id })
        }
        .navigationTitle("Select Exercises")
    }
}
