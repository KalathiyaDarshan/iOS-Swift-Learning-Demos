//
//  LoginVC.swift
//  APIDemo
//
//  Created by mac on 18/07/24.
//

//email :"manali.bluepixel@gmail.com"
//password :"Sure@1234"

import UIKit

class LoginVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------

    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        emailTF.text = ""
        passwordTF.text = ""
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func loginAction(_ sender: UIButton) {
        let email = emailTF.text ?? ""
        let password = passwordTF.text ?? ""
        
        if email.isEmpty {
            showAlert(message: "Email cannot be empty.")
        }
        else if password.isEmpty {
            showAlert(message: "password cannot be empty.")
        }
        else {
            
            let objLogin = Login.init(email: emailTF.text ?? "", password: passwordTF.text ?? "")
            let objuser = User(navigationDelegate: self)
            objuser.lognUser(obj: objLogin)
            
        }
    }
    
    @IBAction func registerNowAction(_ sender: UIButton) {
        
        let nextVc = storyboard?.instantiateViewController(identifier: "RegisterVC") as! RegisterVC
        navigationController?.pushViewController(nextVc, animated: true)
        
    }
    
}

extension LoginVC: NavigateDelegate {
    func navigateAnotherScreen() {
        DispatchQueue.main.async { [self] in
            
            let nextVc = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
            self.navigationController?.pushViewController(nextVc, animated: true)
        }
    }
    
    func alert(message: String) {
        DispatchQueue.main.async {
            self.showAlert(message: message)
        }
    }
    
}
