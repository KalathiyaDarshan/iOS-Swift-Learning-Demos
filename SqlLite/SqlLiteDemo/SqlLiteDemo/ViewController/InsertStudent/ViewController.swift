//
//  ViewController.swift
//  SqlLiteDemo
//
//  Created by mac on 05/09/24.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtNumber: UITextField!
    @IBOutlet var txtEmail: UITextField!
    
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
        resetTextField()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func resetTextField() {
        txtName.text = ""
        txtEmail.text = ""
        txtNumber.text = ""
        txtName.becomeFirstResponder()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        // Open the database
        SqlLiteManager.shared.openDatabase()
        
        SqlLiteManager.shared.createTable()
        
        // Insert a new student
        let student = StudentModel(id: 0,name: txtName.text ?? "", number: Int(txtNumber.text ?? "") ?? 0, email: txtEmail.text ?? "")
        
        SqlLiteManager.shared.insertRecord(obj: student)
        
        resetTextField()
    }
    
}

