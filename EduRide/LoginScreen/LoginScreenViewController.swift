//
//  LoginScreenViewController.swift
//  EduRide
//
//  Created by Abhisha Daine on 4/2/24.
//

import UIKit
import FirebaseAuth

class LoginScreenViewController: UIViewController {

    let loginScreenView = LoginScreenView()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?

    override func loadView() {
        view = loginScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginScreenView.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
    }
    
    @objc func onLoginButtonTapped() {
        if let email = loginScreenView.emailText.text?.lowercased(), !email.isEmpty,
           let password = loginScreenView.passwordText.text, !password.isEmpty {
            if (isValidEmail(email)) {
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
                    guard let self = self else { return }
                    if let error = error {
                        showInvalidErrorAlert(message: error.localizedDescription)
                    } else {
                        let tabBar = TabBarController()
                        self.clearAddViewFields()
                        tabBar.modalPresentationStyle = .fullScreen
                                present(tabBar, animated: true)
                        //self.navigationController?.pushViewController(tabBar, animated: true)
                    }
                }
            } else {
                showInvalidErrorAlert(message: "Invalid Email id")
            }
        } else {
            showErrorAlert()
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(
            title: "Error!", message: "Text Fields must not be empty!",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showInvalidErrorAlert(message: String) {
        let alert = UIAlertController(
            title: "Error!", message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

    func clearAddViewFields(){
        loginScreenView.emailText.text = ""
        loginScreenView.passwordText.text = ""
    }
}
