//
//  TripCardView.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/5/24.
//

import UIKit

class UpcomingTripsCardView: UIView {
            
    var profileImageView: UIImageView!
    var locationLabel: UILabel!
    var dateLabel: UILabel!
    var detailsButton: UIButton!
        
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
        
        locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(locationLabel)
        
        dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dateLabel)
        
        detailsButton = UIButton(type: .system)
        detailsButton.setTitle("Ride Details", for: .normal)
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(detailsButton)

        
        NSLayoutConstraint.activate([
            
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),

            locationLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 25),
            locationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            dateLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 25),
            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            
            detailsButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 25),
            detailsButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            detailsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
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
