//
//  ViewController.swift
//  DelegateTask
//
//  Created by mac on 31/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lblRandomNo: UILabel!
    @IBOutlet var viewRandomColor: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewRandomColor.layer.cornerRadius = viewRandomColor.frame.width/2
        viewRandomColor.clipsToBounds = true
    }
    
    @IBAction func nextScreen(_ sender: UIBarButtonItem) {
        
        let nextScreen = storyboard?.instantiateViewController(identifier: "RandomNoViewController") as! RandomNoViewController
        
        // MARK: Step-4 call Delegate
      // nextScreen.randomDelegate1 = self
        navigationController?.pushViewController(nextScreen, animated: true)
    }
}

// MARK: Step-5 Declare
extension ViewController: SendData {
    
    func randomdata(rdObj: RandomColor) {
        
        print("First screen :",rdObj.randomNumber)
        lblRandomNo?.text = "\(rdObj.randomNumber)"
        viewRandomColor?.backgroundColor = rdObj.randomColor
    }
}

