//
//  SecondViewController.swift
//  navigation&segue
//
//  Created by mac on 16/05/24.
//

import UIKit
protocol send {
    func senddata(detail: String)
}
class SecondViewController: UIViewController {
    
    @IBOutlet var lblShow: UILabel!
    var name: String = ""
    var datadelegate: send?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblShow.text = name
        
    }
    
    
    @IBAction func BackAction(_ sender: UIButton) {
        self.datadelegate?.senddata(detail: "Hello")
        navigationController?.popViewController(animated: true)
        //dismiss(animated: true, completion: nil)
    }
 /*
    override func viewWillDisappear(_ animated: Bool) {
        print("Second",#function)
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("Second",#function)
    }
    override func viewWillAppear(_ animated: Bool) {
        print("Second",#function)
    }
    override func viewDidAppear(_ animated: Bool) {
        print("Second",#function)
    }
 */
}
