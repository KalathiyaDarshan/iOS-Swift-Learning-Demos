//
//  ViewController.swift
//  UserDefult
//
//  Created by mac on 14/06/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lblData: UILabel!
    @IBOutlet var txtField: UITextField!
    
    var userDefault = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let value = userDefault.value(forKey: "name") as? String{
            lblData.text = value
        }
    }

    @IBAction func saveAction(_ sender: UIButton) {
        if let text = txtField.text, !text.isEmpty {
                    lblData.text = text
                    userDefault.set(text, forKey: "name")
                }
        
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        print("dictionary: ",dictionary)
    }
    
}

