//
//  ViewController.swift
//  ifelse
//
//  Created by mac on 16/05/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let temperature: Int = 300
        guard temperature == 200 else {
           
            print("Temperature not Found")
            return
        }
        
        if temperature < 30{
            print("It's a hot day!")
        } else if temperature < 10 {
            print("It's a cold day!")
        } else if temperature > 50{
            print(temperature)
        }
        else {
            print("The weather is moderate.")
        }
    }


}

