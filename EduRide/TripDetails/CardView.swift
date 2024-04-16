//
//  CardView.swift
//  EduRide
//
//  Created by Riya on 4/3/24.
//

import UIKit

class CardView: UIView {
            
    var profileImageView: UIImageView!
    var mainDescriptionLabel: UILabel!
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
        
        profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person.fill")
        profileImageView.tintColor = .black
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 10
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileImageView)
        
        mainDescriptionLabel = UILabel()
        mainDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainDescriptionLabel)
        
        acceptButton = UIButton(type: .system)
        acceptButton.setTitle("Message", for: .normal)
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(acceptButton)
        
        NSLayoutConstraint.activate([
            
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),

            mainDescriptionLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            mainDescriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            acceptButton.leadingAnchor.constraint(equalTo: mainDescriptionLabel.leadingAnchor),
            acceptButton.topAnchor.constraint(equalTo: mainDescriptionLabel.bottomAnchor, constant: 16),
            acceptButton.widthAnchor.constraint(equalToConstant: 100),
            acceptButton.heightAnchor.constraint(equalToConstant: 40),
            
            widthAnchor.constraint(equalToConstant: 300)
        ])
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
}
