//
//  ImageManager.swift
//  imagePickerViewUsingGallery
//
//  Created by mac on 02/09/24.
//

import Foundation
import UIKit

class ImageManager : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    static let shared = ImageManager()
    private var imagePickedCallback: ((UIImage?) -> Void)?
    
    func showImagePickerAlert(presentingController: UIViewController, callback: @escaping (UIImage?) -> Void) {
        
        imagePickedCallback = callback
        
        let alert = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        
        //Camera Action
        let cameraAction = UIAlertAction(title: "Camera", style: .default){ (_) in
            self.presentImagePicker(sourceType: .camera, presentingController: presentingController)
        }
        
        // Library Action
        let libraryAction = UIAlertAction(title: "Library", style: .default){ (_) in
            self.presentImagePicker(sourceType: .photoLibrary, presentingController: presentingController)
        }
        
        // Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        
        // Present alert
        presentingController.present(alert, animated: true, completion: nil)
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType, presentingController: UIViewController) {
        
        guard  UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            print("Selected Source not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        presentingController.present(imagePicker, animated: true, completion: nil)
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        let image = info[.originalImage] as? UIImage
        imagePickedCallback?(image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        imagePickedCallback?(nil)
    }
}
