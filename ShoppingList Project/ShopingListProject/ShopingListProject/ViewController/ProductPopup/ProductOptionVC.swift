//
//  ProductPopupViewController.swift
//  ShopingListProject
//
//  Created by mac on 28/06/24.
//

import UIKit

class ProductOptionVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ---------------------------------------------------------
    @IBOutlet var btnEdit: UIButton!
    @IBOutlet var btnShare: UIButton!
    @IBOutlet var btnDelete: UIButton!
    
    @IBOutlet var lblProductHeader: UILabel!
    
    @IBOutlet var backView: UIView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var productListObj: ProductList?
    var shoppingListsObject: MainShopingList?
    var updateProductListDelegate: UpdateProductDelegate?
    var productEditDelegate: ProductEditModeDelegate?
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        lblProductHeader.text = "Product: \(productListObj?.productName ?? "")"
        buttonCornerRadi(button: btnEdit)
        buttonCornerRadi(button: btnShare)
        buttonCornerRadi(button: btnDelete)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        backView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func showAlert(completion: @escaping () -> Void) {
        
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .destructive) { (action) in
            // Handle the deletion here
            completion()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func formattedProduct() -> String {
        
        let formattedProducts =  productListObj.map { product in
            return "- [\(product.qty)] \(product.productName)\n \(product.notes)"
        }
        
        return "\(formattedProducts ?? "")"
    }
    
    func buttonCornerRadi(button: UIButton){
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
    }
    
    @objc func handleTap() {
        // Dismiss the view controller
        dismiss(animated: true, completion: nil)
        
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func editButtonAction(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        productEditDelegate?.eidtModePresentScreen(productListObj: productListObj)
    }
    
    @IBAction func shareButtonAction(_ sender: UIButton) {
        
        let formattedList = formattedProduct()
        let activityController = UIActivityViewController(activityItems: [formattedList], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        
        let arrMainList = UserLocalData.mainShopingList
        
        if let shoppingListsObject = shoppingListsObject {
            if let index = arrMainList.firstIndex(where: { $0.id == shoppingListsObject.id }) {
                if let productIndex = arrMainList[index].arrProduct.firstIndex(where: { $0.id == productListObj?.id }) {
                    
                    showAlert {
                        
                        UserLocalData.removeProduct(from: index, productIndex: productIndex)
                        self.updateProductListDelegate?.updateProductList(arrUpdatedObj: UserLocalData.mainShopingList[index])
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            } else {
                print("Item not found")
            }
        } else {
            print("shoppingListsObject is nil")
        }
    }
}

// Updated Object Send Privies View Controller
protocol UpdateProductDelegate: AnyObject{
    func updateProductList(arrUpdatedObj: MainShopingList)
}

// When close the edit screen
protocol ProductEditModeDelegate {
    func eidtModePresentScreen(productListObj: ProductList?)
}
