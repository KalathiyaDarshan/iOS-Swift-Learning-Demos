//
//  RegisterVC.swift
//  BlueSocial
//
//  Created by mac on 29/07/24.
//

import UIKit

class RegisterVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var nameTFView: UIView!
    @IBOutlet var lastNameTFView: UIView!
    @IBOutlet var backBtnView: UIView!
    @IBOutlet var emailTFView: UIView!
    @IBOutlet var passwordTFView: UIView!
    @IBOutlet var registerBtnView: UIView!
    
    @IBOutlet var registerBtn: UIButton!
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var lastNameTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    
    @IBOutlet var lblNameAlert: UILabel!
    @IBOutlet var lblLastNameAlert: UILabel!
    @IBOutlet var lblPasswordAlert: UILabel!
    @IBOutlet var lblEmailAlert: UILabel!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    let objValidation = Validation()
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cornerRadius(view: backBtnView)
        cornerRadius(view: emailTFView)
        cornerRadius(view: passwordTFView)
        cornerRadius(view: registerBtnView)
        cornerRadius(view: nameTFView)
        cornerRadius(view: lastNameTFView)
        
        nameTF.delegate = self
        lastNameTF.delegate = self
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
    
    func registerButtonEnable() {
        
        let name = nameTF.text ?? ""
        let lastName = lastNameTF.text ?? ""
        let email = emailTF.text ?? ""
        let password = passwordTF.text ?? ""
        let emailTrimmedString = email.trimmingCharacters(in: .whitespaces)
       
        if name.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || !objValidation.isValidPassword(password) || emailTrimmedString.isEmpty {
            
            registerBtn.isEnabled = false
            registerBtn.backgroundColor = .textFieldColor
            registerBtn.setTitleColor(.fontColor, for: .normal)
        } else {
            registerBtn.isEnabled = true
            registerBtn.backgroundColor = .buttonColor
            registerBtn.setTitleColor(.white, for: .normal)
        }
    }
    
    func textFieldValidation() {
        
        let name = nameTF.text ?? ""
        let lastName = lastNameTF.text ?? ""
        let email = emailTF.text ?? ""
        
        if !objValidation.isValidName(name) {
            lblNameAlert.isHidden = false
            nameTF.becomeFirstResponder()
            nameTFView.layer.borderWidth = 0.5
            nameTFView.layer.borderColor = UIColor.red.cgColor
        }else {
            lblNameAlert.isHidden = true
            nameTFView.layer.borderWidth = 0.5
            nameTFView.layer.borderColor = UIColor.blue.cgColor
            
            if !objValidation.isValidName(lastName) {
                lblLastNameAlert.isHidden = false
                lastNameTF.becomeFirstResponder()
                lastNameTFView.layer.borderWidth = 0.5
                lastNameTFView.layer.borderColor = UIColor.red.cgColor
            }else {
                lblLastNameAlert.isHidden = true
                lastNameTFView.layer.borderWidth = 0.5
                lastNameTFView.layer.borderColor = UIColor.blue.cgColor
                
                if !objValidation.isValidEmail(email) {
                    lblEmailAlert.isHidden = false
                    emailTF.becomeFirstResponder()
                    emailTFView.layer.borderWidth = 0.5
                    emailTFView.layer.borderColor = UIColor.red.cgColor
                    
                }else {
                    lblEmailAlert.isHidden = true
                    emailTFView.layer.borderWidth = 0.5
                    emailTFView.layer.borderColor = UIColor.blue.cgColor
                    callRegisterApi()
                }
            }
        }
    }
    
    func navigateHomeScreen() {
        DispatchQueue.main.async {
            let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
           
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
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerBtnAction(_ sender: UIButton) {
        textFieldValidation()
    }
    
    @IBAction func privacyPolicyBtnAction(_ sender: UIButton) {
        print("Privacy policy")
    }
    
    @IBAction func termsBtnAction(_ sender: UIButton) {
        print("Terms of Use")
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
    func callRegisterApi() {
        let url = "https://blehealthplus.com/demo/index.php/api/userregister"
        
        let dataDictionary: [String: Any] = [ "name":"\(nameTF.text ?? "") \(lastNameTF.text ?? "")",
                                              "phone":"98294829398",
                                              "username":nameTF.text ?? "",
                                              "email":emailTF.text ?? "",
                                              "password":passwordTF.text ?? "",
                                              "height":"56",
                                              "weight":"45",
                                              "gender":"Male",
                                              "image":"profile.jpg",
                                              "device_type":"IOS" ]
        
        APIService.registerUser(url: url, method: .post, dataDictionary: dataDictionary ) { result in
            
            print("Response:------", result)
            switch result {
                case .success(let registerResponse):
                    
                    if registerResponse.status == true {
                        
                        print("Registration successful! Token: \(registerResponse.data?.user_id ?? 0)")
                        UserLocalData.saveUserId = "\(registerResponse.data?.user_id ?? 0)"
                        
                        self.navigateHomeScreen()
                        
                    } else {
                        print("Registration failed: \(registerResponse.message ?? "Unknown error")")
                        
                        DispatchQueue.main.async {
                            
                        self.showAlert(message: "\(registerResponse.message ?? "")")
                            
                        }
                    }
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    
            }
        }
    }
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case nameTF:
                lastNameTF.becomeFirstResponder()
            case lastNameTF:
                emailTF.becomeFirstResponder()
            case emailTF:
                passwordTF.becomeFirstResponder()
            case passwordTF:
                textField.resignFirstResponder() // dismisses the keyboard
            default:
                textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == nameTF || textField == lastNameTF {
            let allowedCharacters = CharacterSet.letters
                    let characterSet = CharacterSet(charactersIn: string)
                    return false || allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let email = emailTF.text ?? ""
        let name = nameTF.text ?? ""
        let lastName = lastNameTF.text ?? ""
        let password = passwordTF.text ?? ""
        
        nameTFView.layer.borderWidth = 0.0
        lastNameTFView.layer.borderWidth = 0.0
        emailTFView.layer.borderWidth = 0.0
        passwordTFView.layer.borderWidth = 0.0
        
        if textField == nameTF {
            
            if name.isEmpty {
                
                nameTFView.layer.borderWidth = 0.5
                nameTFView.layer.borderColor = UIColor.blue.cgColor // Border color when focused
            }else {
                    nameTFView.layer.borderWidth = 0.5
            }
        }
        
        if textField == lastNameTF {
            
            if lastName.isEmpty {
                
                lastNameTFView.layer.borderWidth = 0.5
                lastNameTFView.layer.borderColor = UIColor.blue.cgColor // Border color when focused
            }else {
                
                    lastNameTFView.layer.borderWidth = 0.5
            }
        }
        
        if textField == emailTF {
            
            if email.isEmpty {
                
                emailTFView.layer.borderWidth = 0.5
                emailTFView.layer.borderColor = UIColor.blue.cgColor // Border color when focused
            }else {
                
                    emailTFView.layer.borderWidth = 0.5
            }
        }
        
        if textField == passwordTF {
            
            if password.isEmpty {
                
                passwordTFView.layer.borderWidth = 0.5
                passwordTFView.layer.borderColor = UIColor.blue.cgColor // Border color when focused
            }else {
                    passwordTFView.layer.borderWidth = 0.5
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let password = passwordTF.text ?? ""
        registerButtonEnable()
        
        if textField == passwordTF {
            
            if !objValidation.isValidPassword(password) {
                
                lblPasswordAlert.isHidden = false
                lblPasswordAlert.text = "Password must be at least 8 characters long and contain at least one uppercase letter,one lowercase letter,one digit, and one special character"
                passwordTFView.layer.borderWidth = 0.5
                passwordTFView.layer.borderColor = UIColor.red.cgColor
            } else {
                lblPasswordAlert.isHidden = true
                passwordTFView.layer.borderWidth = 0.5
                passwordTFView.layer.borderColor = UIColor.blue.cgColor
            }
        }
    }
    
}
