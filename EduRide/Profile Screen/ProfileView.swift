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
    var labelGender: UILabel!
    var labelBirthDate: UILabel!
    var labelNameValue: UILabel!
    var labelEmailValue: UILabel!
    var labelPasswordValue: UILabel!
    var labelPhoneNumberValue: UILabel!
    var labelGenderValue: UILabel!
    var labelBirthDateValue: UILabel!
    var profileImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelName()
        setupLabelEmail()
        setupLabelPassword()
        setupLabelPhoneNumber()
        setupLabelGender()
        setupLabelBirthDate()
        setupImageView()
        setupLabelNameValue()
        setupLabelEmailValue()
        setupLabelPasswordValue()
        setupLabelPhoneNumberValue()
        setupLabelGenderValue()
        setupLabelBirthDateValue()
        
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
    
    func setupLabelGender() {
        labelGender = UILabel()
        labelGender.text = "Gender:"
        labelGender.translatesAutoresizingMaskIntoConstraints = false
        labelGender.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(labelGender)
    }
    
    func setupLabelBirthDate() {
        labelBirthDate = UILabel()
        labelBirthDate.text = "Birth Date:"
        labelBirthDate.translatesAutoresizingMaskIntoConstraints = false
        labelBirthDate.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(labelBirthDate)
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
    
    func setupLabelGenderValue() {
        labelGenderValue = UILabel()
        labelGenderValue.text = "Male"
        labelGenderValue.translatesAutoresizingMaskIntoConstraints = false
        labelGenderValue.textColor = UIColor.darkGray
        self.addSubview(labelGenderValue)
    }
    
    func setupLabelBirthDateValue() {
        labelBirthDateValue = UILabel()
        labelBirthDateValue.text = "01/01/2000"
        labelBirthDateValue.translatesAutoresizingMaskIntoConstraints = false
        labelBirthDateValue.textColor = UIColor.darkGray
        self.addSubview(labelBirthDateValue)
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
            
            labelGender.topAnchor.constraint(equalTo: labelPhoneNumber.bottomAnchor, constant: 20),
            labelGender.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                
            labelGenderValue.topAnchor.constraint(equalTo: labelPhoneNumber.bottomAnchor, constant: 20),
            labelGenderValue.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 190),
                
            labelBirthDate.topAnchor.constraint(equalTo: labelGender.bottomAnchor, constant: 20),
            labelBirthDate.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            labelBirthDateValue.topAnchor.constraint(equalTo: labelGender.bottomAnchor, constant: 20),
            labelBirthDateValue.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 190),
        ])
    }
}
