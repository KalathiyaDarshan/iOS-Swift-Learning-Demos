//
//  ViewController.swift
//  UserDefaultDemo
//
//  Created by mac on 17/06/24.
//

import UIKit

class ViewController: UIViewController{
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var txtInteger: UITextField!
    @IBOutlet var txtBoolean: UITextField!
    @IBOutlet var txtString: UITextField!
    @IBOutlet var txtDictionary: UITextField!
    @IBOutlet var txtArray: UITextField!
    @IBOutlet var txtDouble: UITextField!
    
    @IBOutlet var lblInteger: UILabel!
    @IBOutlet var lblString: UILabel!
    @IBOutlet var lblArray: UILabel!
    @IBOutlet var lblDictionary: UILabel!
    @IBOutlet var lblIntArray: UILabel!
    @IBOutlet var lblDouble: UILabel!
    @IBOutlet var lblBoolean: UILabel!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    let pickerView = UIPickerView()
    let booleanValues = ["true", "false"]
    
    let userDefault = UserDefaults.standard
    
    var integerValue: Int {
        get {
            return userDefault.integer(forKey: "Integer")
        }
        set{
            return userDefault.set(newValue, forKey: "Integer")
        }
    }
    
    var stringValue: String {
        get {
            return userDefault.string(forKey: "String") ?? ""
        }
        set{
            return userDefault.set(newValue, forKey: "String")
        }
    }
    
    var arrStringValue: [String] {
        get {
            return userDefault.array(forKey: "StringArray") as? [String] ?? []
        }
        set{
            return userDefault.set(newValue, forKey: "StringArray")
        }
    }
    
    var arrIntegerValue: [Int] {
        get {
            return userDefault.array(forKey: "IntArray") as? [Int] ?? []
        }
        set{
            return userDefault.set(newValue, forKey: "IntArray")
        }
    }
    
    var dictionaryValue: [String: String] {
        get {
            return userDefault.dictionary(forKey: "Dictionary") as? [String: String] ?? [:]
        }
        set{
            return userDefault.set(newValue, forKey: "Dictionary")
        }
    }
    
    var doubleValue: Double {
        get {
            return userDefault.double(forKey: "Double")
        }
        set{
            return userDefault.set(newValue, forKey: "Double")
        }
    }
    
    var boolValue: Bool {
        get {
            return userDefault.bool(forKey: "Bool")
        }
        set{
            return userDefault.set(newValue, forKey: "Bool")
        }
    }
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the pickerView
        self.setupPickerView()
        
        lblInteger.text = "\(integerValue)"
        lblString.text = stringValue
        lblArray.text = "\(arrStringValue)"
        lblIntArray.text = "\(arrIntegerValue)"
        lblDictionary.text = "\(dictionaryValue)"
        lblDouble.text = "\(doubleValue)"
        lblBoolean.text = "\(boolValue)"
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    private func setupPickerView() {
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.frame.size = CGSize(width: 0, height: 300)
        txtBoolean.inputView = pickerView
        
        // Set up the toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: false)
        
        // Set the pickerView and toolbar as the inputView and inputAccessoryView for the text field
        txtBoolean.inputAccessoryView = toolbar
        txtBoolean.inputView = pickerView
    }
    
    func alert() {
        
        let alertController = UIAlertController(title: "Alert", message: "field not completed", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .destructive){ _ in
            print(alertController.textFields?.first?.text ?? "")
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @objc func doneButtonTapped() {
        // Dismiss the picker view
        txtBoolean.resignFirstResponder()
    }
    
    @IBAction func integerSaveAction(_ sender: UIButton) {
        
        if txtInteger.text != "" {
            integerValue = Int(txtInteger.text ?? "") ?? 0
            lblInteger.text = "\(integerValue)"
            txtInteger.text = ""
        } else {
            alert()
        }
    }
    
    @IBAction func stringSaveAction(_ sender: UIButton) {
        
        if txtString.text != "" {
            stringValue = txtString.text ?? ""
            lblString.text = stringValue
            txtString.text = ""
        } else {
            alert()
        }
    }
    
    @IBAction func arraySaveAction(_ sender: UIButton) {
        
        if txtArray.text != "" {
            
            let inputString = txtArray.text ?? ""
            let stringArray = inputString.split(separator: ",")
            
            var arrString: [String] = []
            var arrInt: [Int] = []
            
            // Iterate through components and determine type
            for component in stringArray {
                if let intValue = Int(component) {
                    arrInt.append(intValue)
                } else {
                    arrString.append(String(component))
                }
            }
            
            // Update the computed properties
            arrStringValue = arrString
            arrIntegerValue = arrInt
            lblArray.text = "\(arrStringValue)"
            lblIntArray.text = "\(arrIntegerValue)"
            txtArray.text = ""
            
        } else {
            alert()
        }
    }
    
    @IBAction func dictionarySaveAction(_ sender: UIButton) {
        
        if txtDictionary.text != "" {
            let inputString = txtDictionary.text ?? ""
            let dictionary = ["Name": inputString]
            dictionaryValue = dictionary
            lblDictionary.text = "\(dictionaryValue)"
            txtDictionary.text = ""
        } else {
            alert()
        }
    }
    
    @IBAction func doubleSaveAction(_ sender: UIButton) {
        
        if txtDouble.text != "" {
            doubleValue = Double(txtDouble.text ?? "") ?? 0.0
            lblDouble.text = "\(doubleValue)"
            txtDouble.text = ""
        } else {
            alert()
        }
    }
    
    @IBAction func Boolean(_ sender: UIButton) {
        
        if txtBoolean.text != "" {
            boolValue = Bool(txtBoolean.text ?? "") ?? false
            lblBoolean.text = "\(boolValue)"
            txtBoolean.text = ""
        } else {
            alert()
        }
    }
}

// ----------------------------------------------------------
//                       MARK: - UITableView DataSource,Delegate -
// ----------------------------------------------------------
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return booleanValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return booleanValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtBoolean.text = booleanValues[row]
    }
}
