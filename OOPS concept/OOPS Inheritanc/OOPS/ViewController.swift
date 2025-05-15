//
//  ViewController.swift
//  OOPS
//
//  Created by mac on 30/05/24.
//

import UIKit

class ViewController: UIViewController {
    
     @IBOutlet var txtCarName: UITextField!
    @IBOutlet var txtFunctions: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
            
             }
    
    @IBAction func ActionSubmit(_ sender: UIButton) {
        let nextVc = storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        let objCar = CarName()
        objCar.modelDetail(txtmodel: txtCarName)
        objCar.carDetail(txtfunctions: txtFunctions)
        nextVc.objCarModel = objCar
        navigationController?.pushViewController(nextVc, animated: true)
    }
}

// Inheritanc
class CarFunctions{
    var functions: String = ""
    
    func carDetail(txtfunctions: UITextField) {
        self.functions = txtfunctions.text ?? ""
    }
}
class CarName: CarFunctions{
    var modelName:String = ""
    
    func modelDetail(txtmodel: UITextField){
        self.modelName = txtmodel.text ?? ""
       }
}
