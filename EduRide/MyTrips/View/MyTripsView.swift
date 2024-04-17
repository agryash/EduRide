//
//  MyTripsView.swift
//  EduRide
//
//  Created by Abhisha Daine on 4/4/24.
//

import UIKit

class MyTripsView: UIView {
    var upcomingTripsLabel: UILabel!
    var upcomingTripCardViews: [UpcomingTripsCardView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    func upcomingTripCardViewsSetup(trips: [Trip]) {
        for cardView in upcomingTripCardViews {
            cardView.removeFromSuperview()
        }
        
        upcomingTripCardViews.removeAll()
        
        for (index, value) in trips.enumerated() {
            let upcomingTripCardView = UpcomingTripsCardView()
            upcomingTripCardView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(upcomingTripCardView)
            
            upcomingTripCardView.locationLabel.text = "\(value.sourceName) -> \(value.destinationName)"
            upcomingTripCardView.dateLabel.text = "\(value.startDate) \(value.startTime)"
            upcomingTripCardView.detailsButton.tag = index
            upcomingTripCardViews.append(upcomingTripCardView)
        }
        upcomingTripCardViewLayouts()
    }
    
    func upcomingTripCardViewLayouts() {
        var previousCardView: UIView?
        for cardView in upcomingTripCardViews {
            NSLayoutConstraint.activate([
                cardView.topAnchor.constraint(equalTo: previousCardView?.bottomAnchor ?? self.safeAreaLayoutGuide.topAnchor, constant: 16),
                cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
            
            previousCardView = cardView
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
