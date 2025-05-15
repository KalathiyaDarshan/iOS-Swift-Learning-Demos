//
//  ViewController.swift
//  Switchcase
//
//  Created by mac on 16/05/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let day = "Tuesday"
        
        switch day {
            case "Monday":
                print("It's the start of the week!")
                fallthrough
            case "Tuesday", "Wednesday", "Thursday":
                break
                print("It's a weekday.")
                
            case "Friday":
                print("It's finally Friday!")
            case "Saturday", "Sunday":
                print("It's the weekend!")
            default:
                print("Invalid day!")
        }
    }


}

