//
//  ViewController.swift
//  CustomFramework
//
//  Created by Apple on 03/10/24.
//

import UIKit
import TextField_Validation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let isValid = TextFieldValidation.emailValidation(email: "abc@example.com")
        if isValid == true{
            print("Email is Valid")
        } else {
            print("Email is Not Valid")
        }
    }
}

