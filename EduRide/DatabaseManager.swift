//
//  DatabaseManager.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/11/24.
//

import Foundation
import FirebaseFirestore

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
            "userEmail": trip.userEmail,
            "passengers": trip.passengers,
            "pendingRequests": trip.pendingRequests,
            "rejectedRequests": trip.rejectedRequests
          ])
          print("Trip created with ID: \(ref.documentID)")
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
                    trips.removeAll()
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
    
    public func createRequest(with request: Request){
        let db = Firestore.firestore()
        let documentRef = db.collection("trips").document(request.tripId)
            documentRef.updateData([
                "pendingRequests": FieldValue.arrayUnion([request.user])
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
            }
        }
    }
}



