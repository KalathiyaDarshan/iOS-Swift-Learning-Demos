//
//  ViewController.swift
//  BLEPremiumDesign
//
//  Created by Darshan Kalathiya on 24/12/24.
//

import UIKit

class SubscriptionPopup: UIViewController {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblDescription1: UILabel!
    @IBOutlet weak var lblDescription2: UILabel!
    @IBOutlet weak var lblDescription3: UILabel!
    @IBOutlet weak var lblDescription4: UILabel!
    @IBOutlet weak var lblDescription5: UILabel!

    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var popupResult: ((popupResultEnum) -> Void)?
    
    // ----------------------------------------------------------
    //             MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func onBtnClose(_ sender: UIButton) {
        popupResult?(.cancel)
        dismiss(animated: true)
    }

    @IBAction func onBtnSubscribeNow(_ sender: UIButton) {
        popupResult?(.success)
        dismiss(animated: true)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Functions -
    // ----------------------------------------------------------
    func setupUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        lblPrice.text = "$ 29.99 / mo"
        
        lblDescription1.setTitleAndDescription(title: "Cloud Upload:", description: "Seamlessly upload your BLE devices data to your preferred cloud service.")
        lblDescription2.setTitleAndDescription(title: "Customize Time Interval:", description: "Set specific intervals for uploading your data to fit your needs.")
        lblDescription3.setTitleAndDescription(title: "Duplicate Data Control:", description: "Chose to allow or disallow duplicate device data to maintain clean and accurate records.")
        lblDescription4.setTitleAndDescription(title: "Enhanced Data Security:", description: "Keep your data safe and accessible from anywhare")
        lblDescription5.setTitleAndDescription(title: "Ad-Free Experience:", description: "Enjoy an uninterrupted, ad-free experience.")
    }
}

enum popupResultEnum {
    case success
    case cancel
}
