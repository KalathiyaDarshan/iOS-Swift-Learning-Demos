//
//  ListTblCell.swift
//  ShopingListProject
//
//  Created by mac on 19/06/24.
//

import UIKit

class ListTblCell: UITableViewCell {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var lblProductCount: UILabel!
    @IBOutlet var lblNrOfItems: UILabel!
    @IBOutlet var lblTotalAmount: UILabel!
    @IBOutlet var lblPriority: UILabel!
    @IBOutlet var lblNotes: UILabel!
    
    @IBOutlet var viewSecondMain: UIView!
    @IBOutlet var subView: UIView!
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var stackView: UIStackView!
    
    @IBOutlet var btnDownAction: UIButton!
    @IBOutlet var btnCeckBox: UIButton!
    
    var indexPath: IndexPath?
    var tableView: UITableView?
    
    // ----------------------------------------------------------
    //                       MARK: - awake Method -
    // ----------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        
        subView.layer.masksToBounds = false
        subView.layer.cornerRadius = 5
        subView.layer.shadowColor = UIColor.gray.cgColor
        subView.layer.shadowOffset = CGSize(width: 0, height: 1)
        subView.layer.shadowOpacity = 0.3
        subView.layer.shadowRadius = 1
        colorView.layer.cornerRadius = 5
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellData(object: MainShopingList) {
    
        let totalQuantity = object.arrProduct.reduce(0) { sum, product in
            sum + product.qty
        }
        let listColor =  object.arrProduct.filter {$0.chackMark == true }
        
        self.lblHeader.text = object.nameSL
        self.lblProductCount.text = ("\(totalQuantity)")
        self.lblNrOfItems.text = ("Nr. Items: \(totalQuantity)")
        self.lblTotalAmount.text = ("Total Amount: \(object.totalProductPrice).00 $")
        self.lblPriority.text = ("Priority: \(object.priority)")
        self.lblNotes.text = ("Notes: \(object.notes)")
        
        if object.arrProduct.isEmpty {
            colorView.backgroundColor = .lightGray
        } else {
            if listColor.count != object.arrProduct.count {
                colorView.backgroundColor = UIColor(named: "headerColor")
            }
            else {
                colorView.backgroundColor = .lightGray
            }
        }
        
    }
}
