//
//  DetailCoordinator.swift
//  InsuraTest
//
//  Created by Ivan Martin on 06/02/2022.
//

import Foundation
import UIKit

protocol DetailFlow: AnyObject {
}

class DetailCoordinator: Coordinator, DetailFlow {
    
    var navigationController: UINavigationController
    var post: Post
    
    init(navigationController: UINavigationController, post: Post) {
        self.navigationController = navigationController
        self.post = post
    }
    
    func start() {
        let detailVC = DetailVC()
        detailVC.coordinator = self
        detailVC.viewModel = DetailVM()
        detailVC.post = post
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Flow Methods
}
