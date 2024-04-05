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
    var uniLabel: UILabel!
    
    var acceptButton: UIButton!
    var rejectButton: UIButton!
    
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
        mainDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        mainDescriptionLabel.textColor = .black // Ensure text color is set to something visible
        mainDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainDescriptionLabel)
        
        uniLabel = UILabel()
        uniLabel.font = UIFont.systemFont(ofSize: 12)
        uniLabel.textColor = .darkGray
        uniLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(uniLabel)
        
        acceptButton = UIButton(type: .system)
        acceptButton.setTitle("Accept", for: .normal)
        acceptButton.backgroundColor = UIColor.systemBlue
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
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            
            mainDescriptionLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            mainDescriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            mainDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: acceptButton.topAnchor, constant: -8), // Ensure label is above buttons
            
            acceptButton.leadingAnchor.constraint(equalTo: mainDescriptionLabel.leadingAnchor),
            acceptButton.widthAnchor.constraint(equalToConstant: 80),
            acceptButton.heightAnchor.constraint(equalToConstant: 30),
            acceptButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16), // Constrain to bottom
            
            rejectButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rejectButton.widthAnchor.constraint(equalToConstant: 80),
            rejectButton.heightAnchor.constraint(equalToConstant: 30),
            rejectButton.bottomAnchor.constraint(equalTo: acceptButton.bottomAnchor), // Align bottom with accept button
        ])
    }
}
