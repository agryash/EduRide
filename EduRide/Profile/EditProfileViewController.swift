//
//  EditProfileViewController.swift
//  EduRide
//
//  Created by Riya on 4/2/24.
//

import UIKit
import PhotosUI
import FirebaseStorage

class EditProfileViewController: UIViewController {

    let editProfileScreen = EditProfileView()
    var pickedImage: UIImage?
    var currentUser = User()
    
    override func loadView() {
        view = editProfileScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        editProfileScreen.choosePicButton.menu = getMenuImagePicker()
        setupDisplayValues()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        
        editProfileScreen.buttonSignUp.addTarget(self, action: #selector(onButtonSaveTapped), for: .touchUpInside)
    }
    
    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }
    
    @objc func onButtonSaveTapped() {
        let storage = Storage.storage().reference()
        if let name = editProfileScreen.textFieldName.text, !name.isEmpty,
           let phoneNumber = editProfileScreen.textFieldNumber.text, !phoneNumber.isEmpty {
                if (isValidPhoneNumber(phoneNumber)) {
                    if let profilePhoto = editProfileScreen.profileImage.image,
                       let imageData = profilePhoto.jpegData(compressionQuality: 0.8) {
                        let photoRef = storage.child("profile_photos/\(UUID().uuidString).jpg")

                        photoRef.putData(imageData, metadata: nil) { (metadata, error) in
                            if let _ = metadata {
                                photoRef.downloadURL { (url, error) in
                                    if let profilePhotoURL = url?.absoluteString {
                                        let user = User(name: name, emailAddress: self.currentUser.emailAddress, password: self.currentUser.password, phoneNumber: phoneNumber, role: self.currentUser.role, photoUrl: profilePhotoURL)
                                        DatabaseManager.shared.updateUser(user: user)
                                    } else {
                                        
                                    }
                                }
                            } else {
                                
                            }
                        }
                    } else {
                        let user = User(name: name, emailAddress: self.currentUser.emailAddress, password: self.currentUser.password, phoneNumber: phoneNumber, role: self.currentUser.role)
                        DatabaseManager.shared.updateUser(user: user)
                    }
                } else {
                    showInvalidErrorAlert(message: "Invalid Phone number")
                }
        } else {
            showErrorAlert()
        }
        navigationController?.popViewController(animated: true)
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let numericRegex = "^[0-9+]{0,1}[0-9]{10}$"
        let numericPredicate = NSPredicate(format: "SELF MATCHES %@", numericRegex)
        return numericPredicate.evaluate(with: phoneNumber)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(
            title: "Error!", message: "Text Fields must not be empty!",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

    func showInvalidErrorAlert(message: String) {
        let alert = UIAlertController(
            title: "Error!", message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

    func setupDisplayValues() {
        self.editProfileScreen.textFieldName.text = currentUser.name
        self.editProfileScreen.textFieldNumber.text = currentUser.phoneNumber
        if let profilePhotoURL = currentUser.photoUrl, let url = URL(string: profilePhotoURL) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error fetching photo from URL: \(error)")
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.editProfileScreen.profileImage.image = image
                    }
                }
            }
            
            task.resume()
        } else {
            self.editProfileScreen.profileImage.image = UIImage(systemName: "person.fill")
        }
    }
    
    func getMenuImagePicker() -> UIMenu {
        var menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    func pickUsingCamera() {
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
}

extension EditProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.editProfileScreen.profileImage.image = uwImage.withRenderingMode(.alwaysOriginal)
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
    }
}

extension EditProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.editProfileScreen.profileImage.image = image.withRenderingMode(.alwaysOriginal)
            self.pickedImage = image
        } else {
            // Do your thing for No image loaded...
        }
    }
}
