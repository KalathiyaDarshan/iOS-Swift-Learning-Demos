//
//  CustomCell.swift
//  xibAddView
//
//  Created by Apple on 23/10/24.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(obj: Demo){
        
        // Clear all views except the first one
        stackView.arrangedSubviews.dropFirst().forEach { $0.removeFromSuperview() }
        
        lblTitle.text = obj.title
            
        // Loop through the data and add views to the stack view
        for item in obj.discription {
            let customView = CusomViewWrapper() // Or whatever custom view you're using
            
            // Access the contentView and set the label name for the custom view
            customView.contentView.lblName.text = item.discription
            
            // Add the custom view to the stack view
            stackView.addArrangedSubview(customView)
        }
    }
}
