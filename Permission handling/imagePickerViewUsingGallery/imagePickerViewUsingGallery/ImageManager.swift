//
//  ImageManager.swift
//  imagePickerViewUsingGallery
//
//  Created by mac on 02/09/24.
//

import Foundation
import UIKit
import AVFoundation
import Photos

class ImageManager : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    static let shared = ImageManager()
    private var imagePickedCallback: ((UIImage?) -> Void)?
    
    func showImagePickerAlert(presentingController: UIViewController, callback: @escaping (UIImage?) -> Void) {
        
        imagePickedCallback = callback
        
        let alert = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        
        //Camera Action
        let cameraAction = UIAlertAction(title: "Camera", style: .default){ (_) in
            self.checkCameraPermission(presentingController: presentingController)
        }
        
        // Library Action
        let libraryAction = UIAlertAction(title: "Library", style: .default){ (_) in
            self.checkPhotoLibraryPermission(presentingController: presentingController)
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
    
    private func presentCameraSettings(presentingController: UIViewController){
        let alertController = UIAlertController(title: "Error", message: "Camera access is denid", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel){ _ in
            if let url = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in})
            }
        })
        
        presentingController.present(alertController,animated: true)
    }
    
    private func presentLibrarySettings(presentingController: UIViewController) {
        let alertController = UIAlertController(title: "Error", message: "Photo Library access is denied", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        
        presentingController.present(alertController, animated: true)
    }
    
    // Function to check camera permission
    private func checkCameraPermission(presentingController: UIViewController) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
            case .notDetermined:
                // Request permission
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    DispatchQueue.main.async {
                        if granted {
                            self.presentImagePicker(sourceType: .camera, presentingController: presentingController)
                        } else {
                            self.presentCameraSettings(presentingController: presentingController)
                        }
                    }
                }
            case .authorized:
                // Permission granted, present camera
                presentImagePicker(sourceType: .camera, presentingController: presentingController)
            case .denied, .restricted:
                // Permission denied, show settings alert
                presentCameraSettings(presentingController: presentingController)
            @unknown default:
                break
        }
    }
    
    private func checkPhotoLibraryPermission(presentingController: UIViewController) {
        let libraryAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch libraryAuthorizationStatus {
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { status in
                    DispatchQueue.main.async {
                        if status == .authorized || status == .limited {
                            self.presentImagePicker(sourceType: .photoLibrary, presentingController: presentingController)
                        } else {
                            self.presentLibrarySettings(presentingController: presentingController)
                        }
                    }
                }
            case .authorized, .limited:
                presentImagePicker(sourceType: .photoLibrary, presentingController: presentingController)
            case .denied, .restricted:
                presentLibrarySettings(presentingController: presentingController)
            @unknown default:
                break
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        // Debug: Print picker info to verify data
        print("Picker finished, info: \(info)")
       // info[UIImagePickerController.InfoKey.originalImage]
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("Image picked successfully")
            imagePickedCallback?(image)
        } else {
            // Debug: Log error if image could not be retrieved
            print("Failed to pick image")
            imagePickedCallback?(nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        imagePickedCallback?(nil)
    }
}
