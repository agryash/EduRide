//
//  MainScreenView.swift
//  EduRide
//
//  Created by Abhisha Daine on 4/2/24.
//

import UIKit

class MainScreenView: UIView {

    var logoImage: UIImageView!
    var appNameLabel:UILabel!
    var signUpButton:UIButton!
    var loginButton:UIButton!
    var newUserLabel:UILabel!


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLogoImage()
        setupAppName()
        setupLoginButton()
        setupNewUserLabel()
        setupSignUpButton()

        initConstraints()
    }
    
    func setupLogoImage(){
        
        logoImage = UIImageView()
        logoImage.contentMode = .scaleAspectFit
        logoImage.image = UIImage(named: "Logo")
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoImage)
       
    }
    
    func setupAppName(){
        appNameLabel = UILabel()
        appNameLabel.text = "EduRide"
        appNameLabel.font = UIFont.boldSystemFont(ofSize: 54)
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(appNameLabel)

    }
    
    func setupLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.backgroundColor = UIColor.systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        loginButton.layer.cornerRadius = 16 // Adjust the corner radius as needed for the desired roundness
        loginButton.setTitle("Log in", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginButton)
    }
    
    func setupNewUserLabel(){
        newUserLabel = UILabel()
        newUserLabel.text = "New user? Sign up below"
        newUserLabel.font = UIFont.boldSystemFont(ofSize: 14)
        newUserLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(newUserLabel)

    }
    
    func setupSignUpButton() {
        signUpButton = UIButton(type: .system)
        signUpButton.backgroundColor = UIColor.systemBlue
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        signUpButton.layer.cornerRadius = 16 // Adjust the corner radius as needed for the desired roundness
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(signUpButton)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate(
            [
                
                logoImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 64),
                logoImage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                logoImage.widthAnchor.constraint(equalToConstant: 250),
                logoImage.heightAnchor.constraint(equalToConstant: 250),
                
                appNameLabel.topAnchor.constraint(equalTo: logoImage.safeAreaLayoutGuide.bottomAnchor, constant: 24),
                appNameLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                                
                loginButton.topAnchor.constraint(equalTo: appNameLabel.safeAreaLayoutGuide.bottomAnchor, constant: 64),
                loginButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                loginButton.widthAnchor.constraint(equalToConstant: 150), // Width constraint set to 100

                newUserLabel.topAnchor.constraint(equalTo: loginButton.safeAreaLayoutGuide.bottomAnchor, constant: 24),
                newUserLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                
                signUpButton.topAnchor.constraint(equalTo: newUserLabel.safeAreaLayoutGuide.bottomAnchor, constant: 24),
                signUpButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                signUpButton.widthAnchor.constraint(equalToConstant: 150), // Width constraint set to 100

                
            ]
        )

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
