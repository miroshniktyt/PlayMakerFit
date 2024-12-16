//
//  HistoryView.swift
//  TrainTrackPro
//
//  Created by pc on 24.10.24.
//

import SwiftUI

struct HistoryView: View {
    @State private var workoutHistory: [WorkoutRecord] = []
    let historyManager = WorkoutHistoryManager()

    var body: some View {
        NavigationView {
            if workoutHistory.isEmpty {
                VStack {
                    Spacer()
                    Image(systemName: "calendar.badge.exclamationmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.secondary)
                    Text("No workout history yet")
                        .font(.headline)
                        .padding(.top)
                    Text("(You can start one on the Plan tab)")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .navigationTitle("Workout History")
            } else {
                List {
                    ForEach(workoutHistory) { record in
                        WorkoutHistoryCell(record: record)
                    }
                    .onDelete(perform: deleteRecord)
                }
                .navigationTitle("Workout History")
            }
        }
        .onAppear {
            workoutHistory = historyManager.loadWorkoutHistory()
        }
    }

    // Swipe to delete functionality
    func deleteRecord(at offsets: IndexSet) {
        workoutHistory.remove(atOffsets: offsets)
        if let index = offsets.first {
            historyManager.deleteRecord(at: index)
        }
    }
}
struct WorkoutHistoryCell: View {
    let record: WorkoutRecord

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Session Name
            Text(record.sessionName)
                .font(.headline)
            
            // Date
            HStack {
                Text("Date:")
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(record.date, formatter: dateFormatter)")
                    .font(.subheadline)
            }

            // Exercises Count
            HStack {
                Text("Exercises:")
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(totalExercisesCount())")
                    .font(.subheadline)
            }

            // Duration
            if let duration = calculateTotalDuration() {
                HStack {
                    Text("Duration:")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(duration)
                        .font(.subheadline)
                }
            }

            // Indicate if it's a Training Plan
            if record.isTrainingPlan {
                Text("Type: Training Plan")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                Text("Type: Workout")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }

    // Date formatter for the date
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }

    // Calculate total exercises across all modules
    func totalExercisesCount() -> Int {
        return record.modules.reduce(0) { $0 + $1.exercises.count }
    }

    // Calculate total duration across all modules
    func calculateTotalDuration() -> String? {
        let totalDuration = record.modules
            .flatMap { $0.exercises }
            .compactMap { $0.duration }
            .reduce(0, +)

        guard totalDuration > 0 else { return nil }

        let minutes = totalDuration / 60
        let seconds = totalDuration % 60
        return String(format: "%02d min %02d sec", minutes, seconds)
    }
}

struct WorkoutRecord: Identifiable, Codable {
    let id: UUID
    let sessionName: String
    let sessionDescription: String?
    let date: Date
    let isTrainingPlan: Bool
    let modules: [WorkoutModule]
    
    init(session: any Session, date: Date = Date()) {
        self.id = UUID()
        self.sessionName = session.name
        self.sessionDescription = session.description
        self.date = date
        self.isTrainingPlan = session.modules.count > 1
        self.modules = session.modules
    }
}

class WorkoutHistoryManager {
    private let historyKey = "WorkoutHistory"

    func saveWorkoutRecord(_ record: WorkoutRecord) {
        var history = loadWorkoutHistory()
        history.append(record)
        if let encoded = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(encoded, forKey: historyKey)
        }
    }

    func loadWorkoutHistory() -> [WorkoutRecord] {
        if let data = UserDefaults.standard.data(forKey: historyKey),
           let history = try? JSONDecoder().decode([WorkoutRecord].self, from: data) {
            return history
        }
        return []
    }

    // Deleting a workout record
    func deleteRecord(at index: Int) {
        var history = loadWorkoutHistory()
        guard history.indices.contains(index) else { return }
        history.remove(at: index)
        if let encoded = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(encoded, forKey: historyKey)
        }
    }
}
