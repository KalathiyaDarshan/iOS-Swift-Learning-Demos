//
//  HeaderCell.swift
//  EvolutionTask
//
//  Created by mac on 04/07/24.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    @IBOutlet var lblHeaderName: UILabel!
    @IBOutlet var btnPlus: UIButton!
    @IBOutlet var btnExpand: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnAddAction(_ sender: UIButton) {
        
    }
}

