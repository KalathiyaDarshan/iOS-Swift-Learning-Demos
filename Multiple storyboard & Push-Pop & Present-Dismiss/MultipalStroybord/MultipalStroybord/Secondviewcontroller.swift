//
//  Secondviewcontroller.swift
//  MultipalStroybord
//
//  Created by mac on 17/05/24.
//

import UIKit

class Secondviewcontroller: UIViewController {

    @IBOutlet var lblDetail: UILabel!
    var name:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDetail.text = name
        }
    
    @IBAction func ActionButton1(_ sender: Any) {
        let theredVC = storyboard?.instantiateViewController(withIdentifier: "TheredViewController") as! TheredViewController
        theredVC.labelThered = name
        self.navigationController?.pushViewController(theredVC, animated: true)
    }
    
    
    @IBAction func ActionButton2(_ sender: Any) {
        let FourthVC = storyboard?.instantiateViewController(withIdentifier: "FourthViewController") as! FourthViewController
        FourthVC.labelFourth = name
        self.navigationController?.pushViewController(FourthVC, animated: true)
    
    }
    
    @IBAction func ActionButton3(_ sender: Any) {
  
        let nextStoryVc = UIStoryboard(name: "Second", bundle: nil).instantiateViewController(withIdentifier: "SecondstoryViewController") as! SecondstoryViewController
        nextStoryVc.secondstory = name
        self.navigationController?.pushViewController(nextStoryVc, animated: true)
        
        
    }
    
}
