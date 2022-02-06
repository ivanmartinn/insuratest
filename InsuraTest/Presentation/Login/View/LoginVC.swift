//
//  LoginVC.swift
//  InsuraTest
//
//  Created by Ivan Martin on 05/02/2022.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Properties
    var coordinator: LoginFlow?
    var viewModel: LoginVM?
    
    lazy var child = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHideKeyboardWhenTappedAround()
        setupUI()
    }
    
    private func setupUI(){
        self.usernameTextField.layer.borderWidth = 1
        self.usernameTextField.layer.borderColor = UIColor(string: "007AFF").cgColor
        self.usernameTextField.layer.cornerRadius = 10
        
        self.passwordTextField.layer.borderWidth = 1
        self.passwordTextField.layer.borderColor = UIColor(string: "007AFF").cgColor
        self.passwordTextField.layer.cornerRadius = 10
        
        self.loginButton.layer.cornerRadius = 10
        
        self.usernameTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        
        self.enableLoginButton(false)
    }
    
    @objc func textFieldDidChange(sender: UITextField){
        var validated = true
        if self.usernameTextField.text?.isEmpty == true || self.passwordTextField.text?.isEmpty == true {
            validated = false
        }
        self.enableLoginButton(validated)
    }
    
    private func enableLoginButton(_ bool: Bool){
        self.loginButton.isUserInteractionEnabled = bool
        self.loginButton.backgroundColor = bool ? UIColor(string: "007AFF") : UIColor.gray
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        guard let username = self.usernameTextField.text else { return }
        self.showLoading()
        viewModel?.getUsers(completionHandler: { result in
            self.hideLoading()
            switch result{
            case .success(let model):
                self.checkUser(model: model, username: username)
            case .failure(let err):
                self.showErrorMessage(message: err.errorDescription)
            }
        })
    }
    
    private func checkUser(model: UserResponseModel, username: String){
        let users = model.filter({ $0.username.lowercased() == username.lowercased() })
        if let user = users.first {
            DispatchQueue.main.async {
                UserDataPreference().save(model: user)
                self.coordinator?.coordinateToTabBar()
            }
        }else{
            self.showErrorMessage(message: "User not found")
        }
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
