//
//  ServerVC.swift
//  BLEPremiumDesign
//
//  Created by Darshan Kalathiya on 25/12/24.
//

import UIKit

class ServerVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var uploadSubView: UIView!
    @IBOutlet weak var httpsTokenView: UIView!
    @IBOutlet weak var userDetailMQTTView: UIView!

    @IBOutlet weak var btnSecond: CustomButton!
    @IBOutlet weak var btnMQTT: UIButton!
    @IBOutlet weak var btnHTTPS: UIButton!
    
    @IBOutlet weak var mainSV: UIStackView!
    @IBOutlet weak var svHTTPS: UIStackView!
    @IBOutlet weak var svMQTT: UIStackView!

    @IBOutlet weak var imgHttps: UIImageView!
    @IBOutlet weak var imgMqtt: UIImageView!
    
    @IBOutlet weak var switchUpload: UISwitch!
    @IBOutlet weak var switchDuplicate: UISwitch!
    @IBOutlet weak var switchAuthMQTT: UISwitch!
    @IBOutlet weak var switchAuthHTTPS: UISwitch!
    
    @IBOutlet weak var txtURLHTTPS: CustomTextField!
    @IBOutlet weak var txtAuthTokenHTTPS: CustomTextField!
    @IBOutlet weak var txtURLMQTTT: CustomTextField!
    @IBOutlet weak var txtTopicMQTT: CustomTextField!
    @IBOutlet weak var txtUserNameMQTT: CustomTextField!
    @IBOutlet weak var txtPasswordMQTT: CustomTextField!
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var retrievedServerDetail = objUserDefaultUtils.serverDetail
    
    // ----------------------------------------------------------
    //             MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent // Use .darkContent for dark icons
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func onBtnBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onBtnSampleData(_ sender: UIButton) {
        let sampleDataVC = storyboard?.instantiateViewController(withIdentifier: "SampleDataVC") as! SampleDataVC
        navigationController?.pushViewController(sampleDataVC, animated: true)
    }
    
    @IBAction func onSwitchDuplicateData(_ sender: UISwitch) {
        retrievedServerDetail.isAllowDuplicateData = sender.isOn
        objUserDefaultUtils.serverDetail = retrievedServerDetail
    }
    
    @IBAction func onSwitchUpload(_ sender: UISwitch) {
        uploadSubViewIsHide(sender: sender)
        
        retrievedServerDetail.isUpload = sender.isOn
        objUserDefaultUtils.serverDetail = retrievedServerDetail
    }
    
    @IBAction func onBtnDuplicateInfo(_ sender: UIButton) {
        
        let infoVC = storyboard?.instantiateViewController(withIdentifier: "InfoVC") as! InfoVC
        infoVC.modalPresentationStyle = .overFullScreen
        infoVC.settingOption = .allowDuplicate
        present(infoVC, animated: true)
    }
    
    @IBAction func onBtnFrequencyInfo(_ sender: UIButton) {
        let infoVC = storyboard?.instantiateViewController(withIdentifier: "InfoVC") as! InfoVC
        infoVC.modalPresentationStyle = .overFullScreen
        infoVC.settingOption = .uploadFrequency
        present(infoVC, animated: true)
    }
    
    @IBAction func onBtnFrequencySecond(_ sender: UIButton) {
        
        let uploadFrequencyVC = storyboard?.instantiateViewController(withIdentifier: "UploadFrequencyVC") as! UploadFrequencyVC
        uploadFrequencyVC.modalPresentationStyle = .overFullScreen
       
        uploadFrequencyVC.uploadCallBack = { second in
            
            if second <= 4 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    UIApplication.topViewController()?.view.makeToast("Please enter a valid number")
                }
            }else {
                self.retrievedServerDetail.uploadFrequencySecond = second
                objUserDefaultUtils.serverDetail = self.retrievedServerDetail
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    UIApplication.topViewController()?.view.makeToast("Frequency saved: \(second) seconds")
                }
                self.btnSecond.setTitle("\(second) sec", for: .normal)
            }
        }
        present(uploadFrequencyVC, animated: true)
    }
    
    @IBAction func onBtnChooseSerever(_ sender: UIButton) {
        setServerScreen(tag: sender.tag)
    }
    
    @IBAction func onSwitchHTTPSAuth(_ sender: UISwitch) {
        httpsTokenView.isHidden = !sender.isOn
    }
    
    @IBAction func onSwitchMQTTAuth(_ sender: UISwitch) {
        userDetailMQTTView.isHidden = !sender.isOn
    }
    
    @IBAction func onBtnSaveHTTPS(_ sender: UIButton) {
        if isValidHTTPSTextfield() {
            
            retrievedServerDetail.server = .https
            retrievedServerDetail.urlMQTT = ""
            retrievedServerDetail.topic = ""
            retrievedServerDetail.isAuthMQTT = false
            retrievedServerDetail.userName = ""
            retrievedServerDetail.password = ""
            retrievedServerDetail.urlHTTPS = txtURLHTTPS.text ?? ""
            
            if switchAuthHTTPS.isOn {
                let token = txtAuthTokenHTTPS.text ?? ""
                retrievedServerDetail.token = token
                retrievedServerDetail.isAuthHTTPS = true
                
            }else {
                retrievedServerDetail.token = ""
                retrievedServerDetail.isAuthHTTPS = false
                
            }
            objUserDefaultUtils.serverDetail = self.retrievedServerDetail
            
            view.endEditing(true)
            UIApplication.topViewController()?.view.makeToast("Data Saved Succsessfully!")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func onBtnTestHTTPS(_ sender: UIButton) {
        if isValidHTTPSTextfield() {
            
        }
    }
    
    @IBAction func onBtnSaveMQTT(_ sender: UIButton) {
        if isValidMQTTTextfield() {
            retrievedServerDetail.server = .mqtt
            retrievedServerDetail.urlHTTPS = ""
            retrievedServerDetail.isAuthHTTPS = false
            retrievedServerDetail.urlMQTT = txtURLMQTTT.text ?? ""
            retrievedServerDetail.topic = txtTopicMQTT.text ?? ""
            
            if switchAuthMQTT.isOn {
                retrievedServerDetail.userName = txtUserNameMQTT.text ?? ""
                retrievedServerDetail.password = txtPasswordMQTT.text ?? ""
                retrievedServerDetail.isAuthMQTT = true
            }else {
                retrievedServerDetail.userName = ""
                retrievedServerDetail.password = ""
                retrievedServerDetail.isAuthMQTT = false
            }
            
            objUserDefaultUtils.serverDetail = self.retrievedServerDetail
            
            view.endEditing(true)
            UIApplication.topViewController()?.view.makeToast("Data Saved Succsessfully!")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func onBtnTestMQTT(_ sender: UIButton) {
        if isValidMQTTTextfield(){
            print("Validation successful. Proceeding with API call or next steps.")
        }
    }
    
    @IBAction func onBtnPasswordVisible(_ sender: UIButton) {
        sender.isSelected.toggle()
        txtPasswordMQTT.isSecureTextEntry = !sender.isSelected
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Functions -
    // ----------------------------------------------------------
    func setupUI(){
         self.switchUpload.isOn = retrievedServerDetail.isUpload
         self.switchDuplicate.isOn = retrievedServerDetail.isAllowDuplicateData
         self.btnSecond.setTitle("\(retrievedServerDetail.uploadFrequencySecond) sec", for: .normal)
        
        setServerScreen(tag: retrievedServerDetail.server == .https ? 0 : 1)
        uploadSubViewIsHide(sender: switchUpload)
    }
    
    func uploadSubViewIsHide(sender: UISwitch) {
        if sender.isOn {
            // Show the view with animation
            uploadSubView.isHidden = false
            uploadSubView.alpha = 0.0
            UIView.animate(withDuration: 0.5) {
                self.uploadSubView.alpha = 1.0
            }
        } else {
            // Hide the view with animation
            UIView.animate(withDuration: 0.5) {
                self.uploadSubView.alpha = 0.0
            } completion: { [weak self] _ in
                self?.uploadSubView.isHidden = true
            }
        }
    }
    
    func isValidHTTPSTextfield() -> Bool {
        let url = txtURLHTTPS.text ?? ""
        let token = txtAuthTokenHTTPS.text ?? ""
        
        if url.isBlank {
            UIApplication.topViewController()?.view.makeToast("Please enter Url", duration: 3.0, position: .center)
            return false
        } else if !url.isValidURLFormat() {
            UIApplication.topViewController()?.view.makeToast("Please enter a valid Url", duration: 3.0, position: .center)
            return false
        } else if switchAuthHTTPS.isOn, token.isBlank {
            UIApplication.topViewController()?.view.makeToast("Please enter auth token", duration: 3.0, position: .center)
            return false
        } else {
            return true
        }
    }
    
    func isValidMQTTTextfield() -> Bool {
        let url = txtURLMQTTT.text ?? ""
        let topic = txtTopicMQTT.text ?? ""
        let userName = txtUserNameMQTT.text ?? ""
        let password = txtPasswordMQTT.text ?? ""
        
        if url.isBlank {
            UIApplication.topViewController()?.view.makeToast("Please enter Url", duration: 3.0, position: .center)
            return false
        } else if !url.isValidURLFormat() {
            UIApplication.topViewController()?.view.makeToast("Please enter a valid Url", duration: 3.0, position: .center)
            return false
        } else if topic.isBlank {
            UIApplication.topViewController()?.view.makeToast("Please enter topic", duration: 3.0, position: .center)
            return false
        } else if switchAuthMQTT.isOn {
            if userName.isBlank {
                UIApplication.topViewController()?.view.makeToast("Please enter user name", duration: 3.0, position: .center)
                return false
            } else if password.isBlank {
                UIApplication.topViewController()?.view.makeToast("Please enter password", duration: 3.0, position: .center)
                return false
            }
        }
        return true
    }
    
    func setServerScreen(tag: Int){
        let isHttps = tag == 0
        
        imgHttps.image = UIImage(named: isHttps ? "ic_circle_fill" : "ic_circle")
        imgMqtt.image = UIImage(named: isHttps ? "ic_circle" : "ic_circle_fill")
        svHTTPS.isHidden = !isHttps
        svMQTT.isHidden = isHttps
        
        if isHttps {
            txtURLHTTPS.text = retrievedServerDetail.urlHTTPS
            txtAuthTokenHTTPS.text = retrievedServerDetail.token
            switchAuthHTTPS.isOn  = retrievedServerDetail.isAuthHTTPS
            httpsTokenView.isHidden = !retrievedServerDetail.isAuthHTTPS
        }else {
            txtURLMQTTT.text = retrievedServerDetail.urlMQTT
            txtTopicMQTT.text = retrievedServerDetail.topic
            switchAuthMQTT.isOn = retrievedServerDetail.isAuthMQTT
            txtUserNameMQTT.text = retrievedServerDetail.userName
            txtPasswordMQTT.text = retrievedServerDetail.password
            userDetailMQTTView.isHidden = !retrievedServerDetail.isAuthMQTT
        }
    }
}
