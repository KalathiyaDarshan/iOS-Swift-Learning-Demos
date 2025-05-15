//
//  ViewController.swift
//  Enumexample
//
//  Created by mac on 16/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var mn: Month
        
        mn = .jan("Makkar Sankranti")
        
        switch mn {
            case .jan(let hol):
                print("January is a 1  Month, ",hol)
            case .february:
                print("Februry is a 2 Month")
            case .march:
                print("March is a 3 Month")
            case .april:
                print("April is a 4 Month")
            case .may:
                print("May is a 5 Month")
            case .june:
                print("June is a 6 Month")
            case .july:
                print("July is a 7 Month")
            case .august:
                print("August is a 8 Month")
            case .september:
                print("September is a 9 Month")
            case .october:
                print("October is a 10 Month")
            case .november:
                print("November is a 11 Month")
            case .december:
                print("December is a 12 Month")
            default:
                 print("Not Valid Month name")
        }
    }
    
    
}
let jan = "January"
enum  Month {
    case jan(_ holiday: String)
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
}

