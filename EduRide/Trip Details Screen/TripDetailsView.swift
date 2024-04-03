//
//  TripDetailsView.swift
//  EduRide
//
//  Created by Riya on 4/3/24.
//

import UIKit

class TripDetailsView: UIView {
    
    let databaseValues: [String] = ["Item 1", "Item 2", "Item 3"]
    var coPassCardViews: [CardView] = []
    var labelDriver: UILabel!
    var labelCoPassengers: UILabel!
    var driverCardView = CardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelDriver()
        setupLabelCoPassengers()
        setupDriverCardView()
        setupCoPassengerCardView()
                
        initConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDriverCardView() {
        driverCardView = CardView()
        driverCardView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(driverCardView)
        driverCardView.mainDescriptionLabel.text = "John Doe"
    }
    
    func setupCoPassengerCardView() {
        for value in self.databaseValues {
            let coPassCardView = CardView()
            coPassCardView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(coPassCardView)
            
            coPassCardView.mainDescriptionLabel.text = value
            
            coPassCardViews.append(coPassCardView)
        }
        layoutCardViews()
    }
    
    func setupLabelDriver() {
        labelDriver = UILabel()
        labelDriver.text = "Driver"
        labelDriver.font = UIFont.boldSystemFont(ofSize: 16)
        labelDriver.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDriver)
    }
    
    func setupLabelCoPassengers() {
        labelCoPassengers = UILabel()
        labelCoPassengers.text = "Co-Passengers"
        labelCoPassengers.font = UIFont.boldSystemFont(ofSize: 16)
        labelCoPassengers.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelCoPassengers)
    }
    
    func layoutCardViews() {
        var previousCardView: UIView?
        for cardView in coPassCardViews {
            NSLayoutConstraint.activate([
                cardView.topAnchor.constraint(equalTo: previousCardView?.bottomAnchor ?? labelCoPassengers.bottomAnchor, constant: 16),
                cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
            
            previousCardView = cardView
        }
    }
    
    func initConstraints() {
            NSLayoutConstraint.activate([
                labelDriver.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
                labelDriver.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),

                driverCardView.topAnchor.constraint(equalTo: labelDriver.bottomAnchor, constant: 16),
                driverCardView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                driverCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                
                labelCoPassengers.topAnchor.constraint(equalTo: driverCardView.bottomAnchor, constant: 20),
                labelCoPassengers.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            ])
    }
}

