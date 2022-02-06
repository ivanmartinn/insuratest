//
//  UIViewController+extension.swift
//  InsuraTest
//
//  Created by Ivan Martin on 06/02/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func setupHideKeyboardWhenTappedAround() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissThisKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissThisKeyboard() {
        view.endEditing(true)
    }
    
    func showErrorMessage(message: String) {
        DispatchQueue.main.async {
            let notificationBanner =  NotificationBanner(superview: self)
            notificationBanner.show(message)
        }
    }
    
    func showSuccessMessage(message: String) {
        DispatchQueue.main.async {
            let notificationBanner =  NotificationBanner(superview: self)
            notificationBanner.show(message,success: true)
        }
    }
}
