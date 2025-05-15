//
//  SecondViewController.swift
//  UserDefult
//
//  Created by mac on 17/06/24.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var lblUserDefault: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UserDefaults.standard.string(forKey: "name") 
        lblUserDefault.text = value ?? ""
    }
    
    @IBAction func RemoveAction(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "name")
        print("User Default Value",UserDefaults.standard.string(forKey: "name"))
    }
}
