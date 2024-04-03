//
//  CardView.swift
//  EduRide
//
//  Created by Riya on 4/3/24.
//

import UIKit

class CardView: UIView {
            
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
        mainDescriptionLabel = UILabel()
        mainDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainDescriptionLabel)
        
        acceptButton = UIButton(type: .system)
        acceptButton.setTitle("Profile", for: .normal)
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(acceptButton)
        
        rejectButton = UIButton(type: .system)
        rejectButton.setTitle("Message", for: .normal)
        rejectButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rejectButton)
        
        NSLayoutConstraint.activate([
            mainDescriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            acceptButton.topAnchor.constraint(equalTo: mainDescriptionLabel.bottomAnchor, constant: 16),
            acceptButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            acceptButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            rejectButton.topAnchor.constraint(equalTo: mainDescriptionLabel.bottomAnchor, constant: 16),
            rejectButton.leadingAnchor.constraint(equalTo: acceptButton.trailingAnchor, constant: 250),
            rejectButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
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
