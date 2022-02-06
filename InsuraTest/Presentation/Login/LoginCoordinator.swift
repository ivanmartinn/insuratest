//
//  LoginCoordinator.swift
//  InsuraTest
//
//  Created by Ivan Martin on 05/02/2022.
//

import Foundation
import UIKit

protocol LoginFlow: AnyObject {
    func coordinateToTabBar()
}

class LoginCoordinator: Coordinator, LoginFlow {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginVC()
        loginVC.coordinator = self
        loginVC.viewModel = LoginVM()
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    // MARK: - Flow Methods
    func coordinateToTabBar() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: tabBarCoordinator)
    }
}
