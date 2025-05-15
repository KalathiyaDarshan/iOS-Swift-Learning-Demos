//
//  DashbordVC.swift
//  BLEPremiumDesign
//
//  Created by Darshan Kalathiya on 25/12/24.
//

import UIKit

class DashboardVC: UIViewController {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    
    // ----------------------------------------------------------
    //             MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func onBtnCloud(_ sender: UIButton) {
        let subscriptionVC = storyboard?.instantiateViewController(withIdentifier: "SubscriptionPopup") as! SubscriptionPopup
        subscriptionVC.modalPresentationStyle = .overFullScreen
       
        subscriptionVC.popupResult = { result in
            if result == .success {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.presentSuccessPopup()
                }
            } else {
                print("Popup was canceled by the user.")
            }
        }
        present(subscriptionVC, animated: true)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Functions -
    // ----------------------------------------------------------
    func presentSuccessPopup(){
        let successVC = self.storyboard?.instantiateViewController(withIdentifier: "SuccessVC") as! SuccessVC
        successVC.modalPresentationStyle = .overFullScreen
        successVC.succsessResult = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.pushServerScreen()
            }
        }
        self.present(successVC, animated: true)

    }
    
    func pushServerScreen(){
        let ServerVC = self.storyboard?.instantiateViewController(withIdentifier: "ServerVC") as! ServerVC
        navigationController?.pushViewController(ServerVC, animated: true)
    }
}
