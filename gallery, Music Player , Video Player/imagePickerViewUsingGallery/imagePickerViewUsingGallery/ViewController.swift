//
//  ViewController.swift
//  imagePickerViewUsingGallery
//
//  Created by mac on 02/09/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

