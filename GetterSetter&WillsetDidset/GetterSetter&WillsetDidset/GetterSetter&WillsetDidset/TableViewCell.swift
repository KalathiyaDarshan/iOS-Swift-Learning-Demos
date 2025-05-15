//
//  TableViewCell.swift
//  GetterSetter&WillsetDidset
//
//  Created by mac on 13/06/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var lblNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
         }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

         }

}
