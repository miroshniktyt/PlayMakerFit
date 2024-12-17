//
//  TrainPlan.swift
//  TrainTrackPro
//
//  Created by pc on 08.11.24.
//

import SwiftUI

struct TrainingPlan: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String?
    var modules: [WorkoutModule]
    
    init(id: UUID = UUID(), name: String, description: String? = nil, modules: [WorkoutModule]) {
        self.id = id
        self.name = name
        self.description = description
        self.modules = modules
    }
    
    // Methods for saving and loading from UserDefaults
    static func loadFromUserDefaults() -> [TrainingPlan]? {
        if let savedData = UserDefaults.standard.data(forKey: "savedTrainingPlans") {
            if let decoded = try? JSONDecoder().decode([TrainingPlan].self, from: savedData) {
                return decoded
            }
        }
        return nil
    }

    static func saveToUserDefaults(_ plans: [TrainingPlan]) {
        if let encoded = try? JSONEncoder().encode(plans) {
            UserDefaults.standard.set(encoded, forKey: "savedTrainingPlans")
        }
    }
}

struct TrainingPlanListView: View {
    @State private var trainingPlans: [TrainingPlan] = TrainingPlan.loadFromUserDefaults() ?? ExerciseManager().allTrainingPlans
    @State private var selectedPlanIndex: Int? = nil
    @State private var isAddingPlan = false
    @State private var startPlanIndex: Int? = nil
    let recommendedWorkoutNames: [String] = ["Total Body Workout Day", "Cardio and Core"]
    var recommendedPlans: [TrainingPlan] {
        trainingPlans.filter { recommendedWorkoutNames.contains($0.name) }
    }
    
