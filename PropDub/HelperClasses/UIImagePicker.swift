//
//  UIImagePicker.swift
//  Josh
//
//  Created by Esfera-Macmini on 26/04/22.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker = UIImagePickerController()
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback: ((UIImage, String?) -> ())?
    
    override init(){
        super.init()
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }

        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
    }

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage, String?) -> ())) -> Bool {
        pickImageCallback = callback
        self.viewController = viewController

        alert.popoverPresentationController?.sourceView = self.viewController!.view

        viewController.present(alert, animated: true, completion: nil)
        
        return true 
    }
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                return controller
            }()
            viewController?.present(alertController, animated: true)
        }
    }
    func openGallery(){
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
  
    // For Swift 4.2+
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            guard let image = info[.originalImage] as? UIImage else {
                fatalError("\(AlertMessages.EXPECTED_DICTIONARY_ALERT) \(info)")
            }
            var imageName: String?
            if let imageURL = info[.imageURL] as? URL {
                // Get the filename from URL
                imageName = imageURL.lastPathComponent
            }
            
            if imageName == nil {
                imageName = "\(Date().timeIntervalSince1970).jpg"
                // Optionally save the image to a temporary directory
               // saveImageToTemporaryDirectory(image: image, filename: imageName!)
            }
            
            // Call the callback with the image and the filename
            self.pickImageCallback?(image, imageName)
        }
    }
}
