//
//  ContactCell.swift
//  CustomDelegateDemo
//
//  Created by Darshan Kalathiya on 24/03/25.
//

import UIKit

class ContactCell: UITableViewCell {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var objContact: Contact?
    
    // ----------------------------------------------------------
    //                       MARK: - awake Method -
    // ----------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func onBtnSelectClick(_ sender: UIButton) {
        sender.isSelected.toggle()
        objContact?.isSelect = sender.isSelected
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func configCell(objContact: Contact) {
        lblName.text = objContact.name
        lblNumber.text = objContact.phoneNumber
        btnSelect.isSelected = objContact.isSelect
        
        self.objContact = objContact
    }
}
