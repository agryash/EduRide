//
//  TabBarController.swift
//  EduRide
//
//  Created by Yash Agrawal on 4/1/24.
//

import UIKit
import FirebaseAuth

class TabBarController: UITabBarController {
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tabBar.barTintColor = .lightGray
        //self.tabBar.tintColor = .systemBlue
        self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        DatabaseManager.shared.getCurrentUserDetails { result in
            switch result {
            case .success(let user):
                self.currentUser = user!
                self.setupTabs()
            case .failure(let error):
                print("Error fetching user details: \(error.localizedDescription)")
            }
        }
    }
    
    private func setupTabs(){
        if currentUser?.role == "Driver" {
            let offer = self.createNav(with: "Offer Trip", and: UIImage (systemName: "airplane.departure"), vc: OfferTripViewController())
            let pending = self.createNav(with: "Requests", and: UIImage (systemName: "person.badge.plus"), vc: PendingRequestsViewController())
            let myTrips = self.createNav(with: "My Trips", and: UIImage(systemName: "arrow.triangle.branch"), vc: MyTripsViewController())
            let chat = self.createNav(with: "Chat", and: UIImage (systemName:"message"), vc: ChatViewController())
            let profile = self.createNav(with: "Profile", and: UIImage (systemName:"person"), vc: ProfileViewController())
            
            self.setViewControllers([offer, pending, myTrips, chat, profile], animated:true)
        } else {
            let find = self.createNav(with: "Find Trip", and: UIImage(systemName:"magnifyingglass"), vc: FindTripViewController())
            let sent = self.createNav(with: "Requests", and: UIImage (systemName: "person.badge.plus"), vc: SentRequestsViewController())
            let myTrips = self.createNav(with: "My Trips", and: UIImage(systemName: "arrow.triangle.branch"), vc: MyTripsViewController())
            let chat = self.createNav(with: "Chat", and: UIImage (systemName:"message"), vc: ChatViewController())
            let profile = self.createNav(with: "Profile", and: UIImage (systemName:"person"), vc: ProfileViewController())
            
            self.setViewControllers([find, sent, myTrips, chat, profile], animated:true)
        }
        
    }
    
    private func createNav(with title:String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }

}
