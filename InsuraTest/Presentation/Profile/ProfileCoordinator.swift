//
//  ProfileCoordinator.swift
//  InsuraTest
//
//  Created by Ivan Martin on 05/02/2022.
//

import Foundation
import UIKit

protocol ProfileFlow: AnyObject {
}

class ProfileCoordinator: Coordinator, ProfileFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let profileVC = ProfileVC()
        profileVC.coordinator = self
        profileVC.viewModel = ProfileVM()
        navigationController?.pushViewController(profileVC, animated: false)
    }
    
    // MARK: - Flow Methods
//    func coordinateToDetail() {
//        let topRatedDetailCoordinator = TopRatedDetailCoordinator(navigationController: navigationController!)
//        coordinate(to: topRatedDetailCoordinator)
//    }
}
