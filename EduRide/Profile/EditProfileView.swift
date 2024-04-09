//
//  EditProfileView.swift
//  EduRide
//
//  Created by Riya on 4/2/24.
//

import UIKit

class EditProfileView: UIView {

    var labelName: UILabel!
    var labelEmail: UILabel!
    var labelPassword: UILabel!
    var labelPhoneNumber: UILabel!
    var textFieldName: UITextField!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var textFieldNumber: UITextField!
    var buttonSignUp: UIButton!
    var profileImage: UIImageView!
    var choosePicButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelName()
        setupLabelEmail()
        setupLabelPassword()
        setupLabelPhoneNumber()
        setupTextFieldName()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupTextFieldNumber()
        setupButtonSignUp()
        setupImageView()
        setupChoosePicButton()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.text = "Name:"
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.text = "Email:"
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    
    func setupLabelPassword() {
        labelPassword = UILabel()
        labelPassword.text = "Phone Number:"
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPassword)
    }
    
    func setupLabelPhoneNumber() {
        labelPhoneNumber = UILabel()
        labelPhoneNumber.text = "Password:"
        labelPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPhoneNumber)
    }
    
    func setupTextFieldName() {
        textFieldName = UITextField()
        textFieldName.placeholder = "John Doe"
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        textFieldName.borderStyle = .roundedRect
        textFieldName.layer.borderWidth = 1.0
        textFieldName.layer.borderColor = UIColor.gray.cgColor
        textFieldName.layer.cornerRadius = 10.0
        textFieldName.layer.masksToBounds = true
        textFieldName.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(textFieldName)
    }
    
    func setupTextFieldEmail() {
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "johndoe@gmail.com"
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.layer.borderWidth = 1.0
        textFieldEmail.layer.borderColor = UIColor.gray.cgColor
        textFieldEmail.layer.cornerRadius = 10.0
        textFieldEmail.layer.masksToBounds = true
        textFieldEmail.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(textFieldEmail)
    }
    
    func setupTextFieldPassword() {
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "******"
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.layer.borderWidth = 1.0
        textFieldPassword.layer.borderColor = UIColor.gray.cgColor
        textFieldPassword.layer.cornerRadius = 10.0
        textFieldPassword.layer.masksToBounds = true
        textFieldPassword.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(textFieldPassword)
    }
    
    func setupTextFieldNumber() {
        textFieldNumber = UITextField()
        textFieldNumber.placeholder = "1234567890"
        textFieldNumber.translatesAutoresizingMaskIntoConstraints = false
        textFieldNumber.borderStyle = .roundedRect
        textFieldNumber.layer.borderWidth = 1.0
        textFieldNumber.layer.borderColor = UIColor.gray.cgColor
        textFieldNumber.layer.cornerRadius = 10.0
        textFieldNumber.layer.masksToBounds = true
        textFieldNumber.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(textFieldNumber)
    }
    
    func setupButtonSignUp() {
        buttonSignUp = UIButton(type: .system)
        buttonSignUp.setTitle("Save", for: .normal)
        buttonSignUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        buttonSignUp.setTitleColor(.white, for: .normal)
        buttonSignUp.translatesAutoresizingMaskIntoConstraints = false
        buttonSignUp.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        buttonSignUp.backgroundColor = .systemBlue
        buttonSignUp.layer.cornerRadius = 10
        
        buttonSignUp.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        self.addSubview(buttonSignUp)
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
    
    func setupChoosePicButton() {
        choosePicButton = UIButton(type: .system)
        choosePicButton.setTitle("Choose picture", for: .normal)
        choosePicButton.showsMenuAsPrimaryAction = true
        choosePicButton.translatesAutoresizingMaskIntoConstraints = false
        choosePicButton.translatesAutoresizingMaskIntoConstraints = false
        choosePicButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(choosePicButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            labelName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            textFieldName.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 16),
            textFieldName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            profileImage.topAnchor.constraint(equalTo: textFieldName.topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: textFieldName.trailingAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            
            choosePicButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
            choosePicButton.leadingAnchor.constraint(equalTo: textFieldName.trailingAnchor, constant: 16),
            choosePicButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            labelEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 16),
            labelEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            textFieldEmail.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 16),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -140),

            labelPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
            labelPassword.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            textFieldPassword.topAnchor.constraint(equalTo: labelPassword.bottomAnchor, constant: 16),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldPassword.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            labelPhoneNumber.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            labelPhoneNumber.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            textFieldNumber.topAnchor.constraint(equalTo: labelPhoneNumber.bottomAnchor, constant: 16),
            textFieldNumber.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldNumber.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
          
            buttonSignUp.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonSignUp.topAnchor.constraint(equalTo: textFieldNumber.bottomAnchor, constant: 30),
            buttonSignUp.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
}
