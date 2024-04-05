//
//  Trip.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/3/24.
//

import Foundation

class Trip {
    var source: MapLocation
    var destination: MapLocation
    var userId: String
    var numberOfSeats: Int
    var pricePerSeat: Double
    var startTime: String

    init(source: MapLocation, destination: MapLocation, userId: String, numberOfSeats: Int, pricePerSeat: Double, startTime: String) {
        self.source = source
        self.destination = destination
        self.userId = userId
        self.numberOfSeats = numberOfSeats
        self.pricePerSeat = pricePerSeat
        self.startTime = startTime
    }
}
