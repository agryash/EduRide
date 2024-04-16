//
//  TripDetailsView.swift
//  EduRide
//
//  Created by Riya on 4/3/24.
//

import UIKit
import MapKit

class TripDetailsView: UIView {
    
    var databaseValues: [String] = []
    var coPassCardViews: [CardView] = []
    var labelDriver: UILabel!
    var labelCoPassengers: UILabel!
    var driverCardView = CardView()
    var mapView: MKMapView!
    var contentWrapper: UIScrollView!
    var sourceDestLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupLabelDriver()
        setupLabelCoPassengers()
        setupLabelSourceDest()
        setupDriverCardView()
        setupCoPassengerCardView()
        setupMapview()
        initConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.alwaysBounceVertical = true
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupDriverCardView() {
        driverCardView = CardView()
        driverCardView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(driverCardView)
    }
    
    func setupCoPassengerCardView() {
        for (index, value) in self.databaseValues.enumerated() {
            let coPassCardView = CardView()
            coPassCardView.translatesAutoresizingMaskIntoConstraints = false
            contentWrapper.addSubview(coPassCardView)
            
            coPassCardView.mainDescriptionLabel.text = value
            
            coPassCardView.acceptButton.tag = index
                    
            coPassCardViews.append(coPassCardView)
        }
    }
    
    func updateCoPassengerCardViews(completion: @escaping () -> Void) {
        for cardView in coPassCardViews {
            cardView.removeFromSuperview()
        }
        coPassCardViews.removeAll()
        
        setupCoPassengerCardView()
        
        initConstraints()
        completion()
    }
    
    func setupLabelSourceDest() {
        sourceDestLabel = UILabel()
        sourceDestLabel.text = "Source --> Destination"
        sourceDestLabel.font = UIFont.boldSystemFont(ofSize: 16)
        sourceDestLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(sourceDestLabel)
    }
    
    func setupLabelDriver() {
        labelDriver = UILabel()
        labelDriver.text = "Driver"
        labelDriver.font = UIFont.boldSystemFont(ofSize: 16)
        labelDriver.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelDriver)
    }
    
    func setupLabelCoPassengers() {
        labelCoPassengers = UILabel()
        labelCoPassengers.text = "Co-Passengers"
        labelCoPassengers.font = UIFont.boldSystemFont(ofSize: 16)
        labelCoPassengers.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelCoPassengers)
    }
      
    func setupMapview() {
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 10
        contentWrapper.addSubview(mapView)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            contentWrapper.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            mapView.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 8),
            mapView.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            mapView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            
            sourceDestLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16),
            sourceDestLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            
            labelDriver.topAnchor.constraint(equalTo: sourceDestLabel.bottomAnchor, constant: 30),
            labelDriver.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),

            driverCardView.topAnchor.constraint(equalTo: labelDriver.bottomAnchor, constant: 16),
            driverCardView.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
            driverCardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            labelCoPassengers.topAnchor.constraint(equalTo: driverCardView.bottomAnchor, constant: 20),
            labelCoPassengers.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
        ])
        
        var previousCardView: UIView = labelCoPassengers
        for cardView in coPassCardViews {
            NSLayoutConstraint.activate([
                cardView.topAnchor.constraint(equalTo: previousCardView.bottomAnchor, constant: 16),
                cardView.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 16),
                cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            ])
            previousCardView = cardView
        }
        
        if let lastCardView = coPassCardViews.last {
            NSLayoutConstraint.activate([
                lastCardView.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -16)
            ])
        }
    }
}

