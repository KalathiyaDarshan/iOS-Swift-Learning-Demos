//
//  RandomNoViewController.swift
//  DelegateTask
//
//  Created by mac on 31/05/24.
//

import UIKit

class RandomNoViewController: UIViewController{
    
    @IBOutlet var lblPrintNumber: UILabel!
    @IBOutlet var lblRandomNo: UILabel!
    @IBOutlet var viewLable: UIView!
    @IBOutlet var viewColorDisplay: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewLable.layer.cornerRadius = viewLable.frame.width/2
        viewLable.clipsToBounds = true
        
        viewColorDisplay.layer.cornerRadius = viewColorDisplay.frame.width/2
        viewColorDisplay.clipsToBounds = true
    }
    
    @IBAction func actionCreateNo(_ sender: UIButton) {
        
        let no = Int.random(in: 0..<1000)
        lblRandomNo.text = "\(no)"
        
    }
    
    @IBAction func ActionNextVC(_ sender: UIButton) {
        
        let colorVc = storyboard?.instantiateViewController(identifier: "RandomColorViewController") as! RandomColorViewController
        colorVc.objPeraviorsNo = Int(lblRandomNo.text ?? "")
        // MARK: Step-4 Call Delegate
        colorVc.randomDelegate = self
        navigationController?.pushViewController(colorVc, animated: true)
    }
}
// MARK: Step-5 Declare Delegate
extension RandomNoViewController: SendData{
    func randomdata(txtColor: UIColor, txtRandomNo: Int) {
        lblPrintNumber.text = "\(txtRandomNo)"
        viewColorDisplay.backgroundColor = txtColor
    }
    
    
}

