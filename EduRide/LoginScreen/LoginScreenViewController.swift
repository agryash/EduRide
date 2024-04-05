//
//  LoginScreenViewController.swift
//  EduRide
//
//  Created by Abhisha Daine on 4/2/24.
//

import UIKit

class LoginScreenViewController: UIViewController {

    let  loginScreenView = LoginScreenView()

    
    override func loadView() {
        view = loginScreenView
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        loginScreenView.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
    }
    
    @objc func onLoginButtonTapped() {
        let tabBar = TabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
}
