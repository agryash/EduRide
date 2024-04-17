//
//  MyTripsViewController.swift
//  EduRide
//
//  Created by Abhisha Daine on 4/4/24.
//

import UIKit
import FirebaseAuth

class MyTripsViewController: UIViewController {
    let myTripsView = MyTripsView()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: User?
    var upcomingTrips = [Trip]()
    
    override func loadView() {
        view = myTripsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Trips"
        
        DatabaseManager.shared.getCurrentUserDetails { result in
            switch result {
            case .success(let user):
                self.currentUser = user!
                self.setupView()
            case .failure(let error):
                print("Error fetching user details: \(error.localizedDescription)")
            }
        }
    }
    
    func setupView() {
        if currentUser?.role == "Driver" {
            findUpcomingTripsForDriver()
        }
        
        if currentUser?.role == "Passenger" {
            findUpcomingTripsForPassenger()
        }
    }
        
    func findUpcomingTripsForDriver() {
        print("find upcoming trips for driver")
        upcomingTrips.removeAll()
        if let email = currentUser?.emailAddress {
            DatabaseManager.shared.findUpcomingTripsForDriver(with: email, completion: { [weak self] result in
                switch result {
                case .success(let trips):
                    self?.upcomingTrips = trips
                    print(self?.upcomingTrips)
                    self?.upcomingTripCardViewReload()
                case .failure(let error):
                    print("Failed to get users: \(error)")
                }
            })
        }
    }
    
    func findUpcomingTripsForPassenger() {
        print("find upcoming trips for passenger")
        upcomingTrips.removeAll()
        if let email = currentUser?.emailAddress {
            DatabaseManager.shared.findUpcomingTripsForPassenger(with: email, completion: { [weak self] result in
                switch result {
                case .success(let trips):
                    self?.upcomingTrips = trips
                    self?.upcomingTripCardViewReload()
                case .failure(let error):
                    print("Failed to get users: \(error)")
                }
            })
        }
    }
    
    func upcomingTripCardViewReload() {
        myTripsView.upcomingTripCardViewsSetup(trips: self.upcomingTrips)
        for (index, cardView) in myTripsView.upcomingTripCardViews.enumerated() {
            cardView.detailsButton.addTarget(self, action: #selector(onRideDetailsTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc func onRideDetailsTapped(_ sender: UIButton) {
        let index = sender.tag
        let trip = upcomingTrips[index]
        
        if let tripId = trip.id {
            let tripDetailsViewController = TripDetailsViewController()
            if let email = currentUser?.emailAddress {
                tripDetailsViewController.tripId = trip.id
                tripDetailsViewController.currUser = (currentUser?.emailAddress)!
                navigationController?.pushViewController(tripDetailsViewController, animated: true)
            }
            
        }
    }
    
    func showAlert(status: String, text: String) {
        let alert = UIAlertController(
            title: "\(status)", message: "\(text)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

