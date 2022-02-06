//
//  AppCoordinator.swift
//  InsuraTest
//
//  Created by Ivan Martin on 05/02/2022.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let startCoordinator = LoginCoordinator(navigationController: navigationController)
        coordinate(to: startCoordinator)
    }
}
