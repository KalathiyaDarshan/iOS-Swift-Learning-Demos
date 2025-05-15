//
//  RegisterVC.swift
//  APIDemo
//
//  Created by mac on 18/07/24.
//

import UIKit

class RegisterVC: UIViewController{
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var nameTF: UITextField!
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
        nameTF.text = ""
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
    @IBAction func RegisterAction(_ sender: UIButton) {
        let objValidation =  Validation()
        let name = nameTF.text ?? ""
        let email = emailTF.text ?? ""
        let password = passwordTF.text ?? ""
        
        if name.isEmpty {
            showAlert(message: "Name cannot be empty.")
        }
       else if email.isEmpty {
            showAlert(message: "Email cannot be empty.")
        }
        else if password.isEmpty {
            showAlert(message: "password cannot be empty.")
        }
        else {
            
            if !objValidation.isValidName(name) {
                showAlert(message: "Name is Not Valid.")
            }
            else if !objValidation.isValidEmail(email) {
                showAlert(message: "Email is Not Valid.")
            }
            else if !objValidation.isValidPassword(password) {
                showAlert(message: "Password is Not Valid.")
            }
            else {
                let objRegister = Register.init(name: nameTF.text ?? "", email: emailTF.text ?? "", password: passwordTF.text ?? "")
                let objUser = User(navigationDelegate: self)
                objUser.callRegisterUserAPI(obj: objRegister)
            }
        }
        
    }
    
    @IBAction func backLoginAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension RegisterVC: NavigateDelegate {
    func navigateAnotherScreen() {
        DispatchQueue.main.async {
            // Safe to use UIViewController.init(coder:) or UIViewController.storyboard here
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
