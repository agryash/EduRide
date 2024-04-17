//
//  SentRequestsViewController.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/16/24.
//

import UIKit
import FirebaseAuth

class SentRequestsViewController: UIViewController {
    let sentRequestsView = SentRequestsView()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: User?
    var sentRequests = [Trip]()
    
    override func loadView() {
        view = sentRequestsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sent Requests"
        
        DatabaseManager.shared.getCurrentUserDetails { result in
            switch result {
            case .success(let user):
                self.currentUser = user!
                self.findSentRequestsForPassenger()
            case .failure(let error):
                print("Error fetching user details: \(error.localizedDescription)")
            }
        }
    }
    
    func findSentRequestsForPassenger() {
        print("finding sent requests for passenger")
        sentRequests.removeAll()
        if let email = currentUser?.emailAddress {
            DatabaseManager.shared.findSentRequestsForPassenger(with: email, completion: { [weak self] result in
                switch result {
                case .success(let trips):
                    self?.sentRequests = trips
                    self?.sentRequestsCardViewReload()
                case .failure(let error):
                    print("Failed to get users: \(error)")
                }
            })
        }
    }
    
    func sentRequestsCardViewReload() {
        sentRequestsView.sentReqCardViewsSetup(trips: self.sentRequests)
    }
}
