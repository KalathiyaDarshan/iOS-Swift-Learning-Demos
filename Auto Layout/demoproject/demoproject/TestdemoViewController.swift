//
//  TestdemoViewController.swift
//  demoproject
//
//  Created by Mayur Mori on 08/05/24.
//

import UIKit

class TestdemoViewController: UIViewController {

    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fielddesighn(view: viewEmail)
        fielddesighn(view: viewPassword)
        fielddesighn(view: btnSubmit)
        colorgredient(view: btnSubmit)
       
    }
    
}
func colorgredient(view:UIView)
{
    let color1 = UIColor(red: 69/255, green: 39/255, blue: 160/255, alpha: 1.0) // #4527A0
    let color2 = UIColor(red: 123/255, green: 87/255, blue: 228/255, alpha: 1.0) // #7B57E4
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = view.bounds
    gradientLayer.colors = [color1.cgColor, color2.cgColor] // Array of CGColor
    gradientLayer.startPoint = CGPoint(x: 0, y: 1)
    gradientLayer.endPoint = CGPoint(x: 1,y: 1)
    view.layer.insertSublayer(gradientLayer, at: 0)
    view.clipsToBounds = true
    
}

func fielddesighn(view:UIView)
{
    view.layer.borderColor = UIColor.lightGray.cgColor
    view.layer.cornerRadius = 10
    view.layer.borderWidth = 0
    }
