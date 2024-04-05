//
//  MapLocation.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/3/24.
//

import Foundation

class MapLocation {
    var name: String
    var latitude: Double
    var longitude: Double

    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
