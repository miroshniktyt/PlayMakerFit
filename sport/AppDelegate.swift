//
//  AppDelegate.swift
//  AVSuperSpeed
//
//  Created by pc on 16.10.24.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set default values for UserDefaults if they don't exist
        if UserDefaults.standard.object(forKey: UserDefaultsKeys.soundEnabled) == nil {
            UserDefaults.standard.set(true, forKey: UserDefaultsKeys.soundEnabled)
        }
        
        // Store the dark mode preference
        UserDefaults.standard.set(true, forKey: "forceDarkMode")
        
        let hostingController = ViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = hostingController
        
        // Apply dark mode if preference is set
        if UserDefaults.standard.bool(forKey: "forceDarkMode") {
            window?.overrideUserInterfaceStyle = .dark
            window?.tintColor = .systemCyan
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentView = RootView()

        let hostingController = UIHostingController(rootView: contentView)

        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.frame = view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingController.didMove(toParent: self)
        
        overrideUserInterfaceStyle = .dark
        
        if let windowScene = view.window?.windowScene {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
                window.tintColor = .systemCyan
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let windowScene = view.window?.windowScene {
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
                window.tintColor = .systemCyan
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
                window.tintColor = .systemCyan
            }
        }
    }
    
//    func applyAppearanceMode() {
//        let w = UIApplication.shared.keyWindow
//        let v = UserDefaults.standard.integer(forKey: "appearanceMode")
//        switch v {
//        case 1:
//            w?.overrideUserInterfaceStyle = .light
//        case 2:
//            w?.overrideUserInterfaceStyle = .dark
//        default:
//            w?.overrideUserInterfaceStyle = .unspecified
//        }
//    }
}
