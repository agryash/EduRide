//
//  UpcomingTripsCardView.swift
//  EduRide
//
//  Created by Abhisha Daine on 4/14/24.
//

import UIKit

class UpcomingTripsCardView: UIView {

    var profileImageView: UIImageView!
    var dateLabel: UILabel!
    var locationLabel: UILabel!
    
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
        
        dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        dateLabel.textColor = .black // Ensure text color is set to something visible
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dateLabel)
        
        locationLabel = UILabel()
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.textColor = .darkGray
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(locationLabel)
        
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
            dateLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: chatButton.leadingAnchor, constant: -8), // Ensure spacing to chat button

            // Location Label constraints
            locationLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),

        ])
    }
    
    
    

}
