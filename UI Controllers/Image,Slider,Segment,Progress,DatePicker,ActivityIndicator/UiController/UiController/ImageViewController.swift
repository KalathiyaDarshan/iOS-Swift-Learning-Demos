//
//  ViewController.swift
//  UiController
//
//  Created by mac on 27/05/24.
//

/*
    Slider
    Tabbar,Tabbar Item
    Segment Control
    Activity Indicator
    PrograsView
    PageControl
    UiImage
    DatePicker
    NavigationBar, Navigation Item
    SearchBar
 */
import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "Image-1") // change image
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.6
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        imageView.layer.shadowRadius = 20
        imageView.clipsToBounds = false
    }


}

