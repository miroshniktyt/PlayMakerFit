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
        
        let hostingController = ViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = hostingController
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
        
        UserDefaults.standard.register(defaults: ["appearanceMode" : 2])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        applyAppearanceMode()
    }
    
    func applyAppearanceMode() {
        let w = UIApplication.shared.keyWindow
        let v = UserDefaults.standard.integer(forKey: "appearanceMode")
        switch v {
        case 1:
            w?.overrideUserInterfaceStyle = .light
        case 2:
            w?.overrideUserInterfaceStyle = .dark
        default:
            w?.overrideUserInterfaceStyle = .unspecified
        }
    }
}
