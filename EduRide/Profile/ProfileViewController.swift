//
//  ProfileViewController.swift
//  EduRide
//
//  Created by Riya on 4/2/24.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class ProfileViewController: UIViewController {

    let profileScreen = ProfileView()
    var currentUser = User()
    
    override func loadView() {
        view = profileScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = editButton
        
        profileScreen.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        setupDisplayValues()
    }
    
    func setupDisplayValues() {
        DatabaseManager.shared.getCurrentUserDetails { result in
            switch result {
            case .success(let user):
                self.currentUser = user!
                if let user = user {
                    self.profileScreen.labelNameValue.text = user.name
                    self.profileScreen.labelRoleValue.text = user.role
                    self.profileScreen.labelEmailValue.text = user.emailAddress
                    self.profileScreen.labelPasswordValue.text = user.password
                    self.profileScreen.labelPhoneNumberValue.text = user.phoneNumber
                    if let profilePhotoURL = user.photoUrl, let url = URL(string: profilePhotoURL) {
                        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                            if let error = error {
                                print("Error fetching photo from URL: \(error)")
                                return
                            }
                            
                            if let data = data, let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self.profileScreen.profileImage.image = image
                                }
                            }
                        }
                        
                        task.resume()
                    } else {
                        self.profileScreen.profileImage.image = UIImage(systemName: "person.fill")
                    }
                } else {
                    print("No user details found")
                }
            case .failure(let error):
                print("Error fetching user details: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func editButtonTapped() {
        let editController = EditProfileViewController()
        editController.currentUser = currentUser
        navigationController?.pushViewController(editController, animated: true)
    }
    
    @objc func logoutButtonTapped() {
        do {
            try Auth.auth().signOut()
            
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let entryViewController = MainViewController()
                let navigationController = UINavigationController(rootViewController: entryViewController)
                sceneDelegate.window?.rootViewController = navigationController
            }
        }
        catch {
            print("Logout failed")
        }
    }

}
