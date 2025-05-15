//
//  FinallViewController.swift
//  OOPPS Encapsulation
//
//  Created by mac on 30/05/24.
//

import UIKit

class FinallViewController: UIViewController {
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAge: UILabel!
    var objPrevious: Person?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = objPrevious?.name
        lblAge.text = "\(objPrevious?.age ?? 0)"
    }
}
