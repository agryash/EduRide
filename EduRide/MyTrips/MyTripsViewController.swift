//
//  MyTripsViewController.swift
//  EduRide
//
//  Created by Abhisha Daine on 4/4/24.
//

import UIKit

class MyTripsViewController: UIViewController {
    
    let myTripsView = MyTripsView()
    
    override func loadView() {
        view = myTripsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Trips"
        
        for (index, cardView) in myTripsView.pendingReqCardViews.enumerated() {
            cardView.acceptButton.tag = index
            cardView.rejectButton.tag = index
            
            cardView.acceptButton.addTarget(self, action: #selector(acceptButtonTapped(_:)), for: .touchUpInside)
            cardView.rejectButton.addTarget(self, action: #selector(rejectButtonTapped(_:)), for: .touchUpInside)
        }

    }
    
    @objc func acceptButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let cardView = myTripsView.pendingReqCardViews[index]
        let title = cardView.mainDescriptionLabel.text
        
        print("Accept button tapped for co-passenger: \(title ?? "Unknown")")
    }
    
    @objc func rejectButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let cardView = myTripsView.pendingReqCardViews[index]
        let title = cardView.mainDescriptionLabel.text
        
        print("Reject button tapped for co-passenger: \(title ?? "Unknown")")
    }
    


}
