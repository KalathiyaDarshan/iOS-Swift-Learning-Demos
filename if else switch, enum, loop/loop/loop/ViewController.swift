//
//  ViewController.swift
//  loop
//
//  Created by mac on 16/05/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let allcases: [Month] = [.jan, .february, .march, .april, .may, .april, .may,.june,.july,.august,.september,.october,.november,.december]
       
        for mn in allcases{
            print(mn.rawValue)
        }

    }


}
enum  Month: String {
    case jan = "January is a 1  Month"
    case february = "Februry is a 2 Month"
    case march = "March is a 3 Month"
    case april = "April is a 4 Month"
    case may = "May is a 5 Month"
    case june = "June is a 6 Month"
    case july = "July is a 7 Month"
    case august = "August is a 8 Month"
    case september = "September is a 9 Month"
    case october = "October is a 10 Month"
    case november = "November is a 11 Month"
    case december = "December is a 12 Month"
}
