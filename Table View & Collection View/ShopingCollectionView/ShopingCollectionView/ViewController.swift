//
//  ViewController.swift
//  ShopingCollectionView
//
//  Created by mac on 06/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var clvHorizontal: UICollectionView!
    @IBOutlet var clvVertical: UICollectionView!
    
    var arrProduct = [Product]()
    var arrBrand = [Brand]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let horizontalCellNib = UINib(nibName: "HorizontalCell", bundle: nil)
        clvHorizontal.register(horizontalCellNib, forCellWithReuseIdentifier: "HorizontalCell")
        
        let verticalCellNib = UINib(nibName: "VerticalCell", bundle: nil)
        clvVertical.register(verticalCellNib, forCellWithReuseIdentifier: "VerticalCell")
        
        let product1 = Product.init(name: "Apple iPhone 15 Pro Max", price: 199900, detail: "FORGED IN TITANIUM iPhone 15 Pro Max has a strong and light aerospace-grade titanium design with a textured matte-glass back.", productImage: "Iphone15Promax")
        let product2 = Product.init(name: "Apple iPhone 13 ", price: 48799, detail: "Cinematic mode adds shallow depth of field and shifts focus automatically in your videos", productImage: "Iphone13")
        let product3 = Product.init(name: "Vivo X Fold3 Pro 5G", price: 159999, detail: "vivo X Fold3 Pro 5G (Celestial Black, 16GB RAM, 512GB Storage) with No Cost EMI/Additional Exchange Offers", productImage: "vivoFold3")
        let product4 = Product.init(name: "Samsung Galaxy Z Fold5 5G", price: 154999, detail: "Samsung Galaxy Z Fold5 5G AI Smartphone (Beige, 12GB RAM, 256GB Storage)", productImage: "samsungFold")
        let product5 = Product.init(name: "Samsung Galaxy Z Flip5 5G", price: 199900, detail: "Samsung Galaxy Z Flip5 5G AI Smartphone (Cream, 8GB RAM, 256GB Storage)", productImage: "samsungFlip")
        arrProduct = [product1,product2,product3,product4,product5]
        
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

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clvHorizontal{
            return arrBrand.count
        }
        else{
            return arrBrand[section].product.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == clvHorizontal{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCell", for: indexPath) as! HorizontalCell
            cell.productImage.image = UIImage(named: "\(arrBrand[indexPath.row].images)")
            return cell
        }
        else if collectionView == clvVertical {
            
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalCell", for: indexPath) as! VerticalCell
            cell1.lblDetail.text = arrBrand[indexPath.section].product[indexPath.row].detail
            cell1.lblPrice.text = "\(arrBrand[indexPath.section].product[indexPath.row].price)"
            cell1.lblModelName.text = arrBrand[indexPath.section].product[indexPath.row].name
            cell1.imgProduct.image = UIImage(named: "\(arrBrand[indexPath.section].product[indexPath.row].productImage)")
            return cell1
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == clvHorizontal {
            let size = (collectionView.frame.size.width)/4
            return CGSize(width: size, height: collectionView.frame.size.height)
        }
        else{
            let size = (collectionView.frame.size.height)/2.4
            return CGSize(width: collectionView.frame.size.width, height: size)
        }
    }
}
