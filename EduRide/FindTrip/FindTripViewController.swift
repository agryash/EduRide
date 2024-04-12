//
//  FindTripViewController.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/3/24.
//

import UIKit
import FirebaseAuth

class FindTripViewController: UIViewController {
    let findTripsScreen = FindTripView()
    var trips = [Trip]()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currEmail = ""
    
    override func loadView() {
        view = findTripsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Find Trips"
        findTripsScreen.datePicker.addTarget(self, action: #selector(onDateChange), for: .valueChanged)
        loadTripsOnDate(tripDate: Date())
        
        handleAuth = Auth.auth().addStateDidChangeListener{auth, user in
            if user != nil {
                self.currEmail = (user?.email!)!
            }
        }
    }
    
    @objc func onDateChange(sender: UIDatePicker) {
        loadTripsOnDate(tripDate: sender.date)
    }

    
    func loadTripsOnDate(tripDate: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var date = formatter.string(from: tripDate)

        DatabaseManager.shared.findTripsBy(with: date, completion: { [weak self] result in
            switch result {
            case .success(let trips):
                self?.trips = trips
                self?.cardViewReload()
            case .failure(let error):
                print("Failed to get users: \(error)")
            }
        })
    }
    
    func cardViewReload() {
        findTripsScreen.setupTripsCardView(trips: trips)
        for (index, cardView) in findTripsScreen.coPassCardViews.enumerated() {
            cardView.acceptButton.tag = index
            cardView.rejectButton.tag = index
            
            cardView.acceptButton.addTarget(self, action: #selector(onBookRideTapped(_:)), for: .touchUpInside)
            cardView.rejectButton.addTarget(self, action: #selector(onRideDetailsTapped(_:)), for: .touchUpInside)
        }
    }
    
    
    @objc func onBookRideTapped(_ sender: UIButton) {
        let index = sender.tag
        let trip = trips[index]
        let name = trip.userEmail
        if let tripId = trip.id {
            let request = Request(tripId: tripId, user: currEmail, status: "pending")
            DatabaseManager.shared.createRequest(with: request)
            showAlert(status: "Success!", text: "Ride Requested")
        }
        showAlert(status: "Error!", text: "Could not fetch trip")
    }
    
    @objc func onRideDetailsTapped(_ sender: UIButton) {
        let index = sender.tag
        let trip = trips[index]
        
        let tripDetailsViewController = TripDetailsViewController()
        tripDetailsViewController.tripId = trip.id
        navigationController?.pushViewController(tripDetailsViewController, animated: true)
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
