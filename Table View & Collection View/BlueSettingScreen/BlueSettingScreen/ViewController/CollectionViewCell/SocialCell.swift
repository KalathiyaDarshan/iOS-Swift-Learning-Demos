//
//  SocialCell.swift
//  BlueCollectionView
//
//  Created by Darshan Kalathiya on 18/12/24.
//

import UIKit

class SocialCell: UICollectionViewCell {
    
    @IBOutlet weak var socialImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(obj: SocialDetail){
        socialImage.image = UIImage(named: "ic_\(obj.icon)")
    }
}
