//
//  ViewController.swift
//  OOPPS Encapsulation
//
//  Created by mac on 30/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var txtAge: UITextField!
    @IBOutlet var txtName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        let nextVc = storyboard?.instantiateViewController(identifier: "FinallViewController") as! FinallViewController
        let objPerson = Person()
        objPerson.details(txtname: txtName, txtage: txtAge)
        nextVc.objPrevious = objPerson
        navigationController?.pushViewController(nextVc, animated: true)
    }
}

class Person {
    var name:String = ""
    var age:Int = 0
    
    func details(txtname: UITextField,txtage: UITextField){
        self.name = txtname.text ?? ""
        self.age = Int(txtage.text ?? "") ?? 0
    }
}
