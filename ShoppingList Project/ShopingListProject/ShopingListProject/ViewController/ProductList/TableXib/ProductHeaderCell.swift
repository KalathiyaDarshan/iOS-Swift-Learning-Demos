//
//  ProductHeaderCell.swift
//  ShopingListProject
//
//  Created by mac on 20/06/24.
//

import UIKit

class ProductHeaderCell: UITableViewHeaderFooterView {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblCount: UILabel!
    
    @IBOutlet var btnCheckBox: UIButton!
    @IBOutlet var btnExpand: UIButton!
    @IBOutlet var btnHeaderClick: UIButton!
    
    @IBOutlet var viewheader: UIView!
    @IBOutlet var expandView: UIView!
    
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var section: Int = 0
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
          setupShadow()
    }
    
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    private func setupShadow() {
        
        self.viewheader.layer.shadowColor = UIColor.gray.cgColor
        self.viewheader.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.viewheader.layer.shadowOpacity = 0.5
        self.viewheader.layer.shadowRadius = 1
        self.viewheader.layer.masksToBounds = false
    }
    
}
