//
//  HomeCoordinator.swift
//  InsuraTest
//
//  Created by Ivan Martin on 05/02/2022.
//

import Foundation
import UIKit

protocol HomeFlow: AnyObject {
    func coordinateToDetail(post: Post)
}

class HomeCoordinator: Coordinator, HomeFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = HomeVC()
        homeVC.coordinator = self
        homeVC.viewModel = HomeVM()
        navigationController?.pushViewController(homeVC, animated: false)
    }
    
    // MARK: - Flow Methods
    func coordinateToDetail(post: Post) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController!, post: post)
        coordinate(to: detailCoordinator)
    }
}
