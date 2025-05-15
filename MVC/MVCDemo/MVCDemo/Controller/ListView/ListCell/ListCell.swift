//
//  ListCell.swift
//  MVCDemo
//
//  Created by Apple on 01/10/24.
//

import UIKit

class ListCell: UITableViewCell {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------

    // ----------------------------------------------------------
    //                       MARK: - awake Method -
    // ----------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func setCellData(obj: Product){
        lblName.text = "Name: \(obj.name)"
        lblPrice.text = "Price: \(obj.price)"
        lblQty.text = "Qty: \(obj.quantity)"
        lblTotal.text = "Total: \(obj.totalPrice())"
    }
}
