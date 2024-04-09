//
//  ViewController.swift
//  EduRide
//
//  Created by Yash Agrawal on 3/1/24.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    let mainScreenView = MainScreenView()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    
    override func loadView() {
        view = mainScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        mainScreenView.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        mainScreenView.signUpButton.addTarget(self, action: #selector(onSignupButtonTapped), for: .touchUpInside)
        
        handleAuth = Auth.auth().addStateDidChangeListener{auth, user in
            if user == nil {
                
            } else {
                self.currentUser = user
                let tabBar = TabBarController()
                tabBar.modalPresentationStyle = .fullScreen
                self.present(tabBar, animated: true)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
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

