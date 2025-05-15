//
//  ViewController.swift
//  UBFit
//
//  Created by mac on 31/07/24.
//

import UIKit

class LoginVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var emailTFView: UIView!
    @IBOutlet var loginButtonVIew: UIView!
    @IBOutlet var passwordTFView: UIView!
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    @IBOutlet var emailCorrectBtn: UIButton!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    let objValidation =  Validation()
    var loader = Loader.shared
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cornerRadius(view: emailTFView)
        cornerRadius(view: passwordTFView)
        cornerRadius(view: loginButtonVIew)
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
        emailTF.text = "sneha.ok@gmail.com"
        passwordTF.text = "Test@123"
        
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func cornerRadius(view:UIView)
    {
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 0
        view.layer.masksToBounds = true
        
        let emailplaceholderText = "Email*"
        let passwordplaceholderText = "Enter Password*"
        emailTF.attributedPlaceholder = NSAttributedString(string: emailplaceholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.PlaceholderColor])
        passwordTF.attributedPlaceholder = NSAttributedString(string: passwordplaceholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.PlaceholderColor])
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "UBFit", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigateHomeScreen() {
        
        DispatchQueue.main.async {
            
            let newsfeedVC = self.storyboard?.instantiateViewController(identifier: "NewsfeedVC") as! NewsfeedVC
            
            self.navigationController?.pushViewController(newsfeedVC, animated: true)
        }
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func backBtnAction(_ sender: UIButton) {
        exit(0)
    }
    
    
    @IBAction func eyeButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected == true {
            passwordTF.isSecureTextEntry = false
        }else {
            passwordTF.isSecureTextEntry = true
        }
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        let email = emailTF.text ?? ""
        let password = passwordTF.text ?? ""
        
        if email.isEmpty != true {
            
            if objValidation.isValidEmail(email) {
                
                if password.isEmpty != true {
                    
                    if password.count >= 3 {
                        callLoginApi()
                    }else {
                        showAlert(message: "Please enter a password with at least 3 characters")
                    }
                    
                } else {
                    showAlert(message: "Please enter password")
                }
                
            }else {
                showAlert(message: "Please enter valid email")
            }
            
        } else {
            showAlert(message: "Please enter email address")
        }
        
    }
    
    @IBAction func SignUpBtn(_ sender: UIButton) {
        
    }
    
    // ----------------------------------------------------------
    //                       MARK: - API Calling -
    // ----------------------------------------------------------
    func callLoginApi() {
        self.loader.indicatorStart(view: self.view)
        let dataDictionary: [String: Any] = [ "email": emailTF.text ?? "",
                                              "password": passwordTF.text ?? "",
                                              "device_type": "ios",
                                              "fcm_token": "",
                                              "app_version": ""]
        
        print("Login Parameters are::------", dataDictionary)
        
        APIManager.shared.loginUser(url: URLs.login, dataDictionary: dataDictionary ) { result in
            
            self.loader.indicatorStop(view: self.view)
            switch result {
                
                case .success(let loginResponse):
                    
                    if loginResponse.status == true {
                        
                        print("Login successful! Token: \(loginResponse.userInfo?.id ?? "")")
                        UserLocalData.saveUserId = loginResponse.userInfo?.id ?? ""
                        self.navigateHomeScreen()
                        
                    } else {
                        
                        print("Login failed: \(loginResponse.message ?? "Unknown error")")
                        
                        DispatchQueue.main.async {
                            self.showAlert(message: "User not found!")
                        }
                    }
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    
            }
        }
    }
}


extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let email = emailTF.text ?? ""
        if textField == emailTF {
            if objValidation.isValidEmail(email) {
                emailCorrectBtn.isHidden = false
            }else {
                emailCorrectBtn.isHidden = true
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField)
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
}
