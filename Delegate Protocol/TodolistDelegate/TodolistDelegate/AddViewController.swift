//
//  AddViewController.swift
//  TodolistDelegate
//
//  Created by mac on 29/05/24.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet var txtAdd: UITextField!
    @IBOutlet var txtHours: UITextField!
    @IBOutlet var PVPriority: UIPickerView!
    
    var arrPriority = ["High","Medium","Low"]
    var txtDelegate: sendData?
    var selectedPriority: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PVPriority.dataSource = self
        PVPriority.delegate = self
        
    }
    
    
    @IBAction func AddAction(_ sender: UIButton) {
        
        let objtodoData = todoData(txthours: txtHours.text ?? "", txttask: txtAdd.text ?? "", txtPriority: selectedPriority ?? "")
        txtDelegate?.details(getTaskData: objtodoData)
        navigationController?.popViewController(animated: true)
        //dismiss(animated: true, completion: nil)
    }
}

protocol sendData {
    func details(getTaskData: todoData)
}

extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        3
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrPriority[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPriority = arrPriority[row]
    }
}

enum Priorityenum: String {
    
    case red = "High"
    case green = "Medium"
    case yellow = "Low"
}

class todoData {
    
    var hours: Int
    var task: String
    var priority: Priorityenum
    
    init(txthours: String,txttask: String,txtPriority: String) {
        
        self.hours = Int(txthours) ?? 0
        self.task = txttask
        self.priority = Priorityenum(rawValue: txtPriority) ?? .red
    }
}
