//
//  TripCardView.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/5/24.
//

import UIKit

class TripCardView: UIView {
            
    var profileImageView: UIImageView!
    var nameLabel: UILabel!
    var priceLabel: UILabel!
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
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        
        priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(priceLabel)
        
        acceptButton = UIButton(type: .system)
        acceptButton.setTitle("Book Ride", for: .normal)
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(acceptButton)
        
        rejectButton = UIButton(type: .system)
        rejectButton.setTitle("Ride Details", for: .normal)
        rejectButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rejectButton)
        
        NSLayoutConstraint.activate([
            
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),

            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 30),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 30),
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            acceptButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 30),
            acceptButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
        
            rejectButton.topAnchor.constraint(equalTo: acceptButton.topAnchor),
            rejectButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
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
