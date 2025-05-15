//
//  ViewController.swift
//  Collection&Tableview
//
//  Created by mac on 07/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var cvCategory: UICollectionView!
    @IBOutlet var cvSubCategory: UICollectionView!
    
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var arrCategory = [Category]()
    
    var selectedObject: Category?
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let horizontalCellNib = UINib(nibName: "CategoryCell", bundle: nil)
        cvCategory.register(horizontalCellNib, forCellWithReuseIdentifier: "CategoryCell")
        cvSubCategory.register(horizontalCellNib, forCellWithReuseIdentifier: "CategoryCell")
        
        //Grocery
        let objGrocery1 = Products.init(name: "Rice & Rice Product", image: "Rice")
        let objGrocery2 = Products.init(name: "Ghee & Oils", image: "Ghee")
        let objGrocery3 = Products.init(name: "Atta & Flours", image: "Atta")
        let objGrocery4 = Products.init(name: "Masalas & Spices", image: "Masala")
        let objGrocery5 = Products.init(name: "Dals & Pulses", image: "Dal")
        let objGrocery6 = Products.init(name: "Sugar", image: "Sugar")
        let objGrocery7 = Products.init(name: "Rice & Rice Product", image: "Rice")
        let objGrocery8 = Products.init(name: "Ghee & Oils", image: "Ghee")
        let objGrocery9 = Products.init(name: "Atta & Flours", image: "Atta")
        
        let arrGrocery1 =  [objGrocery1,objGrocery2,objGrocery3,objGrocery4,objGrocery5,objGrocery6]
        let arrGrocery2 = [objGrocery7,objGrocery8,objGrocery9]
        
        //Fashion
        let objFashion1 = Products.init(name: "Jeans", image: "Jeans")
        let objFashion2 = Products.init(name: "Formal Wear", image: "Formal")
        let objFashion3 = Products.init(name: "Spoyl Fashion", image: "Spoyl")
        let objFashion4 = Products.init(name: "Ethnic Wear", image: "Ethnic")
        
        let arrFashion = [objFashion1,objFashion2,objFashion3,objFashion4]
        
        //Appliances
        let objAppliances1 = Products.init(name: "AC", image: "Ac")
        let objAppliances2 = Products.init(name: "Refrigerators", image: "Refrigeretor")
        let objAppliances3 = Products.init(name: "Televison", image: "Tv")
        let objAppliances4 = Products.init(name: "Washing Machines", image: "WashingMachine")
        
        let arrAppliances = [objAppliances1,objAppliances2,objAppliances3,objAppliances4]
        
        //Mobile
        let objMobile1 = Products.init(name: "Iphone", image: "Iphone")
        let objMobile2 = Products.init(name: "Poco", image: "Poco")
        let objMobile3 = Products.init(name: "Moto", image: "Moto")
        let objMobile4 = Products.init(name: "Samsung", image: "Samsung")
        
        let arrMobile = [objMobile1,objMobile2,objMobile3,objMobile4]
        
        
        //Electronics
        let objElectronics1 = Products.init(name: "Laptop", image: "Laptop")
        let objElectronics2 = Products.init(name: "SmartWatches", image: "Watches")
        let objElectronics3 = Products.init(name: "Tablets", image: "Tablets")
        let objElectronics4 = Products.init(name: "Camera", image: "Camera")
        
        let arrElectronics = [objElectronics1,objElectronics2,objElectronics3,objElectronics4]
        
        // Sub Category
        
        let objSubCategoryGrocery1 = SubCategory.init(subName: "Staples", product: arrGrocery1)
        let objSubCategoryGrocery2 = SubCategory.init(subName: "Snacks", product: arrGrocery2)
        let arrSubCategory1 = [objSubCategoryGrocery1,objSubCategoryGrocery2]
        
        let objSubCategory2 = SubCategory.init(subName: "Men's Clothing", product: arrFashion)
        let  arrSubCategory2 = [objSubCategory2]
        
        let objSubCategory3 = SubCategory.init(subName: "Air Conditions", product: arrAppliances)
        let  arrSubCategory3 = [objSubCategory3]
        
        let objSubCategory4 = SubCategory.init(subName: "Brand", product: arrMobile)
        let  arrSubCategory4 = [objSubCategory4]
        
        let objSubCategory5 = SubCategory.init(subName: "Laptop", product: arrElectronics)
        let  arrSubCategory5 = [objSubCategory5]
        
        
        // Main Category
        let objCategory1 = Category.init(image: "Grocery", name: "Grocery",subCategory: arrSubCategory1)
        let objCategory2 = Category.init(image: "Fashion", name: "Fashion",subCategory: arrSubCategory2)
        let objCategory3 = Category.init(image: "Appliances", name: "Appliances",subCategory: arrSubCategory3)
        let objCategory4 = Category.init(image: "Mobile", name: "Mobile",subCategory: arrSubCategory4)
        let objCategory5 = Category.init(image: "Electronics", name: "Electronics",subCategory: arrSubCategory5)
        
        arrCategory = [objCategory1,objCategory2,objCategory3,objCategory4,objCategory5]
        
        //Temp Object
        selectedObject = arrCategory[0]
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    // Section Count
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == cvSubCategory{
            return selectedObject?.subCategoryArr.count ?? 0
        }
        return 1
    }
    
    // Number Of Item In Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvCategory{
            return arrCategory.count
        }
        else if collectionView == cvSubCategory{
            return selectedObject?.subCategoryArr[section].product.count ?? 0
        }
        return 1
    }
    
    //Section Title
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderReusableView", for: indexPath) as? HeaderReusableView{
            sectionHeader.lblheader.text =  selectedObject?.subCategoryArr[indexPath.section].subName ?? ""
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    //Select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == cvCategory{
            
            print("selected index:",indexPath.row)
            selectedObject =  arrCategory[indexPath.row]
            cvSubCategory.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == cvCategory{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.imageCategory.image = UIImage(named: "\(arrCategory[indexPath.row].image)")
            cell.lblName.text = arrCategory[indexPath.row].name
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.imageCategory.image = UIImage(named: "\(selectedObject?.subCategoryArr[indexPath.section].product[indexPath.row].image ?? "")")
            cell.lblName.text = selectedObject?.subCategoryArr[indexPath.section].product[indexPath.row].productName
            cell.lblName.numberOfLines = 0
            cell.lblName.textAlignment = .left
            cell.lblName.sizeToFit()
            cell.lblName.lineBreakMode = .byWordWrapping
            cell.lblName.contentMode = .topLeft
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == cvCategory{
            let size = (collectionView.frame.size.height)/6
            return CGSize(width: collectionView.frame.size.width, height: size)
        }
        else{
            let height = (collectionView.frame.size.height)/5
            let width = (collectionView.frame.size.width)/3
            return CGSize(width: width, height: height)
        }
    }
}
