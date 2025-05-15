//
//  SecondstoryViewController.swift
//  MultipalStroybord
//
//  Created by mac on 17/05/24.
//

import UIKit

class SecondstoryViewController: UIViewController {

    @IBOutlet var lblsecondstory: UILabel!
   
    var secondstory:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
      //  SecondstoryViewController
        lblsecondstory.text = secondstory
       }
    
    @IBAction func ActionButon(_ sender: Any) {
        let theredVC = UIStoryboard(name: "Second", bundle: nil).instantiateViewController(withIdentifier: "SecondStorybordSecondViewController") as! SecondStorybordSecondViewController
        theredVC.labelsecondStory = secondstory
        self.navigationController?.pushViewController(theredVC, animated: true)
   
    }
    
  

}
