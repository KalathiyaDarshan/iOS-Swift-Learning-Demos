//
//  APIResponseCell.swift
//  APIDemo
//
//  Created by mac on 24/07/24.
//

import UIKit

class APIResponseCell: UITableViewCell {
     
    @IBOutlet var lblId: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblEmail: UILabel!
    @IBOutlet var lblNotes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(obj: User) {
        
        self.lblId.text = "id: \(obj.id)"
        self.lblName.text = "Name: " + obj.name
        self.lblEmail.text = "Email: " + obj.email
        self.lblNotes.text = "Notes: " + obj.body
    }
    
    func setupCellUsingSwiftyJson(obj: UserData) {
        
        self.lblId.text = "id: \(obj.id)"
        self.lblName.text = "Name: " + obj.name
        self.lblEmail.text = "Email: " + obj.email
        self.lblNotes.text = "Notes: " + obj.body
    }
    
    func setupCellUsingObjectMapper(obj: UserDetails) {
        
        self.lblId.text = "id: \(String(describing: obj.id))"
        self.lblName.text = "Name: \(obj.name ?? "")"
        self.lblEmail.text = "Email: \(obj.email ?? "")"
        self.lblNotes.text = "Notes: \(obj.body ?? "")"
    }
    
}
