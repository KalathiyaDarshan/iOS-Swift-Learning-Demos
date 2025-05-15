//
//  SecondVerticalCell.swift
//  ShopingCollectionView
//
//  Created by mac on 06/06/24.
//

import UIKit

class SecondVerticalCell: UICollectionViewCell {

    @IBOutlet var lblModel: UILabel!
    @IBOutlet var clvSub: UICollectionView!
    var arrBrand = [Brand]()
    var arrProduct = [Product]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clvSub.delegate = self
        clvSub.dataSource = self
        
        let horizontalCellNib = UINib(nibName: "HorizontalCell", bundle: nil)
        clvSub.register(horizontalCellNib, forCellWithReuseIdentifier: "HorizontalCell")
        
        let brand1 = Brand.init(image: "IPhone", products: arrProduct)
        let brand2 = Brand.init(image: "Nokia", products: arrProduct)
        let brand3 = Brand.init(image: "Google", products: arrProduct)
        let brand4 = Brand.init(image: "Oppo", products: arrProduct)
        let brand5 = Brand.init(image: "Samsung", products: arrProduct)
        let brand6 = Brand.init(image: "Sony", products: arrProduct)
        let brand7 = Brand.init(image: "Vivo", products: arrProduct)
        let brand8 = Brand.init(image: "Xiaomi", products: arrProduct)
        arrBrand = [brand1,brand2,brand3,brand4,brand5,brand6,brand7,brand8]
    }

}

extension SecondVerticalCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrBrand.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCell", for: indexPath) as! HorizontalCell
        cell.productImage.image = UIImage(named: "\(arrBrand[indexPath.row].images)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            let size = (collectionView.frame.size.width)/4
            return CGSize(width: size, height: collectionView.frame.size.height)
    }
    
}
