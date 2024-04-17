//
//  PendingRequestsViewController.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/16/24.
//

import UIKit
import FirebaseAuth

class PendingRequestsViewController: UIViewController {
    let pendingRequestsView = PendingRequestsView()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: User?
    var pendingRequestTrips = [Trip]()
    
    override func loadView() {
        view = pendingRequestsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pending Requests"
        
        DatabaseManager.shared.getCurrentUserDetails { result in
            switch result {
            case .success(let user):
                self.currentUser = user!
                self.findPendingRequestsForDriver()
            case .failure(let error):
                print("Error fetching user details: \(error.localizedDescription)")
            }
        }
    }
    
    func findPendingRequestsForDriver() {
        // Pending requests are part of upcoming trips for driver
        print("find pending requests for driver")
        pendingRequestTrips.removeAll()
        if let email = currentUser?.emailAddress {
            DatabaseManager.shared.findUpcomingTripsForDriver(with: email, completion: { [weak self] result in
                switch result {
                case .success(let trips):
                    self?.pendingRequestTrips = trips
                    self?.pendingRequestsCardViewReload()
                case .failure(let error):
                    print("Failed to get users: \(error)")
                }
            })
        }
    }
    
    func pendingRequestsCardViewReload() {
        pendingRequestsView.pendingReqCardViewsSetup(trips: pendingRequestTrips)
        for (index, cardView) in pendingRequestsView.pendingReqCardViews.enumerated() {
            cardView.acceptButton.addTarget(self, action: #selector(acceptButtonTapped(_:)), for: .touchUpInside)
            cardView.rejectButton.addTarget(self, action: #selector(rejectButtonTapped(_:)), for: .touchUpInside)
            cardView.chatButton.addTarget(self, action: #selector(chatButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc func acceptButtonTapped(_ sender: UIButton) {
        let tags = sender.tags
        let tripIndex = tags[0]
        let emailIndex = tags[1]
        
        if let tripId = pendingRequestTrips[tripIndex].id {
            let requestorEmail = pendingRequestTrips[tripIndex].pendingRequests[emailIndex]
            DatabaseManager.shared.acceptPendingRequest(with: requestorEmail, with: tripId)
            showAlert(status: "Success", text: "Accepted \(requestorEmail) request!")
        }
    }

    @objc func rejectButtonTapped(_ sender: UIButton) {
        let tags = sender.tags
        let tripIndex = tags[0]
        let emailIndex = tags[1]
        
        if let tripId = pendingRequestTrips[tripIndex].id {
            let requestorEmail = pendingRequestTrips[tripIndex].pendingRequests[emailIndex]
            DatabaseManager.shared.rejectPendingRequest(with: requestorEmail, with: tripId)
            showAlert(status: "Success", text: "Rejected \(requestorEmail) request!")
        }
    }

    @objc func chatButtonTapped(_ sender: UIButton) {
        print("Chat")
        let tags = sender.tags
        let tripIndex = tags[0]
        let emailIndex = tags[1]
        
        print("Chat button tapped \(tripIndex) \(emailIndex)")
    }
    
    func showAlert(status: String, text: String) {
        let alert = UIAlertController(
            title: "\(status)", message: "\(text)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
