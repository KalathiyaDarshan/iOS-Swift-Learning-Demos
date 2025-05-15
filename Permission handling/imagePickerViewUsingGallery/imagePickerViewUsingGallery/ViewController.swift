//
//  ViewController.swift
//  imagePickerViewUsingGallery
//
//  Created by mac on 02/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnAddAction(_ sender: UIButton) {
        ImageManager.shared.showImagePickerAlert(presentingController: self) { image in
            if let selectedImage = image {
                // Handle the selected image
                self.imageView.image = selectedImage
            } else {
                print("Image selection canceled")
            }
        }
    }
}

