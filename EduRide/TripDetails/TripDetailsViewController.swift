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
    var emailAddresses: [String] = []
    
    override func loadView() {
        view = tripDetails
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trip Details"
        loadTrip()
    }
    
    func addButtonAction() {
        for (index, cardView) in tripDetails.coPassCardViews.enumerated() {
            cardView.acceptButton.tag = index
            cardView.acceptButton.addTarget(self, action: #selector(acceptButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    func loadTrip() {
        DatabaseManager.shared.getTripDetails(tripID: tripId!) { (result: Result<Trip?, Error>) in
            switch result {
            case .success(let trip):
                if let trip = trip {
                    self.setupMapView(sourceLatitude: trip.sourceLatitude, destinationLatitude: trip.destinationLatitude, sourceLongitude: trip.sourceLongitude, destinationLongitude: trip.destinationLongitude)
                    self.tripDetails.sourceDestLabel.text = trip.sourceName + " --> " + trip.destinationName
                    self.tripDetails.databaseValues = trip.passengers
                    self.tripDetails.driverCardView.mainDescriptionLabel.text = trip.userEmail
                    self.emailAddresses.append(trip.userEmail)
                    self.emailAddresses = self.emailAddresses + trip.passengers
                    self.tripDetails.driverCardView.acceptButton.addTarget(self, action: #selector(self.acceptButtonTappedForDriver(_:)), for: .touchUpInside)
                    self.setupDisplayValues()
                    DispatchQueue.main.async {
                        self.tripDetails.updateCoPassengerCardViews() {
                            self.addButtonAction()
                        }
                    }
                    
                } else {
                    print("Error: Trip not found")
                }
            case .failure(let error):
                print("Error fetching trip details: \(error.localizedDescription)")
            }
        }
    }
    
    func setupDisplayValues() {
        DatabaseManager.shared.getUserDetailsFromEmails(for: self.emailAddresses) { result in
            switch result {
            case .success(let users):
                if let profilePhotoURL = users[0].photoUrl, let url = URL(string: profilePhotoURL) {
                    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if let error = error {
                            print("Error fetching photo from URL: \(error)")
                            return
                        }
                        
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.tripDetails.driverCardView.profileImageView.image = image
                            }
                        }
                    }
                    
                    task.resume()
                } else {
                    self.tripDetails.driverCardView.profileImageView.image = UIImage(systemName: "person.fill")
                }
                
                var count = 0
                for user in users[1...] {
                    if let profilePhotoURL = user.photoUrl, let url = URL(string: profilePhotoURL) {
                        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                            if let error = error {
                                print("Error fetching photo from URL: \(error)")
                                return
                            }
                            
                            if let data = data, let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self.tripDetails.coPassCardViews[count].profileImageView.image = image
                                    count = count + 1
                                }
                            }
                        }
                        task.resume()
                    } else {
                        self.tripDetails.coPassCardViews[count].profileImageView.image = UIImage(systemName: "person.fill")
                        count = count + 1
                    }
                }
            case .failure(let error):
                print("Error fetching user details: \(error.localizedDescription)")
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
        //TODO: call message view controller with title
        print("Accept button tapped for co-passenger: \(title ?? "Unknown")")
    }
    
    @objc func acceptButtonTappedForDriver(_ sender: UIButton) {
        let index = sender.tag
        let title = self.tripDetails.driverCardView.mainDescriptionLabel.text
        //TODO: call message view controller with title
        print("Accept button tapped for driver: \(title ?? "Unknown")")
    }
}

