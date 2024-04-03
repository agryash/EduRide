//
//  LoginScreenView.swift
//  EduRide
//
//  Created by Abhisha Daine on 4/2/24.
//

import UIKit

class LoginScreenView: UIView {

    var loginImage: UIImageView!

    var emailLabel:UILabel!
    var passwordLabel:UILabel!
    
    var emailText:UITextField!
    var passwordText:UITextField!
    
    var loginButton:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLogoImage()
        
        setupEmailLabel()
        setupPasswordLabel()
        
        setupEmailText()
        setupPasswordText()
        
        setupLoginButton()

        initConstraints()
    }
    
    func setupLogoImage(){
        
        loginImage = UIImageView()
        loginImage.contentMode = .scaleAspectFit
        loginImage.image = UIImage(named: "Login")
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginImage)
       
    }
    
    
    func setupEmailLabel(){
        emailLabel = UILabel()
        emailLabel.text = "Email "
        emailLabel.font = UIFont.boldSystemFont(ofSize: emailLabel.font.pointSize)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailLabel)
    }
    
    func setupPasswordLabel(){
        passwordLabel = UILabel()
        passwordLabel.text = "Password "
        passwordLabel.font = UIFont.boldSystemFont(ofSize: passwordLabel.font.pointSize)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordLabel)

    }
    func setupEmailText(){
        emailText = UITextField()
        emailText.placeholder = "email@gmail.com"
        emailText.borderStyle = .roundedRect
        emailText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailText)

    }
    func setupPasswordText(){
        passwordText = UITextField()
        passwordText.placeholder = "password"
        passwordText.borderStyle = .roundedRect
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordText)
    }
    func setupLoginButton(){
        loginButton = UIButton(type: .system)
        loginButton.backgroundColor = UIColor.systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        loginButton.layer.cornerRadius = 16 // Adjust the corner radius as needed for the desired roundness
        loginButton.setTitle("Log in", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginButton)
    }
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            loginImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            loginImage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            loginImage.widthAnchor.constraint(equalToConstant: 200),
            loginImage.heightAnchor.constraint(equalToConstant: 200),
            
            
            emailLabel.topAnchor.constraint(equalTo: loginImage.safeAreaLayoutGuide.bottomAnchor, constant: 32),
            emailLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        
            emailText.topAnchor.constraint(equalTo: emailLabel.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            emailText.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            emailText.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -60),

            
            passwordLabel.topAnchor.constraint(equalTo: emailText.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            passwordLabel.leadingAnchor.constraint(equalTo: emailText.leadingAnchor),
            
            passwordText.topAnchor.constraint(equalTo: passwordLabel.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            passwordText.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor),
            passwordText.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -60),

            
            loginButton.topAnchor.constraint(equalTo: passwordText.safeAreaLayoutGuide.bottomAnchor, constant: 32),
            loginButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 150), // Width constraint set to 100

        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
