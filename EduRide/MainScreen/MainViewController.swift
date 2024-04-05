//
//  ViewController.swift
//  EduRide
//
//  Created by Yash Agrawal on 3/1/24.
//

import UIKit

class MainViewController: UIViewController {
    
    let mainScreenView = MainScreenView()
    
    override func loadView() {
        view = mainScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainScreenView.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        mainScreenView.signUpButton.addTarget(self, action: #selector(onSignupButtonTapped), for: .touchUpInside)
        
    }
    
    
    @objc func onLoginButtonTapped(){
        let loginScreenViewController = LoginScreenViewController()
        navigationController?.pushViewController(loginScreenViewController, animated: true)
    }
    
    @objc func onSignupButtonTapped(){
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}

