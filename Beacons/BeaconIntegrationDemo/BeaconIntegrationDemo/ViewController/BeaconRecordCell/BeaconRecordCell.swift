//
//  BeaconRecordCell.swift
//  BeaconIntegrationDemo
//
//  Created by Darshan Kalathiya on 19/12/24.
//

import UIKit

class BeaconRecordCell: UITableViewCell {
  
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var lblRSSI: UILabel!
    @IBOutlet weak var lblUUID: UILabel!
    @IBOutlet weak var lblMajor: UILabel!
    @IBOutlet weak var lblMinor: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    
    // ----------------------------------------------------------
    //                       MARK: - awake Method -
    // ----------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func setData(obj: BeaconRecord) {
        lblRSSI.text = "\(obj.averageRSSI)"
        lblUUID.text = "UUID: \(obj.uuid)"
        lblMajor.text = "Major: \(obj.major)"
        lblMinor.text = "Minor: \(obj.minor)"
        lblDistance.text = "Distance: \(obj.distance) Mtr"
    }
}
