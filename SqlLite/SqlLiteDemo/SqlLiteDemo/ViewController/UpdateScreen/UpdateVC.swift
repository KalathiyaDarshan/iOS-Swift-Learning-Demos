//
//  UpdateVC.swift
//  SqlLiteDemo
//
//  Created by mac on 05/09/24.
//

import UIKit

class UpdateVC: UIViewController {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtNumber: UITextField!
    @IBOutlet var txtEmail: UITextField!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var objStudent: StudentModel?
    var updateDelegate: updateDetailsDelegate?
    var sqlManager =  SqlLiteManager.shared
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetTextField()
    
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func resetTextField() {
        txtName.text = objStudent?.name ?? ""
        txtEmail.text = objStudent?.email ?? ""
        txtNumber.text = "\(objStudent?.number ?? 0)"
        txtName.becomeFirstResponder()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        let student = StudentModel(id: objStudent?.id ?? 0 ,name: txtName.text ?? "", number: Int(txtNumber.text ?? "") ?? 0, email: txtEmail.text ?? "")
        
        sqlManager.update(obj: student)
        self.updateDelegate?.update()
        
        navigationController?.popViewController(animated: true)
    }
    
}

protocol  updateDetailsDelegate {
    func update()
}
