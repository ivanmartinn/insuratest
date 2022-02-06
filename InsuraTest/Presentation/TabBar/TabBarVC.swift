//
//  TabBarVC.swift
//  InsuraTest
//
//  Created by Ivan Martin on 05/02/2022.
//

import Foundation
import UIKit

class TabBarVC: UITabBarController {
    
    var coordinator: TabBarCoordinator?
    
    override func viewDidLoad() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barStyle = .black
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor(string: "007AFF")
        
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.tabBar.layer.shadowRadius = 10
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.masksToBounds = false
        
        self.tabBar.layer.borderWidth = 0.3
        self.tabBar.layer.borderColor = UIColor.lightGray.cgColor
        self.tabBar.clipsToBounds = true
    }
    
}
