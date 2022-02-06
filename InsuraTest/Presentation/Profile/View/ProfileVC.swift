//
//  ProfileVC.swift
//  InsuraTest
//
//  Created by Ivan Martin on 05/02/2022.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    // MARK: - Properties
    var coordinator: ProfileFlow?
    var viewModel: ProfileVM?
    
    lazy var child = LoadingView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.request()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI(){
        guard let userData = UserDataPreference().read() else { return }
        self.usernameLabel.text = userData.username
        self.emailLabel.text = userData.email
        self.addressLabel.text = userData.address.street
        self.phoneLabel.text = userData.phone
    }
    
    private func request(){
        self.showLoading()
        viewModel?.getUserProfile(completionHandler: { result in
            self.hideLoading()
            switch result{
            case .success(let model):
                DispatchQueue.main.async {
                    UserDataPreference().save(model: model)
                    self.setupUI()
                }
            case .failure(let err):
                self.showErrorMessage(message: err.errorDescription)
            }
        })
    }
    
    func showLoading(){
        //add the spinner view controller
        DispatchQueue.main.async {
            self.addChild(self.child)
            self.child.view.frame = self.view.frame
            self.view.addSubview(self.child.view)
            self.child.didMove(toParent: self)
        }
    }
    
    func hideLoading(){
        DispatchQueue.main.async {
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
        }
    }

}
