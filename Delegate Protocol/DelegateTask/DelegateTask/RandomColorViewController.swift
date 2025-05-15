//
//  RandomColorViewController.swift
//  DelegateTask
//
//  Created by mac on 31/05/24.
//

import UIKit

class RandomColorViewController: UIViewController {
    
    @IBOutlet var viewColor: UIView!
    
    var objPeraviorsNo: Int?
    var color: UIColor?
    
    // MARK: Step-2 Object Create
    var randomDelegate: SendData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewColor.layer.cornerRadius = viewColor.frame.width/2
        viewColor.clipsToBounds = true
     
    }
    
    @IBAction func actionCreatColor(_ sender: UIButton) {
        
        viewColor.backgroundColor = .random()
      
        // MARK: Step-3 Delegate Implement
        randomDelegate?.randomdata(txtColor: viewColor.backgroundColor!, txtRandomNo: objPeraviorsNo ?? 0)

    }
    
    @IBAction func actionHome(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}



extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(in: 0...1),
            green: .random(in: 0...1),
            blue:  .random(in: 0...1),
            alpha: 1.0
        )
    }
}

// MARK: Step-1 Define a Protocol
protocol SendData {
    func randomdata(txtColor: UIColor,txtRandomNo: Int)
}
