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
        
        if let tripId = pendingRequestTrips[tripIndex].id {
            let requestorEmail = pendingRequestTrips[tripIndex].pendingRequests[emailIndex]
            
            if(requestorEmail == currentUser?.emailAddress){
                self.showToast(message: "Can't Chat with Yourself", font: .systemFont(ofSize: 12.0))
            } else{
                let vc = SingleChatViewController(with: "", id: "")
                vc.title = requestorEmail
                vc.otherUserEmail = requestorEmail
                vc.currSender = (currentUser?.emailAddress)!
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-200, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
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
