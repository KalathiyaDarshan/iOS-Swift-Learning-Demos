//
//  ViewController.swift
//  ClassVSStructure
//
//  Created by mac on 31/07/24.
//

import UIKit

class ViewController: UIViewController {

    var objClass: UserClass?
    var objStruct: UserStructure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objClass = UserClass.init(id: 1, name: "da", email: "abc@gmail.com")
        objStruct = UserStructure.init(id: 1, name: "sneha", email: "sneha@gmail.com")
        
        print("class-Name:",objClass?.name ?? "")
        print("Structure-Name",objStruct?.name ?? "")
        
    }

    @IBAction func nextButtonAction(_ sender: UIButton) {
        
        let nextVC = storyboard?.instantiateViewController(identifier: "SecondVC") as! SecondVC
        
        nextVC.objBackScreenClass = objClass
        nextVC.objBackScreenStructure = objStruct
        
        navigationController?.pushViewController(nextVC, animated: true)
        objClass?.name = "Darshan"
        objStruct?.name = "Foram"
        print("class-Name:",objClass?.name ?? "")
        print("Structure-Name",objStruct?.name ?? "")
        
    }
    
}

