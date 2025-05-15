//
//  ProductCell.swift
//  ShopingListProject
//
//  Created by mac on 20/06/24.
//

import UIKit

class ProductCell: UITableViewCell {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblQty: UILabel!
    @IBOutlet var lblTotalPrice: UILabel!
    @IBOutlet var lblNotes: UILabel!
    @IBOutlet var lblCategory: UILabel!
    @IBOutlet var lblStore: UILabel!
    
    @IBOutlet var viewStore: UIView!
    @IBOutlet var viewSecond: UIView!
    @IBOutlet var viewNotes: UIView!
    @IBOutlet var viewCategory: UIView!
    @IBOutlet var viewMain: UIView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var arrProductList = UserLocalData.productShopingList
    
    // ----------------------------------------------------------
    //                       MARK: - awake Method -
    // ----------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       setViewRadius()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setViewRadius() {
        
        self.viewMain.layer.shadowColor = UIColor.gray.cgColor
        self.viewMain.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.viewMain.layer.shadowOpacity = 0.5
        self.viewMain.layer.shadowRadius = 1
        self.viewMain.layer.masksToBounds = false
    }
    
    func SetProductCellData(product: ProductList?) {
        
        let notes = product?.notes ?? ""
        let store = product?.store ?? ""
        let category = product?.category ?? ""
        let totalPrice = product?.productTotalPrice ?? 0
        
        self.lblPrice.text = "Price: \((product?.price ?? 0))"
        self.lblQty.text = "Ouantity: \(product?.qty ?? 0)"
        self.lblTotalPrice.text = "Total Price: \(totalPrice)"
        self.lblNotes.text = "Notes: \(notes)"
        self.lblStore.text = "Store: \(store)"
        self.lblCategory.text = "Category: \(category)"
        
        if !notes.isEmpty || !store.isEmpty || !category.isEmpty {
            viewSecond.isHidden = false
            
            if !notes.isEmpty{
                viewNotes.isHidden = false
            }
            if !store.isEmpty{
                viewStore.isHidden = false
            }
            if !category.isEmpty{
                viewCategory.isHidden = false
            }
        }
        else{
            viewSecond.isHidden = true
        }
    }
}
