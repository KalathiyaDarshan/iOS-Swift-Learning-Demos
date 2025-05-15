//
//  FourthViewController.swift
//  MultipalStroybord
//
//  Created by mac on 17/05/24.
//

import UIKit

class FourthViewController: UIViewController {

    var labelFourth:String = ""
    
    @IBOutlet var lblFourth: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblFourth.text = labelFourth
            }
    
    @IBAction func Actionbutton1(_ sender: UIButton) {
        let theredVC = storyboard?.instantiateViewController(withIdentifier: "TheredViewController") as! TheredViewController
        theredVC.labelThered = labelFourth
        self.navigationController?.pushViewController(theredVC, animated: true)
    }
    
    @IBAction func ActunButton(_ sender: UIButton) {
        let nextStoryVc = UIStoryboard(name: "Second", bundle: nil).instantiateViewController(withIdentifier: "SecondstoryViewController") as! SecondstoryViewController
        nextStoryVc.secondstory = labelFourth
        self.navigationController?.pushViewController(nextStoryVc, animated: true)
        
    }
    

}
