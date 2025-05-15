//
//  EditVC.swift
//  CoreDataDemo
//
//  Created by mac on 04/09/24.
//

import UIKit

class EditVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtRollNo: UITextField!
    @IBOutlet var txtStream: UITextField!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var objStudent: StudentDetails?
    let coreData = CoreDataManager.shared
    var updateDelegate: updateDetailsDelegate?
    
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
    func resetTextField(){
        txtName.text = objStudent?.name ?? ""
        txtStream.text = objStudent?.stream ?? ""
        txtRollNo.text = "\(objStudent?.rollNo ?? 0)"
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func btnUpdateAction(_ sender: UIButton) {
        let updatedObj = StudentDetails.init(id: objStudent?.id ?? UUID(), name: txtName.text ?? "", stream: txtStream.text ?? "", rollNo: Int(txtRollNo.text ?? "") ?? 0)
        
        coreData.updateStudent(obj: updatedObj) { success in
            if success {
                self.updateDelegate?.update()
                self.navigationController?.popViewController(animated: true)
            } else {
                print("Failed to delete student")
            }
        }
    }
}

protocol  updateDetailsDelegate {
    func update()
}
