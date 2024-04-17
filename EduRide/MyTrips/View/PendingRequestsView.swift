//
//  PendingRequestsView.swift
//  EduRide
//
//  Created by Gowtham Potnuru on 4/16/24.
//

import UIKit

class PendingRequestsView: UIView {
    var pendingReqCardViews: [PendingRequestCardView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    func pendingReqCardViewsSetup(trips: [Trip]) {
        print("pending requests \(trips)")
        for cardView in pendingReqCardViews {
            cardView.removeFromSuperview()
        }
        
        pendingReqCardViews.removeAll()
        // Iterate pendingRequests list in the trips
        for (index, value) in trips.enumerated() {
            for (emailIndex, reqEmail) in value.pendingRequests.enumerated() {
                let pendingRequestCardView = PendingRequestCardView()
                pendingRequestCardView.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(pendingRequestCardView)
                
                pendingRequestCardView.mainDescriptionLabel.text = reqEmail
                pendingRequestCardView.locationLabel.text = "\(value.sourceName) -> \(value.destinationName)"
                pendingRequestCardView.acceptButton.tags = [index, emailIndex]
                pendingRequestCardView.rejectButton.tags = [index, emailIndex]
                pendingRequestCardView.chatButton.tags = [index, emailIndex]
                pendingReqCardViews.append(pendingRequestCardView)
            }
        }
        pendingCardViewLayouts()
    }
    
    func pendingCardViewLayouts() {
        var previousCardView: UIView?
        for cardView in pendingReqCardViews {
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

// Customized the UIButton class to have multiple tags
extension UIButton {
    private struct AssociatedKeys {
        static var tagsKey = "tagsKey"
    }

    var tags: [Int] {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.tagsKey) as? [Int] ?? []
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tagsKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
