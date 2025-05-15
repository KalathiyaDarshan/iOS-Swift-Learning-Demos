//
//  SortViewController.swift
//  SortShopingListVC
//
//  Created by mac on 08/07/24.
//

import UIKit

class SortShopingListVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var imgDescending: UIImageView!
    @IBOutlet var imgAscending: UIImageView!
    @IBOutlet var imgPriority: UIImageView!
    @IBOutlet var imgName: UIImageView!
    
    @IBOutlet var backView: UIView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var selectedOrder: SortingOrder?
    var selectedCategory: SortingCriteria?
    var updatedSortDelegate: UpdateSortDelegate?
    
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
        
        let selectedOrderBtn = UserLocalData.sortingOrder
        let selectedCriteriaBtn = UserLocalData.sortingCriteria
        
        selectedOrder = UserLocalData.sortingOrder ?? .ascending
        selectedCategory =  UserLocalData.sortingCriteria ?? .name
        
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
                imgPriority.image = UIImage(systemName: "circle")
            case .priority:
                imgPriority.image = UIImage(systemName: "circle.fill")
                imgName.image = UIImage(systemName: "circle")
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
                selectedOrder = .ascending
            case 2:
                imgDescending.image = UIImage(systemName: "circle.fill")
                imgAscending.image = UIImage(systemName: "circle")
                selectedOrder = .descending
            default:
                return
        }        
    }
    
    @IBAction func btnSortAction(_ sender: UIButton) {
        
        switch sender.tag {
            case 1:
                imgName.image = UIImage(systemName: "circle.fill")
                imgPriority.image = UIImage(systemName: "circle")
                selectedCategory = .name
            case 2:
                imgPriority.image = UIImage(systemName: "circle.fill")
                imgName.image = UIImage(systemName: "circle")
                selectedCategory = .priority
            default:
                return
        }
    }
    
    @IBAction func btnCancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnOkayAction(_ sender: UIButton) {
        
        UserLocalData.sortingOrder = selectedOrder
        UserLocalData.sortingCriteria = selectedCategory
        
        updatedSortDelegate?.updatedSorting(updateOrder: selectedOrder, updatedCategory: selectedCategory)
        
        dismiss(animated: true, completion: nil)
    }
}

// ViewController Screen
protocol UpdateSortDelegate {
    func updatedSorting(updateOrder: SortingOrder?, updatedCategory: SortingCriteria?)
}
