//
//  SecondStorybordSecondViewController.swift
//  MultipalStroybord
//
//  Created by mac on 17/05/24.
//

import UIKit

class SecondStorybordSecondViewController: UIViewController {

    @IBOutlet var lblSecondStory: UILabel!
    var labelsecondStory: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lblSecondStory.text = labelsecondStory
       }
    
    @IBAction func SecondAction(_ sender: Any) {
        let theredVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TheredViewController") as! TheredViewController
        theredVC.labelThered = labelsecondStory
        self.navigationController?.pushViewController(theredVC, animated: true)
    
    }
    
   
}
