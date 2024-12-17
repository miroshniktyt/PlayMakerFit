//
//  ModuleDoneView.swift
//  TrainTrackPro
//
//  Created by pc on 16.12.24.
//

import SwiftUI

struct ModuleDoneView: View {
    let moduleName: String
    let isTrainingPlanComplete: Bool
    let nextModuleName: String?
    let onNextModule: () -> Void
    let onFinish: () -> Void
    let duration: TimeInterval
    let exerciseCount: Int
    
    @State private var hasCompletionRun = false
    
    var body: some View {
        VStack(spacing: 0) {
            Image(isTrainingPlanComplete ? "plan_complete_bg" : "workout_complete_bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minHeight: 100, maxHeight: .infinity)
                .clipped()
            
            VStack(spacing: 16) {
                Text(isTrainingPlanComplete ? "Congratulations!" : "Workout Completed!")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text("Training Plan Complete")
                    .font(.system(size: 20))
                    .foregroundColor(.secondary)
                    .padding(.bottom, 16)
            }
            
            VStack(spacing: 16) {
                if isTrainingPlanComplete {
                    HStack(spacing: 20) {
                        StatBox(value: formatTime(duration), label: "minutes")
                        StatBox(value: "\(exerciseCount)", label: "exercises")
                    }
                    .padding(.bottom, 24)
                } else {
                    WorkoutInfoBox(title: "Previous Workout:", workoutName: moduleName)
                    if let nextWorkout = nextModuleName {
                        WorkoutInfoBox(title: "Next Workout:", workoutName: nextWorkout)
                    }
                }
                
                VStack(spacing: 16) {
                    Button(action: {
                        runCompletion()
                        // No need to call dismiss() as the parent view will handle navigation
                    }) {
                        Text(isTrainingPlanComplete ? "Finish" : "Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    
                    Text("This session has been saved to your history")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Add background color for contrast
        .onDisappear {
            runCompletion()
        }
    }
    
    private func formatTime(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let remainingSeconds = Int(seconds) % 60
        return "\(minutes):\(String(format: "%02d", remainingSeconds))"
    }
    
    private func runCompletion() {
        guard !hasCompletionRun else { return }
        hasCompletionRun = true
        
        if isTrainingPlanComplete {
            onFinish()
        } else {
            onNextModule()
        }
    }
}

struct StatBox: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
            Text(label)
                .font(.system(size: 16))
                .foregroundColor(.secondary)
        }
        .frame(minWidth: 140, maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.cyan, lineWidth: 1)
        )
    }
}

struct WorkoutInfoBox: View {
    let title: String
    let workoutName: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.white)
            Text(workoutName)
                .font(.system(size: 16))
                .foregroundColor(.red)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.cyan, lineWidth: 1)
        )
    }
}

#Preview {
    ModuleDoneView(
        moduleName: "moduleName",
        isTrainingPlanComplete: true,
        nextModuleName: "nextModuleName",
        onNextModule: {},
        onFinish: {},
        duration: 1110,
        exerciseCount: 12)
}
