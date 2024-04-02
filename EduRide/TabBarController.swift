//
//  TabBarController.swift
//  EduRide
//
//  Created by Yash Agrawal on 4/1/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        //self.tabBar.barTintColor = .lightGray
        //self.tabBar.tintColor = .systemBlue
        self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        // Do any additional setup after loading the view
    }
    
    private func setupTabs(){
        
        let home = self.createNav(with: "Home", and: UIImage (systemName: "house"), vc: HomeViewController())
        let chat = self.createNav(with: "Chat", and: UIImage(systemName:"message"), vc: ChatViewController())
        let profile = self.createNav(with: "Profile", and: UIImage (systemName:"person"), vc: ProfileViewController())
        
        self.setViewControllers([home, chat, profile], animated:true)
    }
    
    private func createNav(with title:String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }

}
