//
//  ViewController.swift
//  TableView
//
//  Created by mac on 04/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var txtNumber: UITextField!
    @IBOutlet var txtSection: UITextField!
    
    var arrColor = [UIColor]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        txtNumber.text = ""
        txtSection.text = ""
    }
    
    @IBAction func actionNext(_ sender: UIButton) {
        
        let totalRow = Int(txtNumber.text ?? "") ?? 0
        let totalSection = Int(txtSection.text ?? "") ?? 0
        
        var arrColorsArr = [[UIColor]]()
        
        for _ in 0...totalSection {
            var rowArray = [UIColor]()
            for _ in 0..<totalRow {
                rowArray.append(.random()) // Adjust the range as needed
            }
            arrColorsArr.append(rowArray)
        }
        
        let nextVc = storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        
        let objTable = TableDetails.init(selection: Int(txtSection.text ?? "") ?? 0, rows: Int(txtNumber.text ?? "") ?? 0, color: arrColorsArr)
        nextVc.objTableCell = objTable
        navigationController?.pushViewController(nextVc, animated: true)
    }
    
}

class TableDetails {
    var section: Int
    var rows: Int
    var color: [[UIColor]]
    
    init(selection: Int,rows: Int, color: [[UIColor]]) {
        self.section = selection
        self.rows = rows
        self.color = color
    }
}

extension UIColor {
    
    static func random() -> UIColor {
        return UIColor(
            red:   .random(in: 0...1),
            green: .random(in: 0...1),
            blue:  .random(in: 0...1),
            alpha: 1.0
        )
    }
}
