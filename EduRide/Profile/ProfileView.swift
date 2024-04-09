//
//  ProfileView.swift
//  EduRide
//
//  Created by Riya on 4/2/24.
//

import UIKit

class ProfileView: UIView {
    
    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelPassword: UILabel!
    var labelPhoneNumber: UILabel!
    var labelRole: UILabel!
    var labelNameValue: UILabel!
    var labelEmailValue: UILabel!
    var labelPasswordValue: UILabel!
    var labelPhoneNumberValue: UILabel!
    var labelRoleValue: UILabel!
    var profileImage: UIImageView!
    var logoutButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelName()
        setupLabelEmail()
        setupLabelPassword()
        setupLabelPhoneNumber()
        setupLabelRole()
        setupImageView()
        setupLabelNameValue()
        setupLabelEmailValue()
        setupLabelPasswordValue()
        setupLabelPhoneNumberValue()
        setupLabelRoleValue()
        setupButtonLogout()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.text = "Name:"
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(labelName)
    }
    
    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.text = "Email:"
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        labelEmail.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(labelEmail)
    }
    
    func setupLabelPassword() {
        labelPassword = UILabel()
        labelPassword.text = "Password:"
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        labelPassword.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(labelPassword)
    }
    
    func setupLabelPhoneNumber() {
        labelPhoneNumber = UILabel()
        labelPhoneNumber.text = "Phone Number:"
        labelPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        labelPhoneNumber.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(labelPhoneNumber)
    }
    
    func setupLabelRole() {
        labelRole = UILabel()
        labelRole.text = "Role:"
        labelRole.translatesAutoresizingMaskIntoConstraints = false
        labelRole.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(labelRole)
    }
        
    func setupImageView() {
        profileImage = UIImageView()
        profileImage.image = UIImage(systemName: "person.fill")
        profileImage.tintColor = .black
        profileImage.contentMode = .scaleToFill
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 10
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileImage)
    }
    
    func setupLabelNameValue() {
        labelNameValue = UILabel()
        labelNameValue.text = "John Doe"
        labelNameValue.translatesAutoresizingMaskIntoConstraints = false
        labelNameValue.textColor = UIColor.darkGray
        self.addSubview(labelNameValue)
    }
    
    func setupLabelEmailValue() {
        labelEmailValue = UILabel()
        labelEmailValue.text = "johndoe@gmail.com"
        labelEmailValue.translatesAutoresizingMaskIntoConstraints = false
        labelEmailValue.textColor = UIColor.darkGray
        self.addSubview(labelEmailValue)
    }
    
    func setupLabelPasswordValue() {
        labelPasswordValue = UILabel()
        labelPasswordValue.text = "******"
        labelPasswordValue.translatesAutoresizingMaskIntoConstraints = false
        labelPasswordValue.textColor = UIColor.darkGray
        self.addSubview(labelPasswordValue)
    }
    
    func setupLabelPhoneNumberValue() {
        labelPhoneNumberValue = UILabel()
        labelPhoneNumberValue.text = "1234567890"
        labelPhoneNumberValue.translatesAutoresizingMaskIntoConstraints = false
        labelPhoneNumberValue.textColor = UIColor.darkGray
        self.addSubview(labelPhoneNumberValue)
    }
    
    func setupLabelRoleValue() {
        labelRoleValue = UILabel()
        labelRoleValue.text = "Passenger"
        labelRoleValue.translatesAutoresizingMaskIntoConstraints = false
        labelRoleValue.textColor = UIColor.darkGray
        self.addSubview(labelRoleValue)
    }
    
    func setupButtonLogout() {
        logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        logoutButton.backgroundColor = .systemBlue
        logoutButton.layer.cornerRadius = 10
        
        logoutButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        self.addSubview(logoutButton)
    }
    
    func initConstraints() {
        
        NSLayoutConstraint.activate([
            
            profileImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            
            labelName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 50),
            labelName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            labelNameValue.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 50),
            labelNameValue.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 190),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 20),
            labelEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            labelEmailValue.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 20),
            labelEmailValue.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 190),
            
            labelPassword.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 20),
            labelPassword.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            labelPasswordValue.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 20),
            labelPasswordValue.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 190),

            labelPhoneNumber.topAnchor.constraint(equalTo: labelPassword.bottomAnchor, constant: 20),
            labelPhoneNumber.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            labelPhoneNumberValue.topAnchor.constraint(equalTo: labelPassword.bottomAnchor, constant: 20),
            labelPhoneNumberValue.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 190),
            
            labelRole.topAnchor.constraint(equalTo: labelPhoneNumber.bottomAnchor, constant: 20),
            labelRole.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                
            labelRoleValue.topAnchor.constraint(equalTo: labelPhoneNumber.bottomAnchor, constant: 20),
            labelRoleValue.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 190),
            
            logoutButton.topAnchor.constraint(equalTo: labelRoleValue.bottomAnchor, constant: 30),
            logoutButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant:
            16),
            
        ])
    }
}
