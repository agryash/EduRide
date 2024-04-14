//
//  MyTripsView.swift
//  EduRide
//
//  Created by Abhisha Daine on 4/4/24.
//

import UIKit

class MyTripsView: UIView {
    
    
    var pendingReqLabel: UILabel!
    let pendingReqDBValues: [String] = ["Yash A", "Riya B"]
    let startDBValues: [String] = ["Boylston", "72 Westland"]
    let endDBValues: [String] = ["Bracebridge", "Amazon"]

    var pendingReqCardViews: [PendingRequestCardView] = []
    
    var sentReqLabel: UILabel!
    let sentReqDBValues: [String] = ["Abhisha D", "Gowtham P"]
    var sentReqCardViews: [SentRequestCardView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        pendingReqLabelSetup()
        pendingReqCardViewsSetup()
        
        sentReqLabelSetup()
        sentReqCardViewsSetup()
        
        initConstraints()
    }
    
    func pendingReqLabelSetup() {
        pendingReqLabel = UILabel()
        pendingReqLabel.text = "Pending Requests"
        pendingReqLabel.font = UIFont.boldSystemFont(ofSize: 16)
        pendingReqLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pendingReqLabel)
    }
    
    func pendingReqCardViewsSetup() {
        for (index, value) in self.pendingReqDBValues.enumerated() {
            let pendingRequestCardView = PendingRequestCardView()
            pendingRequestCardView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(pendingRequestCardView)
            
            pendingRequestCardView.mainDescriptionLabel.text = value
            
            let location = startDBValues[index] + " -> " + endDBValues[index]
            
            pendingRequestCardView.locationLabel.text = location

            
            pendingRequestCardView.acceptButton.tag = index
            pendingRequestCardView.rejectButton.tag = index
            
            pendingReqCardViews.append(pendingRequestCardView)
        }
        pendingCardViewLayouts()
    }
    
    func pendingCardViewLayouts() {
        var previousCardView: UIView?
        for cardView in pendingReqCardViews {
            NSLayoutConstraint.activate([
                cardView.topAnchor.constraint(equalTo: previousCardView?.bottomAnchor ?? pendingReqLabel.bottomAnchor, constant: 16),
                cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
            
            previousCardView = cardView
        }
    }
    
    func sentReqLabelSetup() {
        sentReqLabel = UILabel()
        sentReqLabel.text = "Sent Requests"
        sentReqLabel.font = UIFont.boldSystemFont(ofSize: 16)
        sentReqLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sentReqLabel)
    }
    
    func sentReqCardViewsSetup() {
        for (index, value) in self.sentReqDBValues.enumerated() {
            let sentRequestCardView = SentRequestCardView()
            sentRequestCardView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(sentRequestCardView)
            
            sentRequestCardView.mainDescriptionLabel.text = value
            
            sentReqCardViews.append(sentRequestCardView)
        }
        sentCardViewLayouts()
    }
    
    func sentCardViewLayouts() {
        var previousCardView: UIView?
        for cardView in sentReqCardViews {
            NSLayoutConstraint.activate([
                cardView.topAnchor.constraint(equalTo: previousCardView?.bottomAnchor ?? sentReqLabel.bottomAnchor, constant: 16),
                cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])
            
            previousCardView = cardView
        }
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            pendingReqLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            pendingReqLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            // If there are pending request card views, anchor the first one to the pendingReqLabel
            pendingReqCardViews.first?.topAnchor.constraint(equalTo: pendingReqLabel.bottomAnchor, constant: 16) ?? nil,
            sentReqLabel.topAnchor.constraint(equalTo: pendingReqCardViews.last?.bottomAnchor ?? pendingReqLabel.bottomAnchor, constant: 30),
            sentReqLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            // If there are sent request card views, anchor the first one to the sentReqLabel
            sentReqCardViews.first?.topAnchor.constraint(equalTo: sentReqLabel.bottomAnchor, constant: 16) ?? nil
        ].compactMap { $0 })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
