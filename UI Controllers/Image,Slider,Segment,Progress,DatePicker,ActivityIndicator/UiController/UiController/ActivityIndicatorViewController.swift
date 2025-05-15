//
//  ActivityIndicatorViewController.swift
//  UiController
//
//  Created by mac on 27/05/24.
//

import UIKit

class ActivityIndicatorViewController: UIViewController {

    @IBOutlet var AcIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func StartAction(_ sender: Any) {
         AcIndicator.startAnimating()
    }
    
    @IBAction func StopAction(_ sender: Any) {
        AcIndicator.stopAnimating()
    }
    

}
