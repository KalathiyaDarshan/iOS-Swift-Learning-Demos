//
//  SuccessVC.swift
//  BLEPremiumDesign
//
//  Created by Darshan Kalathiya on 25/12/24.
//

import UIKit

class SuccessVC: UIViewController {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var succsessResult: (() -> Void)?
    var dismissTimer: Timer?

    // ----------------------------------------------------------
    //             MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Start a timer that will fire after 5 seconds
        dismissTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(dismissViewController), userInfo: nil, repeats: false)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Functions -
    // ----------------------------------------------------------
    // Dismiss the view controller
    @objc func dismissViewController() {
        self.succsessResult?()
        dismiss(animated: true, completion: nil)
        
        // Invalidate the timer to release it
        dismissTimer?.invalidate()
        dismissTimer = nil
    }
    
    deinit {
        // Ensure timer is invalidated when the view controller is deallocated
        dismissTimer?.invalidate()
    }
}
