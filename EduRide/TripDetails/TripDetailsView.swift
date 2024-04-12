//
//  TripDetailsView.swift
//  EduRide
//
//  Created by Riya on 4/3/24.
//

import UIKit
import MapKit

class TripDetailsView: UIView {
    
    let databaseValues: [String] = ["Item 1", "Item 2", "Item 3"]
    var coPassCardViews: [CardView] = []
    var labelDriver: UILabel!
    var labelCoPassengers: UILabel!
    var driverCardView = CardView()
    var mapView:MKMapView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelDriver()
        setupLabelCoPassengers()
        setupDriverCardView()
        setupCoPassengerCardView()
        setupMapview()
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
        for (index, value) in self.databaseValues.enumerated() {
            let coPassCardView = CardView()
            coPassCardView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(coPassCardView)
            
            coPassCardView.mainDescriptionLabel.text = value
            
            coPassCardView.acceptButton.tag = index
            coPassCardView.rejectButton.tag = index
                    
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
    
    func setupMapview() {
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 10
        self.addSubview(mapView)
    }
    
    func initConstraints() {
            NSLayoutConstraint.activate([
                mapView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
                mapView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                mapView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                mapView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
                
                labelDriver.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 30),
                labelDriver.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),

                driverCardView.topAnchor.constraint(equalTo: labelDriver.bottomAnchor, constant: 16),
                driverCardView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                driverCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                
                labelCoPassengers.topAnchor.constraint(equalTo: driverCardView.bottomAnchor, constant: 20),
                labelCoPassengers.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                
                
            ])
    }
}

