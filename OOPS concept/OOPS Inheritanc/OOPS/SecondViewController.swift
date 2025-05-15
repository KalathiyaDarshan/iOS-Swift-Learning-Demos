//
//  SecondViewController.swift
//  OOPS Inheritanc
//
//  Created by mac on 30/05/24.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var lblCarName: UILabel!
    @IBOutlet var lblFunctions: UILabel!
    var objCarModel: CarName?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCarName.text = objCarModel?.modelName
        lblFunctions.text = objCarModel?.functions
        
       }
}
