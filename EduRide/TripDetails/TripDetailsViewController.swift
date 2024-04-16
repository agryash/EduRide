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
            
            cardView.acceptButton.addTarget(self, action: #selector(acceptButtonTapped(_:)), for: .touchUpInside)
        }

        loadTrip()
    }
    
    func loadTrip() {
        DatabaseManager.shared.getTripDetails(tripID: tripId!) { (result: Result<Trip?, Error>) in
            switch result {
            case .success(let trip):
                if let trip = trip {
                    self.setupMapView(sourceLatitude: trip.sourceLatitude, destinationLatitude: trip.destinationLatitude, sourceLongitude: trip.sourceLongitude, destinationLongitude: trip.destinationLongitude)
                    self.tripDetails.driverCardView.mainDescriptionLabel.text = trip.userEmail
                } else {
                    print("Error: Trip not found")
                }
            case .failure(let error):
                print("Error fetching trip details: \(error.localizedDescription)")
            }
        }
    }
    
    func setupMapView(sourceLatitude: Double, destinationLatitude: Double, sourceLongitude: Double, destinationLongitude: Double) {
        tripDetails.mapView.spanBetweenLocations(sourceLatitude: sourceLatitude, destinationLatitude: destinationLatitude, sourceLongitude: sourceLongitude, destinationLongitude: destinationLongitude)
        let source = Place(
            title: "Source",
            coordinate: CLLocationCoordinate2D(latitude: sourceLatitude, longitude: sourceLongitude),
            info: "Start"
        )
        let destination = Place(
            title: "Destination",
            coordinate: CLLocationCoordinate2D(latitude: destinationLatitude, longitude: destinationLongitude),
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
}

