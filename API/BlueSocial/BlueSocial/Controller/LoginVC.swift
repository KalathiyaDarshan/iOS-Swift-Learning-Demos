//
//  ViewController.swift
//  BlueSocial
//
//  Created by mac on 26/07/24.
//

import UIKit

class LoginVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var backBtnView: UIView!
    @IBOutlet var emailTFView: UIView!
    @IBOutlet var passwordTFView: UIView!
    @IBOutlet var loginBtnView: UIView!
    
    @IBOutlet var loginBtn: UIButton!
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet var lblPasswordAlert: UILabel!
    @IBOutlet var lblEmailAlert: UILabel!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    let objValidation =  Validation()
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cornerRadius(view: backBtnView)
        cornerRadius(view: emailTFView)
        cornerRadius(view: passwordTFView)
        cornerRadius(view: loginBtnView)
        
        emailTF.delegate = self
        passwordTF.delegate = self
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
    
    func loginButtonEnable() {
        
        let email = emailTF.text ?? ""
        let password = passwordTF.text ?? ""
        let emailTrimmedString = email.trimmingCharacters(in: .whitespaces)
        let passwordTrimmedString = email.trimmingCharacters(in: .whitespaces)
        
        if email.isEmpty || password.isEmpty || emailTrimmedString.isEmpty || passwordTrimmedString.isEmpty {
            loginBtn.isEnabled = false
            loginBtn.backgroundColor = .textFieldColor
            loginBtn.setTitleColor(.fontColor, for: .normal)
        }else {
            loginBtn.isEnabled = true
            loginBtn.backgroundColor = .buttonColor
            loginBtn.setTitleColor(.white, for: .normal)
        }
    }
    
    func navigateHomeScreen(userId : String) {
        DispatchQueue.main.async {
            let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
            UserLocalData.saveUserId = userId
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Blue", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func backBtnAction(_ sender: UIButton) {
        exit(0)
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
    
        let email = emailTF.text ?? ""
        
        if !objValidation.isValidEmail(email) {
            lblEmailAlert.isHidden = false
            emailTF.becomeFirstResponder()
            emailTFView.layer.borderWidth = 0.5
            emailTFView.layer.borderColor = UIColor.red.cgColor
            
        }else {
            lblEmailAlert.isHidden = true
            emailTFView.layer.borderWidth = 0.0
            emailTFView.layer.borderColor = UIColor.clear.cgColor
            callLoginApi()
        }
        
    }
    
    @IBAction func privacyPolicyBtnAction(_ sender: UIButton) {
        print("Privacy Policy")
    }
    
    @IBAction func termsBtnAction(_ sender: UIButton) {
        print("Terms And Condition")
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        
        let registerVC = storyboard?.instantiateViewController(identifier: "RegisterVC") as! RegisterVC
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @IBAction func eyeButtonAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            passwordTF.isSecureTextEntry = false
        }else {
            passwordTF.isSecureTextEntry = true
        }
    }
    // ----------------------------------------------------------
    //                       MARK: - API Calling -
    // ----------------------------------------------------------
    func callLoginApi() {
        let url = "https://blehealthplus.com/demo/index.php/api/login"
        
        let dataDictionary: [String: Any] = ["email": emailTF.text ?? "",
                                             "password": passwordTF.text ?? "",
                                             "device_type":"iOS",
                                             "fcmToken":"" ]
        
        print("Login Parameters are::------", dataDictionary)

        APIService.loginUser(url: url, method: .post, dataDictionary: dataDictionary ) { result in
            switch result {
                case .success(let loginResponse):
                    
                    if loginResponse.status == true {
                        
                        print("Login successful! Token: \(loginResponse.data?.user_id ?? "")")
                        
                        self.navigateHomeScreen(userId: loginResponse.data?.user_id ?? "")
                        
                    } else {
                        
                        print("Login failed: \(loginResponse.message ?? "Unknown error")")
                        
                        DispatchQueue.main.async {
                            self.showAlert(message: "Invalid email or Password")
                        }
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    
            }
        }
    }
    
   
}

extension LoginVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case emailTF:
                passwordTF.becomeFirstResponder()
            case passwordTF:
                passwordTF.resignFirstResponder() // dismisses the keyboard
            default:
                textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let email = emailTF.text ?? ""
        
        emailTFView.layer.borderWidth = 0.0
        passwordTFView.layer.borderWidth = 0.0
        
        if textField == emailTF {
            if email.isEmpty {
                emailTFView.layer.borderWidth = 0.5
                emailTFView.layer.borderColor = UIColor.blue.cgColor // Border color when focused
            }else {
                emailTFView.layer.borderWidth = 0.5
            }
        }
        
        
        if textField == passwordTF {
            passwordTFView.layer.borderWidth = 0.5
            passwordTFView.layer.borderColor = UIColor.blue.cgColor // Border color when focused
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        loginButtonEnable()
        
    }
}
