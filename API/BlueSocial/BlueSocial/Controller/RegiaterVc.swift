//
//  RegiaterVc.swift
//  BlueSocial
//
//  Created by mac on 26/07/24.
//

import UIKit

class RegiaterVc: UIViewController {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var backBtnView: UIView!
    @IBOutlet var emailTFView: UIView!
    @IBOutlet var passwordTFView: UIView!
    @IBOutlet var loginBtnView: UIView!
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet var lblPasswordAlert: UILabel!
    @IBOutlet var lblEmailAlert: UILabel!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------

    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        cornerRadius(view: backBtnView)
        cornerRadius(view: emailTFView)
        cornerRadius(view: passwordTFView)
        cornerRadius(view: loginBtnView)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func cornerRadius(view:UIView)
    {
        if view == backBtnView {
            view.layer.cornerRadius = 22
        }else {
            view.layer.cornerRadius = 14
        }
        
        view.layer.borderWidth = 0
        view.layer.masksToBounds = true
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func backBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func privacyPolicyBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func termsBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
    }
    
    // ----------------------------------------------------------
    //                       MARK: - API Calling -
    // ----------------------------------------------------------


    

}
