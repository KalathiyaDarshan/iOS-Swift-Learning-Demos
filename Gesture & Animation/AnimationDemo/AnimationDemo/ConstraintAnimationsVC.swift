//
//  ConstraintAnimationsVC.swift
//  AnimationDemo
//
//  Created by mac on 16/09/24.
//

import UIKit

class ConstraintAnimationsVC: UIViewController {
    
    override func viewDidLayoutSubviews() {
        print("layout did")
    }
    
    @IBOutlet var viewConstrainTop: NSLayoutConstraint!
   
    let redView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func btnShowViewAcion(_ sender: UIButton) {
        
        UIView.animate(withDuration: 5.0) {
            
            
            self.view.layoutIfNeeded()
            self.viewConstrainTop.constant = 10
        }
        
    }
}
