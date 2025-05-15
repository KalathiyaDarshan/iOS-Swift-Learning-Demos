//
//  SliderViewController.swift
//  UiController
//
//  Created by mac on 27/05/24.
//

import UIKit

class SliderViewController: UIViewController {

    @IBOutlet var SliderView: UISlider!
    @IBOutlet var lblSlider: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SliderView.value = 1.0
        SliderView.minimumValue = 1.0
        SliderView.maximumValue = 100.0
               
    }
    
    @IBAction func SliderValue(_ sender: UISlider) {
        lblSlider.text = "\(Int(sender.value))"
        let step: Float = 5.0
        let newValue = round(sender.value / step) * step
        sender.value = newValue

    }
    
}
