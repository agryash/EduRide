//
//  TripDetailsViewController.swift
//  EduRide
//
//  Created by Riya on 4/3/24.
//

import UIKit
import MapKit

class TripDetailsViewController: UIViewController {
    
    let tripDetails = TripDetailsView()
    var tripId: String?
    var trip = [Trip]()
    
    override func loadView() {
        view = tripDetails
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trip Details"
        for (index, cardView) in tripDetails.coPassCardViews.enumerated() {
            cardView.acceptButton.tag = index
            cardView.rejectButton.tag = index
            
            cardView.acceptButton.addTarget(self, action: #selector(acceptButtonTapped(_:)), for: .touchUpInside)
            cardView.rejectButton.addTarget(self, action: #selector(rejectButtonTapped(_:)), for: .touchUpInside)
        }
        loadTrip()
        setupMapView()
    }
    
    func loadTrip() {
        
    }
    
    func setupMapView() {
        // TODO: Replace the source and destination coordinates based on the trip details
        tripDetails.mapView.spanBetweenLocations(sourceLatitude: 42.3435867, destinationLatitude: 42.9325459, sourceLongitude: -71.0892265, destinationLongitude: -71.3340346)
        let source = Place(
            title: "Source",
            coordinate: CLLocationCoordinate2D(latitude: 42.3435867, longitude: -71.0892265),
            info: "Start"
        )
        let destination = Place(
            title: "Destination",
            coordinate: CLLocationCoordinate2D(latitude: 42.9325459, longitude: -71.3340346),
            info: "End"
        )
        tripDetails.mapView.addAnnotation(source)
        tripDetails.mapView.addAnnotation(destination)
    }
    
    @objc func acceptButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let cardView = tripDetails.coPassCardViews[index]
        let title = cardView.mainDescriptionLabel.text
        
        print("Accept button tapped for co-passenger: \(title ?? "Unknown")")
    }
    
    @objc func rejectButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let cardView = tripDetails.coPassCardViews[index]
        let title = cardView.mainDescriptionLabel.text
        
        print("Reject button tapped for co-passenger: \(title ?? "Unknown")")
    }
}

