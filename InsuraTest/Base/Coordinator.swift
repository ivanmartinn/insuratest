//
//  Coordinator.swift
//  InsuraTest
//
//  Created by Ivan Martin on 05/02/2022.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
