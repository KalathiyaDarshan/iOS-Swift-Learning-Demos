//
//  ProgressViewController.swift
//  UiController
//
//  Created by mac on 27/05/24.
//

import UIKit

class ProgressViewController: UIViewController {

    @IBOutlet var progressView: UIProgressView!
       override func viewDidLoad() {
        super.viewDidLoad()
      //  ProgressView.progressViewStyle = .bar // .defalut
        progressView.progress = 0.1
        progressView.setProgress(1, animated: true)
    
        }
    
}
