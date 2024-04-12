//
//  Request.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/12/24.
//

import Foundation

class Request: Decodable {
    var tripId: String
    var user: String
    var status: String

    init(tripId: String, user: String, status: String) {
        self.tripId = tripId
        self.user = user
        self.status = status
    }
}
