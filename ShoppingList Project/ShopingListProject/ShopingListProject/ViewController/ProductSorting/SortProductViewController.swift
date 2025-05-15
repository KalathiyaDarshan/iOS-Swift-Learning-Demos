//
//  SortProductViewController.swift
//  ShopingListProject
//
//  Created by mac on 10/07/24.
//

import UIKit

class SortProductViewController: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var imgDescending: UIImageView!
    @IBOutlet var imgAscending: UIImageView!
    @IBOutlet var imgStore: UIImageView!
    @IBOutlet var imgPrice: UIImageView!
    @IBOutlet var imgCategory: UIImageView!
    @IBOutlet var imgQuantity: UIImageView!
    @IBOutlet var imgName: UIImageView!
    
    @IBOutlet var backView: UIView!
    @IBOutlet var btnAscending: UIButton!
    @IBOutlet var btnDescending: UIButton!
    @IBOutlet var btnCategory: UIButton!
    @IBOutlet var btnPrice: UIButton!
    @IBOutlet var btnQty: UIButton!
    @IBOutlet var btnStore: UIButton!
    @IBOutlet var btnName: UIButton!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var selectedOrder: SortingOrder?
    var selectedCategory: SortBy?
    var productObj: MainShopingList?
    var sortProductDelegate: SortProductDelegate?
    //   var updatedSortDelegate: updateSort?
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkOrder()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        backView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func checkOrder() {
        
        let selectedOrderBtn = productObj?.sortOrder
        let selectedCriteriaBtn = productObj?.sortBy
        
        switch selectedOrderBtn {
            case .ascending:
                imgAscending.image = UIImage(systemName: "circle.fill")
                imgDescending.image = UIImage(systemName: "circle")
                
            case .descending:
                imgDescending.image = UIImage(systemName: "circle.fill")
                imgAscending.image = UIImage(systemName: "circle")
                
            default:
                return
        }
        
        switch selectedCriteriaBtn {
            case .name:
                imgName.image = UIImage(systemName: "circle.fill")
                imgStore.image = UIImage(systemName: "circle")
                imgQuantity.image = UIImage(systemName: "circle")
                imgPrice.image = UIImage(systemName: "circle")
                imgCategory.image = UIImage(systemName: "circle")
                
            case .store:
                imgName.image = UIImage(systemName: "circle")
                imgStore.image = UIImage(systemName: "circle.fill")
                imgQuantity.image = UIImage(systemName: "circle")
                imgPrice.image = UIImage(systemName: "circle")
                imgCategory.image = UIImage(systemName: "circle")
                
            case .quantity:
                imgName.image = UIImage(systemName: "circle")
                imgStore.image = UIImage(systemName: "circle")
                imgQuantity.image = UIImage(systemName: "circle.fill")
                imgPrice.image = UIImage(systemName: "circle")
                imgCategory.image = UIImage(systemName: "circle")
            case .price:
                imgName.image = UIImage(systemName: "circle")
                imgStore.image = UIImage(systemName: "circle")
                imgQuantity.image = UIImage(systemName: "circle")
                imgPrice.image = UIImage(systemName: "circle.fill")
                imgCategory.image = UIImage(systemName: "circle")
                
            case .category:
                imgName.image = UIImage(systemName: "circle")
                imgStore.image = UIImage(systemName: "circle")
                imgQuantity.image = UIImage(systemName: "circle")
                imgPrice.image = UIImage(systemName: "circle")
                imgCategory.image = UIImage(systemName: "circle.fill")
                
            default:
                return
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func btnAscendingDescendingAction(_ sender: UIButton) {
       
                switch sender.tag {
                    case 1:
                        imgAscending.image = UIImage(systemName: "circle.fill")
                        imgDescending.image = UIImage(systemName: "circle")
                        btnAscending.isSelected = true
                        btnDescending.isSelected = false
                    case 2:
                        imgDescending.image = UIImage(systemName: "circle.fill")
                        imgAscending.image = UIImage(systemName: "circle")
                        btnAscending.isSelected = false
                        btnDescending.isSelected = true
                    default:
                        return
                }
     }
    
    @IBAction func btnSortAction(_ sender: UIButton) {
        
        sender.isSelected = true
        
        switch sender.tag {
            case 1:
                imgName.image = UIImage(systemName: "circle.fill")
                imgStore.image = UIImage(systemName: "circle")
                imgQuantity.image = UIImage(systemName: "circle")
                imgPrice.image = UIImage(systemName: "circle")
                imgCategory.image = UIImage(systemName: "circle")
                btnName.isSelected = true
                btnStore.isSelected = false
                btnQty.isSelected = false
                btnPrice.isSelected = false
                btnCategory.isSelected = false
                
            case 2:
                imgName.image = UIImage(systemName: "circle")
                imgStore.image = UIImage(systemName: "circle.fill")
                imgQuantity.image = UIImage(systemName: "circle")
                imgPrice.image = UIImage(systemName: "circle")
                imgCategory.image = UIImage(systemName: "circle")
                btnName.isSelected = false
                btnStore.isSelected = true
                btnQty.isSelected = false
                btnPrice.isSelected = false
                btnCategory.isSelected = false
             
            case 3:
                imgName.image = UIImage(systemName: "circle")
                imgStore.image = UIImage(systemName: "circle")
                imgQuantity.image = UIImage(systemName: "circle.fill")
                imgPrice.image = UIImage(systemName: "circle")
                imgCategory.image = UIImage(systemName: "circle")
                btnName.isSelected = false
                btnStore.isSelected = false
                btnQty.isSelected = true
                btnPrice.isSelected = false
                btnCategory.isSelected = false
             
            case 4:
                imgName.image = UIImage(systemName: "circle")
                imgStore.image = UIImage(systemName: "circle")
                imgQuantity.image = UIImage(systemName: "circle")
                imgPrice.image = UIImage(systemName: "circle.fill")
                imgCategory.image = UIImage(systemName: "circle")
                btnName.isSelected = false
                btnStore.isSelected = false
                btnQty.isSelected = false
                btnPrice.isSelected = true
                btnCategory.isSelected = false
                
            case 5:
                imgName.image = UIImage(systemName: "circle")
                imgStore.image = UIImage(systemName: "circle")
                imgQuantity.image = UIImage(systemName: "circle")
                imgPrice.image = UIImage(systemName: "circle")
                imgCategory.image = UIImage(systemName: "circle.fill")
                btnName.isSelected = false
                btnStore.isSelected = false
                btnQty.isSelected = false
                btnPrice.isSelected = false
                btnCategory.isSelected = true
           
            default:
                return
        }
        
    }
    
    @IBAction func btnCancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnOkayAction(_ sender: UIButton) {
       
        let arrMainList = UserLocalData.mainShopingList
        
        for List in arrMainList {
            if List.id == productObj?.id {
               
                if btnAscending.isSelected {
                    List.sortOrder = .ascending
                }
                else if btnDescending.isSelected {
                    List.sortOrder = .descending
                }
                
                if btnName.isSelected {
                    List.sortBy = .name
                }
                else if btnStore.isSelected {
                    List.sortBy = .store
                }
                else if btnQty.isSelected {
                    List.sortBy = .quantity
                }
                else if btnPrice.isSelected {
                    List.sortBy = .price
                }
                else if btnCategory.isSelected {
                    List.sortBy = .category
                }
                sortProductDelegate?.updatedSortProduct(updatedObj: List)
            }
        }
        UserLocalData.saveArrayToUserDefault(arrData: arrMainList)
         dismiss(animated: true, completion: nil)
    }
}

// updated object send back viewController
protocol SortProductDelegate {
    func updatedSortProduct(updatedObj: MainShopingList)
}
