//
//  TripConfirmationViewController.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/3/24.
//

import UIKit
import MapKit

class TripConfirmationViewController: UIViewController {
    let tripConfirmationScreen = TripConfirmationView()
    var tripStartTime: String!
    var source: MKMapItem?
    var destination: MKMapItem?
    
    override func loadView() {
        view = tripConfirmationScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Confirm Trip"
        tripConfirmationScreen.confirmButton.addTarget(self, action: #selector(onConfirm), for: .touchUpInside)
        tripConfirmationScreen.startTime.addTarget(self, action: #selector(onStartTimeChanged), for: .valueChanged)
    }
    
    @objc func onConfirm() {
        if let sourceName = source?.name,
           let sourceCoordinates = source?.placemark.coordinate,
           let destinationName = destination?.name,
           let destinationCoordinates = destination?.placemark.coordinate,
           let seatsText = tripConfirmationScreen.seatsInput.text,
           let priceText = tripConfirmationScreen.pricePerSeat.text,
           let startTimeText = tripStartTime {
            
            let sourceLocation = MapLocation(name: sourceName, latitude: sourceCoordinates.latitude, longitude: sourceCoordinates.longitude)
            let destinationLocation = MapLocation(name: destinationName, latitude: destinationCoordinates.latitude, longitude: destinationCoordinates.longitude)
            
            if let seats = Int (seatsText),
               let price = Double (priceText) {
                let trip = Trip(source: sourceLocation,
                                destination: destinationLocation,
                                userId: "user123",
                                numberOfSeats: seats,
                                pricePerSeat: price,
                                startTime: startTimeText)
            }
        }
    
        self.dismiss(animated: true)
    }
    
    @objc func onStartTimeChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        tripStartTime = formatter.string(from: sender.date)
    }
}
