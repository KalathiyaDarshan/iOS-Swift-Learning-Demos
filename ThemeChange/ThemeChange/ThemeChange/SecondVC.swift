//
//  SecondVC.swift
//  ThemeChange
//
//  Created by Darshan Kalathiya on 18/12/24.
//

import UIKit

class SecondVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var lblNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        applyTheme()
    }
    
    func applyTheme() {
        view.setupGradientColors(
            firstGradientColor: .appGradient1(),
            secondGradientColor: .appGradient2()
        )
    }
}
