//
//  TripConfirmationViewController.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/3/24.
//

import UIKit
import MapKit
import FirebaseAuth

class TripConfirmationViewController: UIViewController {
    let tripConfirmationScreen = TripConfirmationView()
    var tripStartTime: String!
    var tripStartDate: String!
    var source: MKMapItem?
    var destination: MKMapItem?
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currEmail = ""
    
    override func loadView() {
        view = tripConfirmationScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Confirm Trip"
        tripConfirmationScreen.confirmButton.addTarget(self, action: #selector(onConfirm), for: .touchUpInside)
        tripConfirmationScreen.startTime.addTarget(self, action: #selector(onStartTimeChanged), for: .valueChanged)
        
        handleAuth = Auth.auth().addStateDidChangeListener{auth, user in
            if user != nil {
                self.currEmail = (user?.email!)!
            }
        }
    }
    
    @objc func onConfirm() {
        if let sourceName = source?.name,
           let sourceCoordinates = source?.placemark.coordinate,
           let destinationName = destination?.name,
           let destinationCoordinates = destination?.placemark.coordinate,
           let seatsText = tripConfirmationScreen.seatsInput.text,
           let priceText = tripConfirmationScreen.pricePerSeat.text,
           let startDateText = tripStartDate,
           let startTimeText = tripStartTime {
            let sourceLocation = MapLocation(name: sourceName, latitude: sourceCoordinates.latitude, longitude: sourceCoordinates.longitude)
            let destinationLocation = MapLocation(name: destinationName, latitude: destinationCoordinates.latitude, longitude: destinationCoordinates.longitude)
            
            if let seats = Int (seatsText),
               let price = Double (priceText) {
                let passengers = [String]()
                let pendingRequests = [String]()
                let rejectedRequests = [String]()
                
                let trip = Trip(sourceName: sourceName,
                                destinationName: destinationName,
                                sourceLatitude: sourceCoordinates.latitude,
                                sourceLongitude: sourceCoordinates.longitude,
                                destinationLatitude: destinationCoordinates.latitude,
                                destinationLongitude: destinationCoordinates.longitude,
                                userEmail: currEmail,
                                numberOfSeats: seats,
                                pricePerSeat: price,
                                startDate: startDateText,
                                startTime: startTimeText,
                                passengers: passengers,
                                pendingRequests: pendingRequests,
                                rejectedRequests: rejectedRequests
                            )
                DatabaseManager.shared.createTrip(with: trip)
            }
        }
    
        self.dismiss(animated: true)
    }
    
    @objc func onStartTimeChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tripStartDate = dateFormatter.string(from: sender.date)

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        tripStartTime = timeFormatter.string(from: sender.date)
    }
}
