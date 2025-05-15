//
//  ShopingListOptionVC.swift
//  ShopingListProject
//
//  Created by mac on 27/06/24.
//

import UIKit

class ShopingListOptionVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var btnEdit: UIButton!
    @IBOutlet var btnShare: UIButton!
    @IBOutlet var btnDuplicate: UIButton!
    @IBOutlet var btnReset: UIButton!
    @IBOutlet var btnDelete: UIButton!
    
    @IBOutlet var lblHeader: UILabel!
    
    @IBOutlet var backView: UIView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var shoppingListsObject: MainShopingList?
    weak var popupDelegate: EditPopupVCDelegate?
    var editDelegate: EditeModeDelegate?
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        buttonCornerRadi(button: btnEdit)
        buttonCornerRadi(button: btnShare)
        buttonCornerRadi(button: btnDuplicate)
        buttonCornerRadi(button: btnReset)
        buttonCornerRadi(button: btnDelete)
        lblHeader.text = "List: \(shoppingListsObject?.nameSL ?? "")"
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        backView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    @objc func handleTap() {
        // Dismiss the view controller
        dismiss(animated: true, completion: nil)
    }
    
    func buttonCornerRadi(button: UIButton) {
        
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
    }
    
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
    
    func updatProductObject(updatedObj : [MainShopingList]){
        popupDelegate?.didDismissPresentedViewController(arrUpdatedObj : updatedObj)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func btnEditAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        editDelegate?.eidtModePresentScreen(mainShopingObj: shoppingListsObject)
    }
    
    @IBAction func btnShareAction(_ sender: UIButton) {
        
        if let shoppingList = shoppingListsObject {
            let formattedList = shoppingList.formattedProductList()
            
            let activityController = UIActivityViewController(activityItems: [formattedList], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnDuplicateAction(_ sender: UIButton) {
        
        var arrMainList = UserLocalData.mainShopingList
        
        for (index,list) in arrMainList.enumerated() {
            if list.id == shoppingListsObject?.id {
                
                let duplicatedList = MainShopingList(
                    id: list.id + "New", // Generate a new unique ID for the duplicated list
                    nameSL: list.nameSL + " (New)",
                    priority: list.priority,
                    notes: list.notes,
                    arrProuduct: list.arrProduct, // Copy the product list
                    isExpand: list.isExpand,
                    totalProductPrice: list.totalProductPrice,
                    sortOrder: list.sortOrder,
                    sortBy: list.sortBy
                )
                arrMainList.insert(duplicatedList,at: index+1)
            }
        }
        UserLocalData.saveArrayToUserDefault(arrData: arrMainList)
        updatProductObject(updatedObj: UserLocalData.mainShopingList)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnResetAction(_ sender: UIButton) {
        
        let arrMainList = UserLocalData.mainShopingList
        
        for List in arrMainList {
            if List.id == shoppingListsObject?.id
            {
                for product in List.arrProduct {
                    product.chackMark = false
                }
                updatProductObject(updatedObj: UserLocalData.mainShopingList)
            }
        }
        
        UserLocalData.saveArrayToUserDefault(arrData: arrMainList)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton) {
        
        let arrMainList = UserLocalData.mainShopingList
        
        if let shoppingListsObject = shoppingListsObject {
            if let index = arrMainList.firstIndex(where: { $0.id == shoppingListsObject.id }) {
                showAlert {
                    UserLocalData.removeMainShopingList(at: index)
                    // Dismiss the view controller
                    self.updatProductObject(updatedObj: UserLocalData.mainShopingList)
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                print("Item not found")
            }
        } else {
            print("shoppingListsObject is nil")
        }
    }
    
}

// Share Format
extension MainShopingList {
    
    func formattedProductList() -> String {
        let formattedProducts = arrProduct.map { product in
            return "- [ \(product.qty) ] \(product.productName)\n"
        }.joined(separator: "\n")
        
        return "\(nameSL)\n\(formattedProducts)"
    }
}

// Edit Complate
protocol EditPopupVCDelegate: AnyObject {
    func didDismissPresentedViewController(arrUpdatedObj : [MainShopingList])
}

protocol EditeModeDelegate {
    func eidtModePresentScreen(mainShopingObj: MainShopingList?)
}
