//
//  ViewController.swift
//  ifelsetask
//
//  Created by Mayur Mori on 09/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let temperature = 20
        
        if temperature > 30 {
            print("It's a hot day!")
        } else if temperature < 10 {
            print("It's a cold day!")
        } else {
            print("The weather is moderate.")
        }
        
        //switch case
        let day = "Monday"
        
        switch day {
            case "Monday":
                print("It's the start of the week!")
            case "Tuesday", "Wednesday", "Thursday":
                print("It's a weekday.")
            case "Friday":
                print("It's finally Friday!")
            case "Saturday", "Sunday":
                print("It's the weekend!")
            default:
                print("Invalid day!")
        }
        
        //Pattern Matching
        let point = (-1, 2)
        switch point {
            case (0, 0):
                print("Origin")
            case (_, 0):
                print("On x-axis")
            case (0, _):
                print("On y-axis")
            case (-2...2, -2...2):
                print("Inside the square")
            default:
                print("Outside the square")
        }
        
        //for in loop
        print("for in loop")
        let numbers = [1, 2, 3, 4, 5]
        for number in numbers {
            print(number)
        }
        
        //while loop
        print("while loop")
        var count = 0
        while count < 5 {
            print(count)
            count += 1
        }
        // repeat while loop
        print("Repeat while loop")
        var number = 5
        repeat {
            print(number)
            number -= 1
        } while number > 0

        
    }
    
    
}

