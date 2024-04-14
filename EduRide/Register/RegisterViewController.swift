//
//  RegisterViewController.swift
//  EduRide
//
//  Created by Riya on 4/2/24.
//

import UIKit
import PhotosUI
import FirebaseAuth
import Firebase
import FirebaseStorage

class RegisterViewController: UIViewController {
    
    let registerScreen = RegisterView()
    var pickedImage: UIImage?
    
    override func loadView() {
        view = registerScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign Up"
        registerScreen.choosePicButton.menu = getMenuImagePicker()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        
        registerScreen.buttonSignUp.addTarget(self, action: #selector(onButtonRegisterTapped), for: .touchUpInside)
    }
    
    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }
    
    @objc func onButtonRegisterTapped() {
        let storage = Storage.storage().reference()
        if let name = registerScreen.textFieldName.text, !name.isEmpty,
           let email = registerScreen.textFieldEmail.text, !email.isEmpty,
           let password = registerScreen.textFieldPassword.text, !password.isEmpty,
           let phoneNumber = registerScreen.textFieldNumber.text, !phoneNumber.isEmpty,
           let role = registerScreen.textFieldRole.text, !role.isEmpty {
            if (isValidEmail(email)) {
                if (isValidPhoneNumber(phoneNumber)) {
                    if let profilePhoto = registerScreen.profileImage.image,
                       let imageData = profilePhoto.jpegData(compressionQuality: 0.8) {
                        let photoRef = storage.child("profile_photos/\(UUID().uuidString).jpg")

                        photoRef.putData(imageData, metadata: nil) { (metadata, error) in
                            if let _ = metadata {
                                photoRef.downloadURL { (url, error) in
                                    if let profilePhotoURL = url?.absoluteString {
                                        let user = User(name: name, emailAddress: email.lowercased(), password: password, phoneNumber: phoneNumber, role: role, photoUrl: profilePhotoURL)
                                        self.saveUserDataToFirestore(user: user)
                                    } else {
                                        
                                    }
                                }
                            } else {
                                
                            }
                        }
                    } else {
                        let user = User(name: name, emailAddress: email, password: password, phoneNumber: phoneNumber, role: role)
                        self.saveUserDataToFirestore(user: user)
                    }
                } else {
                    showInvalidErrorAlert(message: "Invalid Phone number")
                }
            } else {
                showInvalidErrorAlert(message: "Invalid Email id")
            }
        } else {
            showErrorAlert()
        }
    }
    
    func saveUserDataToFirestore(user: User) {
        Auth.auth().createUser(withEmail: user.emailAddress!, password: user.password!, completion: {result, error in
            if error == nil {
                self.setNameOfTheUserInFirebaseAuth(name: user.name!)
                let tabBar = TabBarController()
                self.clearAddViewFields()
                DatabaseManager.shared.insertUser(with: user)
                tabBar.modalPresentationStyle = .fullScreen
                self.present(tabBar, animated: true)
            } else {
                self.showInvalidErrorAlert(message: error!.localizedDescription)
            }
        })
    }
    
    func setNameOfTheUserInFirebaseAuth(name: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil {
            } else {
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let numericRegex = "^[0-9+]{0,1}[0-9]{10}$"
        let numericPredicate = NSPredicate(format: "SELF MATCHES %@", numericRegex)
        return numericPredicate.evaluate(with: phoneNumber)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
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

    func clearAddViewFields() {
        registerScreen.textFieldEmail.text = ""
        registerScreen.textFieldPassword.text = ""
    }
    
    func getMenuImagePicker() -> UIMenu{
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

extension RegisterViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.registerScreen.profileImage.image = uwImage.withRenderingMode(.alwaysOriginal)
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
    }
}

extension RegisterViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.registerScreen.profileImage.image = image.withRenderingMode(.alwaysOriginal)
            self.pickedImage = image
        } else {
            // Do your thing for No image loaded...
        }
    }
}

enum DatabaseError: Error {
    case failedToConvertImageToData
    case unknown
}
