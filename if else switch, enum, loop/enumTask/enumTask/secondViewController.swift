//
//  secondViewController.swift
//  enumTask
//
//  Created by mac on 17/05/24.
//
/*
 if you wanted to write some code to represent the success or failure.
 you could represent that as strings:
 let result = "failure"
 
 But what happens if someone accidentally uses different naming?
 let result = "failed"
 let result = "fail"
 
 With enums we can define a Result type that can be either success or failure, like this:
 enum Result {
     case success
     case failure
 }
 
 And now when we use it we must choose one of those two values:
 let result = Result.failure
 
 This stops you from accidentally using different strings each time.
 */
import UIKit

class secondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.enumCompassPoint(directionToHead: .east)
    }

    func enumCompassPoint(directionToHead: CompassPoint) {
            
            // Matching Enumeration Values with a Switch Statement
            switch directionToHead {
            case .north:
                print("Lots of planets have a north")
            case .south:
                print("Watch out for penguins")
            case .east:
                print("Where the sun rises")
            case .west:
                print("Where the skies are blue")
            }
        }

}
enum CompassPoint {
    case north 
    case south
    case east
    case west
}
