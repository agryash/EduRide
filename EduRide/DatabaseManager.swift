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
    let today: String
    private init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.today = dateFormatter.string(from: Date())
    }
    
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
    
    public func findRequestForTripId(with tripId: String, completion: @escaping (Result<Array<Request>, Error>) -> Void) {
        var requests = [Request]()
        
        self.db.collection("requests")
            .addSnapshotListener(includeMetadataChanges: false) { querySnapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let documents = querySnapshot?.documents {
                    for document in documents {
                        do {
                            let request = try document.data(as: Request.self)
                            if request.tripId == tripId {
                                requests.append(request)
                            }
                        } catch {
                            print(error)
                        }
                    }
                    completion(.success(requests))
                } else {
                    completion(.success(requests))
                }
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
    
    public func getUserDetailsFromEmails(for emailAddresses: [String], completion: @escaping (Result<[User], Error>) -> Void) {
        let userRef = db.collection("users")
        var users: [User] = []
        
        let dispatchGroup = DispatchGroup()
        
        for email in emailAddresses {
            dispatchGroup.enter()
            
            userRef.whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
                defer {
                    dispatchGroup.leave()
                }
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    completion(.success(users))
                    return
                }
                
                for document in documents {
                    let userData = document.data()
                    
                    let name = userData["name"] as? String
                    let password = userData["password"] as? String
                    let phoneNumber = userData["phone"] as? String
                    let role = userData["role"] as? String
                    let photoUrl = userData["photoUrl"] as? String
                    
                    let user = User(name: name ?? "", emailAddress: email, password: password ?? "", phoneNumber: phoneNumber ?? "", role: role ?? "", photoUrl: photoUrl)
                    users.append(user)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(.success(users))
        }
    }
    
    public func getTripDetails(tripID: String, completion: @escaping (Result<Trip?, Error>) -> Void) {
        let tripRef = db.collection("trips").document(tripID)
            
        tripRef.getDocument { (documentSnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = documentSnapshot, document.exists else {
                completion(.success(nil))
                return
            }
            
            let tripData = document.data()
            let sourceName = tripData?["sourceName"] as? String
            let destinationName = tripData?["destinationName"] as? String
            let sourceLatitude = tripData?["sourceLatitude"] as? Double
            let sourceLongitude = tripData?["sourceLongitude"] as? Double
            let destinationLatitude = tripData?["destinationLatitude"] as? Double
            let destinationLongitude = tripData?["destinationLongitude"] as? Double
            let userEmail = tripData?["userEmail"] as? String
            let numberOfSeats = tripData?["numberOfSeats"] as? Int
            let pricePerSeat = tripData?["pricePerSeat"] as? Double
            let startDate = tripData?["startDate"] as? String
            let startTime = tripData?["startTime"] as? String
            let passengers = tripData?["passengers"] as? [String]
            let pendingRequests = tripData?["pendingRequests"] as? [String]
            let rejectedRequests = tripData?["rejectedRequests"] as? [String]
            
            let trip = Trip(id: tripID, sourceName: sourceName!, destinationName: destinationName!, sourceLatitude: sourceLatitude!, sourceLongitude: sourceLongitude!, destinationLatitude: destinationLatitude!, destinationLongitude: destinationLongitude!, userEmail: userEmail!, numberOfSeats: numberOfSeats!, pricePerSeat: pricePerSeat!, startDate: startDate!, startTime: startTime!, passengers: passengers!, pendingRequests: pendingRequests!, rejectedRequests: rejectedRequests!)
            completion(.success(trip))
        }
    }
      
    public func getUserDetailsByEmail(with email:String, completion: @escaping (Result<User?, Error>) -> Void) {
        let userRef = db.collection("users").whereField("email", isEqualTo: email)
        userRef.addSnapshotListener { (documentSnapshot, error) in
            let document = documentSnapshot!.documents[0]

            let userData = document.data()
            let name = userData["name"] as? String
            let password = userData["password"] as? String
            let phoneNumber = userData["phone"] as? String
            let role = userData["role"] as? String
            let photoUrl = userData["photoUrl"] as? String
        
            let user = User(name: name!, emailAddress: email, password: password!, phoneNumber: phoneNumber!, role: role!, photoUrl: photoUrl)
            completion(.success(user))
        }
    }
    
    public func findUpcomingTripsForDriver(with driver: String, completion: @escaping (Result<Array<Trip>, Error>) -> Void) {
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
                            if trip.userEmail == driver && trip.startDate >= self.today {
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
    
    public func acceptPendingRequest(with user: String, with tripId: String) {
        let db = Firestore.firestore()
        let documentRef = db.collection("trips").document(tripId)
            documentRef.updateData([
                "pendingRequests": FieldValue.arrayRemove([user]),
                "passengers": FieldValue.arrayUnion([user])
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
            }
        }
    }
    
    public func rejectPendingRequest(with user: String, with tripId: String) {
        let db = Firestore.firestore()
        let documentRef = db.collection("trips").document(tripId)
            documentRef.updateData([
                "pendingRequests": FieldValue.arrayRemove([user]),
                "rejectedRequests": FieldValue.arrayUnion([user])
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
            }
        }
    }
    
    public func findUpcomingTripsForPassenger(with user: String, completion: @escaping (Result<Array<Trip>, Error>) -> Void) {
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
                            if trip.passengers.contains(user) && trip.startDate >= self.today {
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
    
    func getAllConversationsWithUser(with email: String, completion: @escaping (Result<Set<String>, Error>) -> Void) {
        var contacts = [""]
        
        self.db.collection("userchats")
            .document(email)
            .collection("chats")
            .addSnapshotListener(includeMetadataChanges: false) { querySnapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let documents = querySnapshot?.documents {
                    for document in documents {
                        do {
                            let chat = try document.data(as: Chat.self)
                            contacts.append(chat.to)
                            contacts.append(chat.from)
                            print(contacts)
                        } catch {
                            print(error)
                        }
                    }
                    var myContacts = Set(contacts)
                    myContacts.remove("")
                    myContacts.remove(email)
                    completion(.success(myContacts))
                } else {
                    completion(.success(Set(contacts)))
                }
            }
    }
    
    public func insertChat(with user: String, sender: String, text: String){
        
        let currTimeStamp = Date().timeIntervalSince1970
        let collectionContacts = db
            .collection("userchats")
            .document(sender)
            .collection("chats")

        do {
            let chatData = Chat(from: sender, timestamp: currTimeStamp, text: text, to: user)
            try collectionContacts.addDocument(from: chatData) { error in
                if error == nil {
                    print("Chat added")
                } else {
                    print("Error adding document: \(error!)")
                }
            }
        } catch {
            print("Error encoding chat data: \(error)")
        }
        
        let collectionContacts2 = db
            .collection("userchats")
            .document(user)
            .collection("chats")

        do {
            let chatData = Chat(from: sender, timestamp: currTimeStamp, text: text, to: user)
            try collectionContacts2.addDocument(from: chatData) { error in
                if error == nil {
                    print("Chat added")
                } else {
                    print("Error adding document: \(error!)")
                }
            }
        } catch {
            print("Error encoding chat data: \(error)")
        }
    }
    
    public func findChat(with email: String, user: String, completion: @escaping (Result<[Chat], Error>) -> Void){
        var messages: [Chat] = []
        
        self.db.collection("userchats")
            .document(email)
            .collection("chats")
            .addSnapshotListener(includeMetadataChanges: false) { querySnapshot, error in
                messages.removeAll()
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let documents = querySnapshot?.documents {
                    for document in documents {
                        do {
                            let chat = try document.data(as: Chat.self)
                            print(chat)
                            if((chat.from == email && chat.to == user) || (chat.from == user && chat.to == email)){
                                messages.append(Chat(from: chat.from, timestamp: chat.timestamp, text: chat.text, to: chat.to))
                            }
                        } catch {
                            print(error)
                        }
                    }
                    
                    messages.sort(by: {$0.timestamp < $1.timestamp})
                    
                    completion(.success(messages))
                } else {
                    completion(.success(messages))
                }
            }
    }
    
    public func getAllUsers(completion: @escaping (Result<[[String: String]], Error>) -> Void) {
        db.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            var users: [[String: String]] = []
            
            for document in querySnapshot!.documents {
                let userData = document.data()
                
                users.append(userData as! [String: String])
            }
            
            completion(.success(users))
        }
    }
}




