//
//  Trip.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/3/24.
//

import Foundation

class Trip: Decodable {
    var id: String?
    var sourceName: String
    var destinationName: String
    var sourceLatitude: Double
    var sourceLongitude: Double
    var destinationLatitude: Double
    var destinationLongitude: Double
    var userEmail: String
    var numberOfSeats: Int
    var pricePerSeat: Double
    var startDate: String
    var startTime: String

    init(id: String? = nil, sourceName: String, destinationName: String, sourceLatitude: Double, sourceLongitude: Double, destinationLatitude: Double,  destinationLongitude: Double, userEmail: String, numberOfSeats: Int, pricePerSeat: Double, startDate: String, startTime: String) {
        self.id = id
        self.sourceName = sourceName
        self.destinationName = destinationName
        self.sourceLatitude = sourceLatitude
        self.sourceLongitude = sourceLongitude
        self.destinationLatitude = destinationLatitude
        self.destinationLongitude = destinationLongitude
        self.userEmail = userEmail
        self.numberOfSeats = numberOfSeats
        self.pricePerSeat = pricePerSeat
        self.startDate = startDate
        self.startTime = startTime
    }
}
