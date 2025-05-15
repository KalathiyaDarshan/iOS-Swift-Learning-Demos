//
//  LabelCell.swift
//  ShopingCollectionView
//
//  Created by mac on 07/06/24.
//

import UIKit

class LabelCell: UICollectionViewCell {

    @IBOutlet var lblDetail: UILabel!
    @IBOutlet var subView: UIView!
    @IBOutlet var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        subView.layer.cornerRadius = 7
        subView.layer.borderWidth = 1
        lblDetail.sizeToFit()
    }

}
