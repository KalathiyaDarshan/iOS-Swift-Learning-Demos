//
//  ViewController.swift
//  LogManager
//
//  Created by Darshan Kalathiya on 09/07/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtLog: UITextField!
    @IBOutlet weak var btnAddLog: UIButton!
    @IBOutlet weak var btnDeleteLogFile: UIButton!
    @IBOutlet weak var btnAddLine: UIButton!
    @IBOutlet weak var btnAddLineAfter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onBtnAddLog(_ sender: UIButton) {
        guard let log = txtLog.text else {
            return
        }
        
        addLog(log)
        
        print(LogManager.shared.getLogFilePath() ?? "")
        
        txtLog.text = ""
    }
    
    @IBAction func onBtnDeleteLogFile(_ sender: UIButton) {
        LogManager.shared.deleteLogFile()
    }
    
    @IBAction func onBtnAddLine(_ sender: UIButton) {
        guard let log = txtLog.text else {
            return
        }
        
        addLog(log,shouldShowLineAt: .before)
        txtLog.text = ""
    }
    
    @IBAction func onBtnAddLineAfter(_ sender: UIButton) {
        guard let log = txtLog.text else {
            return
        }
        
        addLog(log,shouldShowLineAt: .after)
        txtLog.text = ""
    }
    
    @IBAction func onBtnAddLineAfterBefore(_ sender: UIButton) {
        guard let log = txtLog.text else {
            return
        }
        
        addLog(log,shouldShowLineAt: .both)
        txtLog.text = ""
    }
}

