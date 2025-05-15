//
//  UploadFrequencyVC.swift
//  BLEPremiumDesign
//
//  Created by Darshan Kalathiya on 26/12/24.
//

import UIKit

class UploadFrequencyVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var txtSecond: CustomTextField!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var uploadCallBack: ((_ second: Int) -> Void)?
    var setTxtSecond: Int = 0
    
    // ----------------------------------------------------------
    //             MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        txtSecond.text = "\(objUserDefaultUtils.serverDetail.uploadFrequencySecond)"
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func onBtnOk(_ sender: UIButton) {
        let txtSecondInt = Int(txtSecond.text ?? "") ?? 0

        uploadCallBack?(Int(txtSecondInt))
        dismiss(animated: true)
    }
    
    @IBAction func onBtnCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
