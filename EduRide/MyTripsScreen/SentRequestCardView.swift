//
//  SentRequestCardView.swift
//  EduRide
//
//  Created by Abhisha Daine on 4/4/24.
//

import UIKit

class SentRequestCardView: UIView {
    
    var profileImageView: UIImageView!
    var mainDescriptionLabel: UILabel!
    var approvalLabel: UILabel!
    var separatorView: UIView!
    
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
        
        separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separatorView)
        
        approvalLabel = UILabel()
        approvalLabel.text = "Pending Approval"
        approvalLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(approvalLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            
            mainDescriptionLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            mainDescriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            separatorView.leadingAnchor.constraint(equalTo: mainDescriptionLabel.leadingAnchor),
            separatorView.topAnchor.constraint(equalTo: mainDescriptionLabel.bottomAnchor, constant: 8),
            separatorView.trailingAnchor.constraint(equalTo: mainDescriptionLabel.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1), // Height for the separator line
            
            approvalLabel.leadingAnchor.constraint(equalTo: mainDescriptionLabel.leadingAnchor),
            approvalLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 8),
            approvalLabel.trailingAnchor.constraint(equalTo: mainDescriptionLabel.trailingAnchor),
            approvalLabel.heightAnchor.constraint(equalToConstant: 40),
            
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
