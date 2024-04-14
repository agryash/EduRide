//
//  DatabaseManager.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/11/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    let db = Firestore.firestore()
    
    public func createTrip(with trip: Trip){
        do {
          let ref = db.collection("trips").addDocument(data: [
            "sourceName": trip.sourceName,
            "destinationName": trip.destinationName,
            "sourceLongitude": trip.sourceLongitude,
            "sourceLatitude": trip.sourceLatitude,
            "destinationLongitude": trip.destinationLongitude,
            "destinationLatitude": trip.destinationLatitude,
            "pricePerSeat": trip.pricePerSeat,
            "numberOfSeats": trip.numberOfSeats,
            "startDate": trip.startDate,
            "startTime": trip.startTime,
            "userEmail": trip.userEmail
          ])
          print("User created with ID: \(ref.documentID)")
        }
    }
    
    func findTripsBy(with startDate: String, completion: @escaping (Result<Array<Trip>, Error>) -> Void) {
        print("finding trips \(startDate)")
        var trips = [Trip]()
        
        self.db.collection("trips")
            .addSnapshotListener(includeMetadataChanges: false) { querySnapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let documents = querySnapshot?.documents {
                    for document in documents {
                        do {
                            let trip = try document.data(as: Trip.self)
                            trip.id = document.documentID
                            if trip.startDate == startDate && trip.numberOfSeats > 0 {
                                print(trip.sourceName)
                                trips.append(trip)
                            }
                            
                        } catch {
                            print(error)
                        }
                    }

                    completion(.success(trips))
                } else {
                    completion(.success(trips))
                }
            }
    }
    
    public func createRequest(with request: Request) {
        do {
          let ref = db.collection("requests").addDocument(data: [
            "tripId": request.tripId,
            "user": request.user,
            "status": request.status
          ])
          print("Request created with ID: \(ref.documentID)")
        }
    }
    
    public func insertUser(with user: User) {
        do {
          let ref = db.collection("users").addDocument(data: [
            "name": user.name!,
            "email": user.emailAddress!,
            "phone": user.phoneNumber!,
            "role": user.role!,
            "photoUrl": user.photoUrl!,
            "password": user.password!
          ])
          print("User created with ID: \(ref.documentID)")
        }
    }
    
    public func updateUser(user: User) {
        db.collection("users").whereField("email", isEqualTo: user.emailAddress).getDocuments { [self] (querySnapshot, error) in
            if let error = error {
                print("Error getting user document: \(error.localizedDescription)")
                return
            }

            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                print("No matching user document found")
                return
            }

            guard let userDoc = documents.first else {
                print("Error: User document is nil")
                return
            }
            
            let userData: [String: Any] = [
                "name": user.name!,
                "phone": user.phoneNumber!,
                "photoUrl": user.photoUrl!
            ]

            let userRef = db.collection("users").document(userDoc.documentID)

            userRef.updateData(userData) { error in
                if let error = error {
                    print("Error updating user data: \(error.localizedDescription)")
                } else {
                    print("User data updated successfully")
                }
            }
        }
    }
    
    public func getCurrentUserDetails(completion: @escaping (Result<User?, Error>) -> Void) {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            let email = currentUser.email
            let displayName = currentUser.displayName
            print(email!)
            print(uid)
            let userRef = db.collection("users").whereField("email", isEqualTo: email!)
            
            userRef.addSnapshotListener { (documentSnapshot, error) in
                
                let document = documentSnapshot!.documents[0]

                let userData = document.data()
                let name = userData["name"] as? String
                let password = userData["password"] as? String
                let phoneNumber = userData["phone"] as? String
                let role = userData["role"] as? String
                let photoUrl = userData["photoUrl"] as? String
                
                let user = User(name: name!, emailAddress: email!, password: password!, phoneNumber: phoneNumber!, role: role!, photoUrl: photoUrl)
                completion(.success(user))
            }
        } else {
        }
    }
    
    public func getTripDetails(tripID: String, completion: @escaping (Result<User?, Error>) -> Void) {
//        let tripRef = db.collection("trips").document(tripID)
//            
//        tripRef.getDocument { (documentSnapshot, error) in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let document = documentSnapshot, document.exists else {
//                completion(.success(nil))
//                return
//            }
//            
//            let tripData = document.data()
//            let name = tripData?["name"] as? String
//            let description = tripData?["description"] as? String
//            
//            let trip = Trip(name: name, description: description)
//            completion(.success(trip))
//        }
    }
}



