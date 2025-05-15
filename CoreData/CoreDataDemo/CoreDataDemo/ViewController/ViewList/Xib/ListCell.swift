//
//  ListCell.swift
//  CoreDataDemo
//
//  Created by mac on 03/09/24.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet var lblRollNO: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblStream: UILabel!
    
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnEdit: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(obj: StudentDetails){
        lblRollNO.text = "Roll No: \(obj.rollNo)"
        lblName.text = "Name: \(obj.name)"
        lblStream.text = "Stream: \(obj.stream)"
    }
}
