//
//  AppDelegate.swift
//  InsuraTest
//
//  Created by Ivan Martin on 05/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        coordinator = AppCoordinator(window: window!)
        coordinator?.start()
        return true
    }
}

