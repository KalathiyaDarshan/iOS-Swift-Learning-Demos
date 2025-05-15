//
//  ViewController.swift
//  MultipalStroybord
//
//  Created by mac on 17/05/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var txtName: UITextField!
    @IBOutlet var btnSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func Actionsend(_ sender: UIButton) {
        let nextVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Secondviewcontroller") as! Secondviewcontroller
        nextVc.name = txtName.text ?? ""
        self.navigationController?.pushViewController(nextVc, animated: true)
        
    }
    

}

