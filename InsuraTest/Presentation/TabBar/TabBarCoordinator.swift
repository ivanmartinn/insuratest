//
//  TabBarCoordinator.swift
//  InsuraTest
//
//  Created by Ivan Martin on 05/02/2022.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarVC()
        tabBarController.coordinator = self
        
        let homeNavigationController = UINavigationController()
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController)
        
        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        
        tabBarController.viewControllers = [homeNavigationController,
                                            profileNavigationController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: true, completion: nil)
        
        coordinate(to: homeCoordinator)
        coordinate(to: profileCoordinator)
    }

}
