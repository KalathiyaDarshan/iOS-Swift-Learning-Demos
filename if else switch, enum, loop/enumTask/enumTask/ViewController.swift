//
//  ViewController.swift
//  enumTask
//
//  Created by mac on 16/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var txtTemp: UITextField!
    @IBOutlet var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func ActionSubmit(_ sender: Any) {
        
        if Int(txtTemp.text ?? "") ?? 0 >= 40{
            whether(tmperater: .sunny)
        }
        else if Int(txtTemp.text ?? "") ?? 0 >= 20{
            whether(tmperater: .cloud)
        }
        else if Int(txtTemp.text ?? "") ?? 0 >= 10{
            whether(tmperater: .rainy)
        }
        else if Int(txtTemp.text ?? "") ?? 0 < 10{
            whether(tmperater: .snow)
        }
    
    }
    
    func whether(tmperater: temp){
        switch tmperater {
            case .sunny:
                print("temp is \(txtTemp.text ?? "") and whether is sunny")
            case .cloud:
                print("temp is \(txtTemp.text ?? "") and whether is cloud")
            case .rainy:
                print("temp is \(txtTemp.text ?? "") and whether is rainy")
            case .snow:
                print("temp is \(txtTemp.text ?? "") and whether is snow")
//            default:
//                print("not valid temp")
        }
    }
}

enum temp{
    case sunny
    case cloud
    case rainy
    case snow
}
