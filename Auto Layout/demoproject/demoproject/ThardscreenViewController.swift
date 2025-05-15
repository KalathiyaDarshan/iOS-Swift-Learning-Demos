//
//  ThardscreenViewController.swift
//  demoproject
//
//  Created by Mayur Mori on 09/05/24.
//

import UIKit

class ThardscreenViewController: UIViewController {

   @IBOutlet weak var imgposter: UIImageView!
    @IBOutlet weak var Sliderplayer: UISlider!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnpause: UIButton!
    @IBOutlet weak var viewPause: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var btnwidth = btnLeft.frame.width
        var btnpausewidth = btnpause.frame.width
        
        btnRedius(btn: btnLeft, btnwidth: btnwidth)
        btnRedius(btn: btnpause, btnwidth: btnpausewidth)
        fielddesighn(view: imgposter)
        colorgredient(view: btnpause)
        viewPause.layer.shadowColor = UIColor(red: 69/255, green: 39/255, blue: 160/255, alpha: 1).cgColor
        viewPause.layer.shadowOpacity = 0.5
        viewPause.layer.shadowOffset = CGSize(width: 0, height: 5)
        
}
    

}

func btnRedius(btn: UIButton,btnwidth: CGFloat){
    
    btn.layer.cornerRadius = btnwidth/2
    btn.layer.shadowOpacity = 0.5
   btn.layer.shadowOffset = CGSize(width: 0, height: 2)
    btn.layer.masksToBounds = false
    
}
