//
//  SentRequestsView.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/16/24.
//

import UIKit

class SentRequestsView: UIView {
    var sentRequestCardViews: [SentRequestCardView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    func sentReqCardViewsSetup(trips: [Trip]) {
        for cardView in sentRequestCardViews {
            cardView.removeFromSuperview()
        }

        sentRequestCardViews.removeAll()

        for (index, value) in trips.enumerated() {
            let sentRequestCardView = SentRequestCardView()
            sentRequestCardView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(sentRequestCardView)

            sentRequestCardView.mainDescriptionLabel.text = value.userEmail

            sentRequestCardViews.append(sentRequestCardView)
        }
        sentCardViewLayouts()
    }

    func sentCardViewLayouts() {
        var previousCardView: UIView?
        for cardView in sentRequestCardViews {
            NSLayoutConstraint.activate([
                cardView.topAnchor.constraint(equalTo: previousCardView?.bottomAnchor ?? self.safeAreaLayoutGuide.topAnchor, constant: 16),
                cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            ])

            previousCardView = cardView
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
