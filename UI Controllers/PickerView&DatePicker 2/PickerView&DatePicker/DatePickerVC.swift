//
//  DatePickerVC.swift
//  PickerView&DatePicker
//
//  Created by Darshan Kalathiya on 05/03/25.
//

import UIKit

class DatePickerVC: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
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
    }
}
