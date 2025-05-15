//
//  ViewController.swift
//  PickerView&DatePicker
//
//  Created by Darshan Kalathiya on 05/03/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtPickerView: UITextField!
    
    let pickerView = UIPickerView()
    let items = ["Apple", "Banana", "Cherry", "Date", "Mango"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        txtPickerView.inputView = pickerView
        
        // Add toolbar with Done button
        addToolbar()
    }
    
    // MARK: - Toolbar with Done Button
    
    func addToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([space, doneButton], animated: false)
        txtPickerView.inputAccessoryView = toolbar
    }
    
    @objc func donePressed() {
        txtPickerView.resignFirstResponder()
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Single column
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected item: \(items[row])")
        txtPickerView.text = items[row]
    }
}
