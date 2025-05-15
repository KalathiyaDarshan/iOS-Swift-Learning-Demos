//
//  FirstVC.swift
//  ThemeChange
//
//  Created by Darshan Kalathiya on 18/12/24.
//

import UIKit

class FirstVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var lblNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyThemeToParentView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       // applyThemeToChiledView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        applyThemeToParentView()
    }
    
    func applyThemeToParentView() {
        view.setupGradientColors(
            firstGradientColor: .appGradient1(),
            secondGradientColor: .appGradient2()
        )
    }
    
//    func applyThemeToChiledView() {
//        mainView.setupGradientColors(
//            firstGradientColor: .appGradient1(),
//            secondGradientColor: .appGradient2()
//        )
//    }
    
    
}
