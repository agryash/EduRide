//
//  TripDetailsViewController.swift
//  EduRide
//
//  Created by Riya on 4/3/24.
//

import UIKit

class TripDetailsViewController: UIViewController {

    let tripDetails = TripDetailsView()
      
    override func loadView() {
        view = tripDetails
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trip Details"
        for (index, cardView) in tripDetails.coPassCardViews.enumerated() {
            cardView.acceptButton.tag = index
            cardView.rejectButton.tag = index
            
            cardView.acceptButton.addTarget(self, action: #selector(acceptButtonTapped(_:)), for: .touchUpInside)
            cardView.rejectButton.addTarget(self, action: #selector(rejectButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc func acceptButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let cardView = tripDetails.coPassCardViews[index]
        let title = cardView.mainDescriptionLabel.text
        
        print("Accept button tapped for co-passenger: \(title ?? "Unknown")")
    }
    
    @objc func rejectButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let cardView = tripDetails.coPassCardViews[index]
        let title = cardView.mainDescriptionLabel.text
        
        print("Reject button tapped for co-passenger: \(title ?? "Unknown")")
    }
}
