//
//  SampleDataCell.swift
//  BLEPremiumDesign
//
//  Created by Darshan Kalathiya on 27/12/24.
//

import UIKit

class SampleDataHeaderCell: UITableViewCell {
  
    var buttonActionCallback: (() -> Void)?
    var objSampleRecord : SampleData?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnExpand: UIButton!
    
    @IBAction func obBtnExpand(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        objSampleRecord?.isExpand.toggle()
        buttonActionCallback?()
    }
    
    static var identifier: String {
        return String(describing: self)
    }
  
    func setData(obj: SampleData) {
        objSampleRecord = obj
        btnExpand.isSelected = obj.isExpand
        lblTitle.text = obj.title
    }
}
