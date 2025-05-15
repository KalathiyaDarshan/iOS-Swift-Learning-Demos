//
//  ViewController.swift
//  TableView
//
//  Created by mac on 04/06/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var txtNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        txtNumber.text = ""
    }

    @IBAction func actionNext(_ sender: UIButton) {
        
        let nextVc = storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        nextVc.cellCount = Int(txtNumber.text ?? "") ?? 0
        navigationController?.pushViewController(nextVc, animated: true)
    }
}

