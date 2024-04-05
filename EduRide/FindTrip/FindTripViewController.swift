//
//  FindTripViewController.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/3/24.
//

import UIKit

class FindTripViewController: UIViewController {
    let findTripsScreen = FindTripView()
    var trips = [TripDetail]()
    
    override func loadView() {
        view = findTripsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Find Trips"
        findTripsScreen.datePicker.addTarget(self, action: #selector(onDateChange), for: .valueChanged)
        loadTripsOnDate(date: "")
    }
    
    @objc func onDateChange(sender: UIDatePicker) {
        print("Value Changed")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var tripDate = formatter.string(from: sender.date)
        loadTripsOnDate(date: tripDate)
        
    }

    
    func loadTripsOnDate(date: String) {
        print("loading trips on date")
        let sourceLocation = MapLocation(name: "Central Park", latitude: 40.785091, longitude: -73.968285)
        let destinationLocation = MapLocation(name: "Times Square", latitude: 40.7580, longitude: -73.9855)

        let trip = TripDetail(source: sourceLocation,
                        destination: destinationLocation,
                        driver: "user123",
                        numberOfSeats: 4,
                        pricePerSeat: 15.0,
                        startTime: "6:00 AM",
                        tripId: "1"
                        )
        
        trips.append(trip)
        trips.append(trip)
        trips.append(trip)
        cardViewReload()
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
        let name = trip.driver
        
        print("Book ride button tapped for trip: \(name)")
    }
    
    @objc func onRideDetailsTapped(_ sender: UIButton) {
        let index = sender.tag
        let trip = trips[index]
        let tripId = trip.tripId
        
        print("Ride details button tapped for trip: \(index)")
    }
}
