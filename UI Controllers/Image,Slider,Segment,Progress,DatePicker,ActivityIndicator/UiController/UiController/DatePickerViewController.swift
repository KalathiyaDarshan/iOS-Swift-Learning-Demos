//
//  DatePickerViewController.swift
//  UiController
//
//  Created by mac on 27/05/24.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet var DatePicker: UIDatePicker!
    
    @IBOutlet var lblDate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DatePicker.preferredDatePickerStyle = .wheels  //.compact//.inline
       DatePicker.date = Date()
        DatePicker.locale = .current
        DatePicker.datePickerMode = .date //.dateAndTime //.time//.countDownTimer
        DatePicker.maximumDate = Date()
         }

    @IBAction func DateChanged(_ sender: Any) {
     let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "dd-mm-yy"
       // dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
         let date = dateFormatter.string(from: DatePicker.date)
       lblDate.text = date
        print(date)
        /*  dateFormatter.dateStyle = .none = blank
         .short = 5/25/24
         .medium = May 26, 2024
         .long = May 24, 2024 00 AM GMT+5:30
         .full = Thursday, May 23, 2024 India Standard Time
      */
    }
}
