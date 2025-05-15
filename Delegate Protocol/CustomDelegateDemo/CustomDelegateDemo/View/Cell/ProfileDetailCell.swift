//
//  ProfileDetailCell.swift
//  CustomDelegateDemo
//
//  Created by Darshan Kalathiya on 28/03/25.
//

import UIKit

class ProfileDetailCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configCell(objContactProfile: ContactProfile) {
        imgProfile.image = objContactProfile.img
        lblName.text = objContactProfile.contactDetail.name
        lblNumber.text = objContactProfile.contactDetail.phoneNumber
    }
}
