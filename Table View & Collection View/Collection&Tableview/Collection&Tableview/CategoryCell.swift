//
//  CategoryCell.swift
//  Collection&Tableview
//
//  Created by mac on 07/06/24.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet var viewImage: UIView!
    @IBOutlet var imageCategory: UIImageView!
    @IBOutlet var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        translatesAutoresizingMaskIntoConstraints = false
    }

}
