//
//  SampleDataCell.swift
//  BLEPremiumDesign
//
//  Created by Darshan Kalathiya on 27/12/24.
//

import UIKit

class SampleDataCell: UITableViewCell {
    
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var btnCopy: UIButton!
    
    static var identifier: String {
        return String(describing: self)
        
    }

    @IBAction func onBtnCopy(_ sender: UIButton) {
        UIPasteboard.general.string = self.lblDetail.text
        UIApplication.topViewController()?.view.makeToast("Copy to clipboard")
    }
    
    func setData(arrObj: [SampleDataRecord]) {
        let jsonString = encodeToPrettyJSONString(objects: arrObj)
        lblDetail.text = jsonString
    }
    
    func encodeToPrettyJSONString(objects: [SampleDataRecord]) -> String {
        do {
            // Create a JSONEncoder instance
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted,.sortedKeys]             
            // Encode the array, excluding nil values
            let jsonData = try encoder.encode(objects)
            
            // Convert JSON data to a JSON string
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        return ""
    }


}
