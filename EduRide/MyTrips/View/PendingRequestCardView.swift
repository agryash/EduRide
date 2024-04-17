//
//  PendingRequestCardView.swift
//  EduRide
//
//  Created by Abhisha Daine on 4/4/24.
//

import UIKit

class PendingRequestCardView: UIView {
    
    var profileImageView: UIImageView!
    var mainDescriptionLabel: UILabel!
    var locationLabel: UILabel!
    
    var acceptButton: UIButton!
    var rejectButton: UIButton!
    var chatButton: UIButton!  // Adding the chat button
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCard()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCard()
    }
    
    private func setupCard() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(systemName: "person.fill")
        profileImageView.layer.cornerRadius = 35 // Assuming your image view is 70x70
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        addSubview(profileImageView)
        
        mainDescriptionLabel = UILabel()
        mainDescriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        mainDescriptionLabel.textColor = .black // Ensure text color is set to something visible
        mainDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainDescriptionLabel)
        
        locationLabel = UILabel()
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.textColor = .darkGray
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(locationLabel)
        
        acceptButton = UIButton(type: .system)
        acceptButton.setTitle("Accept", for: .normal)
        acceptButton.backgroundColor = UIColor.systemGreen
        acceptButton.setTitleColor(.white, for: .normal)
        acceptButton.layer.cornerRadius = 10
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(acceptButton)
        
        rejectButton = UIButton(type: .system)
        rejectButton.setTitle("Reject", for: .normal)
        rejectButton.backgroundColor = UIColor.systemRed
        rejectButton.setTitleColor(.white, for: .normal)
        rejectButton.layer.cornerRadius = 10
        rejectButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rejectButton)
        
        
        chatButton = UIButton(type: .system)
        let systemImage = UIImage(systemName: "message.fill")
        chatButton.setImage(systemImage, for: .normal)
        chatButton.tintColor = UIColor.systemBlue
        chatButton.imageView?.contentMode = .scaleAspectFit
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chatButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Profile Image View constraints
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            
            // Main Description Label constraints
            mainDescriptionLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            mainDescriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: chatButton.leadingAnchor, constant: -8), // Ensure spacing to chat button

            
            chatButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            chatButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            chatButton.widthAnchor.constraint(equalToConstant: 40),  // Adjust size as needed
            chatButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Location Label constraints
            locationLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            locationLabel.topAnchor.constraint(equalTo: mainDescriptionLabel.bottomAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            
            // Accept Button constraints
            acceptButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            acceptButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            acceptButton.widthAnchor.constraint(equalToConstant: 80),
            acceptButton.heightAnchor.constraint(equalToConstant: 30),
            acceptButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16),
            
            // Reject Button constraints
            rejectButton.leadingAnchor.constraint(equalTo: acceptButton.trailingAnchor, constant: 32),
            rejectButton.bottomAnchor.constraint(equalTo: acceptButton.bottomAnchor),
            rejectButton.widthAnchor.constraint(equalToConstant: 80),
            rejectButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    
    
}
