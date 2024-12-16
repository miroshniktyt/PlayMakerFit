//
//  sportApp.swift
//  sport
//
//  Created by pc on 02.10.24.
//

import SwiftUI

struct RootView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false 

    var body: some View {
        Group {
            if hasSeenOnboarding {
                RootTabBarView()  // Your main app view
            } else {
                OnboardingView()
            }
        }
    }
}

struct RootTabBarView: View {
    var body: some View {
        TabView {
            TrainingPlanListView()
                .tabItem {
                    Label("Plans", systemImage: "chart.bar.doc.horizontal")
                }
            WorkoutsListView()
                .tabItem {
                    Label("Workouts", systemImage: "list.bullet")
                }
            ExerciseListView()
                .tabItem {
                    Label("Exercises", systemImage: "figure.strengthtraining.traditional")
                }
            SettingsView()
                .tabItem {
                    Label("Other", systemImage: "person.circle")
                }
        }
    }
}

extension Int: Identifiable {
    public var id: Int { self }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    RootTabBarView()
}
