//
//  ImageCell.swift
//  APICollectionDemo
//
//  Created by mac on 25/07/24.
//

import UIKit
import SDWebImage

class ImageCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCellData(obj: Image) {
        let url = URL(string: obj.url)
       // imageView.sd_setImage(with: url, completed: nil)
        let placeholderImage = UIImage(named: "Placeholder-Image")
        imageView.sd_setImage(with: url, placeholderImage: placeholderImage, options: .retryFailed, completed: nil)
    }
}
