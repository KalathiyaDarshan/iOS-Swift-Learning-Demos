//
//  SecondViewController.swift
//  ShopingCollectionView
//
//  Created by mac on 06/06/24.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet var clvHorizontal: UICollectionView!
    @IBOutlet var clvVertical: UICollectionView!
    
    var arrProduct = [Product]()
    var arrBrand = [Brand]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let horizontalCellNib = UINib(nibName: "HorizontalCell", bundle: nil)
        clvHorizontal.register(horizontalCellNib, forCellWithReuseIdentifier: "HorizontalCell")
        
        let verticalCellNib = UINib(nibName: "SecondVerticalCell", bundle: nil)
        clvVertical.register(verticalCellNib, forCellWithReuseIdentifier: "SecondVerticalCell")
        
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

extension SecondViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clvHorizontal{
            return arrBrand.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == clvHorizontal{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCell", for: indexPath) as! HorizontalCell
            cell.productImage.image = UIImage(named: "\(arrBrand[indexPath.row].images)")
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondVerticalCell", for: indexPath) as! SecondVerticalCell
        cell.lblModel.text = "Model"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == clvHorizontal {
            let size = (collectionView.frame.size.width)/4
            return CGSize(width: size, height: collectionView.frame.size.height)
        }
        else {
            let size = (collectionView.frame.size.height)/4
            return CGSize(width: collectionView.frame.size.width, height: size)
        }
    }
}