    var body: some View {
        NavigationView {
            List {
                
                Section(header: Text("Recommended")) {
                    ForEach(recommendedPlans, id: \.id) { plan in
                        TrainingPlanCellView(
                            trainingPlan: plan,
                            onStart: {
                                startPlanIndex = trainingPlans.firstIndex(where: { $0.id == plan.id })
                            },
                            onEdit: {
                                selectedPlanIndex = trainingPlans.firstIndex(where: { $0.id == plan.id })
                            }
                        )
                        .swipeActions {
                            if let index = trainingPlans.firstIndex(where: { $0.id == plan.id }) {
                                Button(role: .destructive) {
                                    deletePlan(at: index)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }

                Section(header: Text("All")) {
                    ForEach(trainingPlans, id: \.id) { plan in
                        TrainingPlanCellView(
                            trainingPlan: plan,
                            onStart: {
                                startPlanIndex = trainingPlans.firstIndex(where: { $0.id == plan.id })
                            },
                            onEdit: {
                                selectedPlanIndex = trainingPlans.firstIndex(where: { $0.id == plan.id })
                            }
                        )
                        .swipeActions {
                            if let index = trainingPlans.firstIndex(where: { $0.id == plan.id }) {
                                Button(role: .destructive) {
                                    deletePlan(at: index)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Training Plans")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddingPlan = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $selectedPlanIndex) { index in
                TrainingPlanDetailView(
                    trainingPlan: $trainingPlans[index],
                    isNewPlan: false
                )
            }
            .sheet(isPresented: $isAddingPlan) {
                let newPlan = TrainingPlan(name: "", modules: [])
                TrainingPlanDetailView(
                    trainingPlan: .constant(newPlan),
                    isNewPlan: true,
                    onSave: { plan in
                        trainingPlans.insert(plan, at: 0)
                        isAddingPlan = false
                        savePlans()
                    },
                    onCancel: {
                        isAddingPlan = false
                    }
                )
            }
            .sheet(item: $startPlanIndex) { index in
                NavigationView {
                    WorkoutSessionView(viewModel: WorkoutSessionViewModel(session: trainingPlans[index]))
                }
            }
            .onChange(of: trainingPlans) { _ in
                savePlans()
            }
        }
    }

    func savePlans() {
        TrainingPlan.saveToUserDefaults(trainingPlans)
    }

    func deletePlan(at index: Int) {
        trainingPlans.remove(at: index)
        savePlans()
    }
}

struct TrainingPlanCellView: View {
    var trainingPlan: TrainingPlan
    var onStart: () -> Void
    var onEdit: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(trainingPlan.name)
                    .font(.headline)
                HStack {
                    Text("\(trainingPlan.modules.count) workouts")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // Edit button
            Button(action: onEdit) {
                Image(systemName: "square.and.pencil")
                    .font(.title)
                    .foregroundColor(.cyan)
            }
            .buttonStyle(BorderlessButtonStyle())
            .padding(.trailing, 4)
            
            // Start button
            Button(action: onStart) {
                Image(systemName: "play.circle.fill")
                    .font(.title)
                    .foregroundColor(.red)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(.vertical, 8)
    }
}

struct TrainingPlanDetailView: View {
    @Binding var trainingPlan: TrainingPlan
    let isNewPlan: Bool
    var onSave: ((TrainingPlan) -> Void)?
    var onCancel: (() -> Void)?

    @Environment(\.presentationMode) var presentationMode

    @State private var tempPlan: TrainingPlan
    @State private var isModified = false
    @State private var showDiscardChangesAlert = false

    init(trainingPlan: Binding<TrainingPlan>, isNewPlan: Bool = false, onSave: ((TrainingPlan) -> Void)? = nil, onCancel: (() -> Void)? = nil) {
        self._trainingPlan = trainingPlan
        self.isNewPlan = isNewPlan
        self.onSave = onSave
        self.onCancel = onCancel
        self._tempPlan = State(initialValue: trainingPlan.wrappedValue)
    }

    var body: some View {
        NavigationView {
            TrainingPlanEditForm(trainingPlan: $tempPlan, isModified: $isModified)
                .navigationBarTitle(isNewPlan ? "New Training Plan" : "Training Plan Details", displayMode: .inline)
                .navigationBarItems(
                    leading: Button("Cancel") {
                        handleCancel()
                    },
                    trailing: Button(isNewPlan ? "Add" : "Done") {
                        saveChanges()
                        dismiss()
                    }
                    .disabled(tempPlan.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
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
        trainingPlan = tempPlan
        onSave?(tempPlan)
    }

    func dismiss() {
        presentationMode.wrappedValue.dismiss()
        onCancel?()
    }
}

struct TrainingPlanEditForm: View {
    @Binding var trainingPlan: TrainingPlan
    @Binding var isModified: Bool
    
    @State private var isPresentingWorkoutPicker = false
    
    var body: some View {
        Form {
            Section(header: Text("Training Plan Info")) {
                TextField("Name", text: $trainingPlan.name)
                    .autocapitalization(.words)
                    .onChange(of: trainingPlan.name) { _ in isModified = true }

                TextEditor(text: Binding(
                    get: { trainingPlan.description ?? "" },
                    set: { trainingPlan.description = $0.isEmpty ? nil : $0; isModified = true }
                ))
                .frame(height: 100)
            }

            Section(header: Text("Workouts")) {
                if trainingPlan.modules.isEmpty {
                    Text("No workouts added yet")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(trainingPlan.modules.indices, id: \.self) { index in
                        WorkoutCellViewSimple(workout: trainingPlan.modules[index])
                    }
                    .onDelete(perform: deleteWorkouts)
                    .onMove(perform: moveWorkouts)
                }
                Button(action: {
                    isPresentingWorkoutPicker = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Workouts")
                    }
                }
            }
        }
        .sheet(isPresented: $isPresentingWorkoutPicker) {
            NavigationView {
                WorkoutPickerView(selectedWorkouts: Binding(
                    get: { trainingPlan.modules },
                    set: { newModules in
                        trainingPlan.modules = newModules
                        isModified = true
                    }
                ))
                .navigationBarItems(
                    leading: Button("Cancel") {
                        isPresentingWorkoutPicker = false
                    },
                    trailing: Button("Done") {
                        isPresentingWorkoutPicker = false
                    }
                )
            }
        }
    }
    
    func deleteWorkouts(at offsets: IndexSet) {
        trainingPlan.modules.remove(atOffsets: offsets)
        isModified = true
    }
    
    func moveWorkouts(from source: IndexSet, to destination: Int) {
        trainingPlan.modules.move(fromOffsets: source, toOffset: destination)
        isModified = true
    }
}

struct WorkoutPickerView: View {
    @Binding var selectedWorkouts: [WorkoutModule]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var allWorkouts: [WorkoutModule] = ExerciseManager().allWorkoutModules
    @State private var selectedWorkoutIDs: Set<UUID> = []
    
    var body: some View {
        List(allWorkouts) { workout in
            Button(action: {
                toggleSelection(for: workout)
            }) {
                HStack {
                    WorkoutCellViewSimple(workout: workout)
                    Spacer()
                    if selectedWorkoutIDs.contains(workout.id) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .navigationTitle("Select Workouts")
        .onAppear {
            // Initialize with existing selections
            selectedWorkoutIDs = Set(selectedWorkouts.map { $0.id })
        }
    }
    
    func toggleSelection(for workout: WorkoutModule) {
        if selectedWorkoutIDs.contains(workout.id) {
            selectedWorkoutIDs.remove(workout.id)
            selectedWorkouts.removeAll { $0.id == workout.id }
        } else {
            selectedWorkoutIDs.insert(workout.id)
            selectedWorkouts.append(workout)
        }
    }
}

// Add this new cell view for training plan details
struct WorkoutCellViewSimple: View {
    var workout: WorkoutModule
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(workout.name)
                .font(.headline)
                .foregroundColor(.primary)

            Text("\(workout.category.rawValue) • \(workout.exercises.count) exercises")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TrainingPlanListView()
}
