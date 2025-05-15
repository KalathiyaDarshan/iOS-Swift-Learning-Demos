//
//  ViewController.swift
//  StepperDemo
//
//  Created by Darshan Kalathiya on 05/03/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.value = 0
        stepper.stepValue = 1 // Default step value is set to 1
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 10
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        lblNumber.text = Int(sender.value).description
    }
    
}

