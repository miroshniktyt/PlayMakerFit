//
//  SettingsView.swift
//  TrainTrackPro
//
//  Created by pc on 05.12.24.
//

import SwiftUI

#Preview {
    SettingsView()
}

struct SettingsView: View {
//    @AppStorage("appearanceMode") private var appearanceMode: Int = 2 // 0 = System, 1 = Light, 2 = Dark
    @State private var showOnboarding = false
    @State private var showHistory = false
    @State private var showQr = false
    @AppStorage(UserDefaultsKeys.soundEnabled) private var isSoundEnabled = true
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle("Exercise Sounds", isOn: $isSoundEnabled)
                }
                
                Section {
                    Button(action: {
                        showOnboarding = true
                    }) {
                        HStack {
                            Text("Onboarding")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                    }
                    .sheet(isPresented: $showOnboarding) {
                        OnboardingView()
                    }
                }
                
//                Section("Appearance") {
//                    Picker("Appearance Mode", selection: $appearanceMode) {
//                        Text("System").tag(0)
//                        Text("Light").tag(1)
//                        Text("Dark").tag(2)
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                    .padding(4)
//                    .onChange(of: appearanceMode) { newValue in
//                        switchAppearanceMode(newValue)
//                    }
//                }
                
                Section {
                    Button(action: {
                        showHistory = true
                    }) {
                        HStack {
                            Text("History")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                    }
                    .sheet(isPresented: $showHistory) {
                        HistoryView()
                    }
                }
                
                Section {
                    Button(action: {
                        if let url = URL(string: "https://quicknote.io/981ec000-bc12-11ef-a9b9-03efe3067563") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack {
                            Text("Privacy Policy")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                    }
                    
                }
                
                Section {
                    Button(action: {
                        showQr = true
                    }) {
                        ZStack {
                            Image("qr")
                                .resizable()
                                .font(.system(size: 40))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .scaledToFit()
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .sheet(isPresented: $showQr) {
                        QRCodeView()
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
