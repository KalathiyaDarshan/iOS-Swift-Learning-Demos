//
//  DatePickerVC.swift
//  PickerView&DatePicker
//
//  Created by Darshan Kalathiya on 05/03/25.
//

import UIKit

class DatePickerVC: UIViewController , UITextFieldDelegate{
    
    let datePicker = UIDatePicker()
    @IBOutlet weak var txtDate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the date picker mode
        // datePicker.datePickerMode = .dateAndTime
        // datePicker.datePickerMode = ..countDownTimer
        // datePicker.datePickerMode = .time
        datePicker.datePickerMode = .date
        
        // Force the date picker to use wheel style
        if #available(iOS 13.4, *) {
            // datePicker.preferredDatePickerStyle =  .automatic
            // datePicker.preferredDatePickerStyle =  .inline
            // datePicker.preferredDatePickerStyle =  .compact
            datePicker.preferredDatePickerStyle =  .wheels
        }
        txtDate.delegate = self
        txtDate.inputView = datePicker
        
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
        txtDate.inputAccessoryView = toolbar
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtDate.text = formatter.string(from: datePicker.date)
        txtDate.resignFirstResponder()
    }
}
