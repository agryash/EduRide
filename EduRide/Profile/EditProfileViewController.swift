//
//  EditProfileViewController.swift
//  EduRide
//
//  Created by Riya on 4/2/24.
//

import UIKit
import PhotosUI

class EditProfileViewController: UIViewController {

    let editProfileScreen = EditProfileView()
    var pickedImage: UIImage?
    
    override func loadView() {
        view = editProfileScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        editProfileScreen.choosePicButton.menu = getMenuImagePicker()
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