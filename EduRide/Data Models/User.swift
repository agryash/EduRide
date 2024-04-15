//
//  User.swift
//  EduRide
//
//  Created by Riya on 4/13/24.
//

import Foundation

struct User {
    var name: String?
    var emailAddress: String?
    var password: String?
    var phoneNumber: String?
    var role: String?
    var photoUrl: String?
    
    init(name: String? = nil, emailAddress: String? = nil, password: String? = nil, phoneNumber: String? = nil, role: String? = nil, photoUrl: String? = nil) {
        self.name = name
        self.emailAddress = emailAddress
        self.password = password
        self.phoneNumber = phoneNumber
        self.role = role
        self.photoUrl = photoUrl
    }
}

