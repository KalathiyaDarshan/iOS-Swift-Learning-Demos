//
//  TableViewCell.swift
//  ExpandableTableview
//
//  Created by mac on 13/06/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var lblData: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

         }
    
}
