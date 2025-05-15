//
//  RowCell.swift
//  EvolutionTask
//
//  Created by mac on 04/07/24.
//

import UIKit

class RowCell: UITableViewCell {

   
 
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
}
