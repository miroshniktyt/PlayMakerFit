//
//  OtherTabView.swift
//  TrainTrackPro
//
//  Created by pc on 24.10.24.
//

import SwiftUI

#Preview {
    Text("asd")
}

struct OtherTabView: View {
//    @AppStorage("appearanceMode") private var appearanceMode: Int = 2 // 0 = System, 1 = Light, 2 = Dark
//    @State private var showOnboarding = false
//    @State private var showHistory = false
//    @State private var showQr = false

    var body: some View {
        NavigationView {
            Text("asd")
//            Form {
//                Section("Appearance") {
//                    Picker("Appearance Mode", selection: $appearanceMode) {
//                        Text("System").tag(0)
//                        Text("Light").tag(1)
//                        Text("Dark").tag(2)
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                    .onChange(of: appearanceMode) { newValue in
//                        switchAppearanceMode(newValue)
//                    }
//                }
//                Section {
//                    Button(action: {
//                        showQr = true
//                    }) {
//                        HStack {
//                            Spacer()
//                            Text("QR Code")
//                                .frame(maxWidth: .infinity)
//                            Spacer()
//                        }
//                    }
//                    .sheet(isPresented: $showQr) {
//                        QRCodeView()
//                    }
//                }
//                
//                Section {
//                    Button(action: {
//                        showHistory = true
//                    }) {
//                        HStack {
//                            Spacer()
//                            Text("History")
//                                .frame(maxWidth: .infinity)
//                            Spacer()
//                        }
//                    }
//                    .sheet(isPresented: $showHistory) {
//                        HistoryView()
//                    }
//                }
//                
//                Section {
//                    Button(action: {
//                        showOnboarding = true
//                    }) {
//                        HStack {
//                            Spacer()
//                            Text("Onboarding")
//                                .frame(maxWidth: .infinity)
//                            Spacer()
//                        }
//                    }
//                    .sheet(isPresented: $showOnboarding) {
//                        OnboardingView()
//                    }
//                }
//                
//                Section {
//                    Button(action: {
//                        if let url = URL(string: "https://quicknote.io/bf62bdc0-865b-11ef-b7ad-0744ed0631cf") {
//                            UIApplication.shared.open(url)
//                        }
//                    }) {
//                        HStack {
//                            Spacer()
//                            Text("Privacy Policy")
//                                .frame(maxWidth: .infinity)
//                            Spacer()
//                        }
//                    }
//                }
//            }
            .navigationTitle("Settings")
        }
    }
    
//    func switchAppearanceMode(_ mode: Int) {
//        switch mode {
//        case 1:
//            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
//        case 2:
//            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
//        default:
//            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .unspecified
//        }
//    }
}

extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return self.connectedScenes
        // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
        // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
        // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
        // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}
