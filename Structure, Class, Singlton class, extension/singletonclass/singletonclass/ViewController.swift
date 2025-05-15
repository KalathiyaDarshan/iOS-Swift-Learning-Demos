//
//  ViewController.swift
//  singletonclass
//
//  Created by Mayur Mori on 13/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let userDetails = UserDetails.shared
        userDetails.name = "Darshan"
        userDetails.profession = "ios trainee"
        userDetails.showUserDetails()

    }
    
    
}
class UserDetails {
    
    //MARK: Variable declaration
    var name:String = ""
    var profession: String = ""
    
    static let shared = UserDetails()  // static property to create singleton
    
    //init(){}                           // default initializer
    
    //MARK: Your custom function
    func showUserDetails() {
        print("User Name: \(name) \nUser Profession: \(profession)")
    }
    
}


