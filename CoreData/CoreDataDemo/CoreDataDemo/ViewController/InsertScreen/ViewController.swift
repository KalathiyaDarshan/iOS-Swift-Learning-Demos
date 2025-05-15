//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by mac on 03/09/24.
//

import UIKit

class ViewController: UIViewController {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtRollNo: UITextField!
    @IBOutlet var txtStream: UITextField!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    let coreData = CoreDataManager.shared
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func resetTextField(){
        txtName.text = ""
        txtStream.text = ""
        txtRollNo.text = ""
        txtName.becomeFirstResponder()
    }
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        let objStudent = StudentDetails.init(id: UUID(), name: txtName.text ?? "", stream: txtStream.text ?? "", rollNo: Int(txtRollNo.text ?? "") ?? 0)
        
        coreData.SaveData(obj: objStudent)
        resetTextField()
        showAlert(message: "Record has been saved successfully")
    }
}

