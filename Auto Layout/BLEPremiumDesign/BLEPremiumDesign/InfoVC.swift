//
//  InfoVC.swift
//  BLEPremiumDesign
//
//  Created by Darshan Kalathiya on 26/12/24.
//

import UIKit

class InfoVC: UIViewController {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var lblDetail: UILabel!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var settingOption : SettingOption = .allowDuplicate
    
    // ----------------------------------------------------------
    //             MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
            super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setDescriptionText()
    }
    
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func onBtnOk(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Functions -
    // ----------------------------------------------------------
    func setDescriptionText(){
        var setDesciption = ""
        
        if settingOption == .uploadFrequency{
            setDesciption = "This setting allows you to choose how often the app uploads data to the server. The minimum frequency is 5 seconds, but you can adjust it according to your needs. By clicking on the frequency number, you can edit it. Setting a shorter interval will provide more frequent updates, while a longer interval will reduce the number of uploads."
        }else{
            setDesciption = "When this option is enabled, the app will send duplicate scanned data to the server. This means you can receive updated information such as RSSI (signal strength), distance, and other frequently changing values from the same device, even if it has been scanned before.\nIf this option is disabled, the app will not send data from devices with the same MAC address more than once. As a result, you won\'t get updated RSSI, distance, and other frequently changing values for those devices."
        }
        
        lblDetail.text = setDesciption
    }
}

enum SettingOption {
    case allowDuplicate
    case uploadFrequency
}
