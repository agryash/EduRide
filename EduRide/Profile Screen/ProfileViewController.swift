//
//  ProfileViewController.swift
//  EduRide
//
//  Created by Riya on 4/2/24.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileScreen = ProfileView()
    
    override func loadView() {
        view = profileScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func editButtonTapped() {
        let editController = EditProfileViewController()
        navigationController?.pushViewController(editController, animated: true)
    }
}
