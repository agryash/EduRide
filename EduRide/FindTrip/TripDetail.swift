//
//  TripDetail.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/5/24.
//

import Foundation

class TripDetail {
    var source: MapLocation
    var destination: MapLocation
    var driver: String
    var numberOfSeats: Int
    var pricePerSeat: Double
    var startTime: String
    var tripId: String
    
    init(source: MapLocation, destination: MapLocation, driver: String, numberOfSeats: Int, pricePerSeat: Double, startTime: String, tripId:String) {
        self.source = source
        self.destination = destination
        self.driver = driver
        self.numberOfSeats = numberOfSeats
        self.pricePerSeat = pricePerSeat
        self.startTime = startTime
        self.tripId = tripId
    }
}
