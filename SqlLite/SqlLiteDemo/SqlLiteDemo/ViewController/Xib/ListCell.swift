//
//  ListCell.swift
//  CoreDataDemo
//
//  Created by mac on 03/09/24.
//

import UIKit

class ListCell: UITableViewCell {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblNumber: UILabel!
    @IBOutlet var lblEmail: UILabel!
    
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnEdit: UIButton!
    
    // ----------------------------------------------------------
    //                       MARK: - awake Method -
    // ----------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func setData(obj: StudentModel){
        lblName.text = "Name: \(obj.name)"
        lblNumber.text = "Mobile No: \(obj.number)"
        lblEmail.text = "Email: \(obj.email)"
    }
}
