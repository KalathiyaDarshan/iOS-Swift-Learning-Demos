//
//  Loader.swift
//  UBFit
//
//  Created by mac on 22/08/24.
//

import Foundation
import MBProgressHUD

class Loader {
    
    static let shared = Loader()
    
    func indicatorStart(view: UIView){
        // Show MBProgressHUD
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
    
        // Optional: Customize the appearance (optional)
        hud.contentColor = .black
        hud.alpha = 0.9
    }
    
    func indicatorStop(view: UIView){
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
}
