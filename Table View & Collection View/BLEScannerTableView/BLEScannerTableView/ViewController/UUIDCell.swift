//
//  UUIDCell.swift
//  BLEScannerTableView
//
//  Created by Darshan Kalathiya on 14/05/25.
//

import UIKit

class UUIDCell: UITableViewCell {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var txtUUID: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var btnSaveTapped: ((Bool,FilterUUID?) -> Void)?
    var toastMassage: ((String) -> Void)?
    var objFilterUUID: FilterUUID?
    var isEdit: Bool = false
    
    // ----------------------------------------------------------
    //                       MARK: - awake Method -
    // ----------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()

        txtUUID.delegate = self
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func onBtnSaveClick(_ sender: UIButton) {
        let uuid = txtUUID.text ?? ""

        if !isValidData() {
            if isEdit {
                objFilterUUID?.isEditMode = false
                objFilterUUID?.isSaved = true
                objFilterUUID?.uuid = uuid
                btnSaveTapped?(false,nil) // for Reload table row
            }else {
                btnSaveTapped?(true,FilterUUID.init(uuid: uuid,isSaved: true))
            }
        }
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func setData(objFilterUUID: FilterUUID) {
        btnSave.isEnabled = !objFilterUUID.isSaved
        txtUUID.isEnabled = !objFilterUUID.isSaved
        
        txtUUID.text = objFilterUUID.uuid
       // txtUUID.text = "00000000-0000-1000-8000-00805F9B34FB"
                
        self.isEdit = objFilterUUID.isEditMode
        self.objFilterUUID = objFilterUUID
        btnSave.setTitle(objFilterUUID.isSaved ? "Saved" : "Save", for: .normal)
    }
    
   private func isValidServiceUUID(_ uuidString: String) -> Bool {
        let capUUIDString = uuidString.uppercased()
        let uuidPattern = #"^(?:[0-9A-F]{4}|[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12})$"#
        // 0000180D-0000-1000-8000-00805F9B34FB
        //"^(?:[0-9a-fA-F]{4}|0000[0-9a-fA-F]{4}-0000-1000-8000-00805[0-9a-fA-F]{4})$"
        let regex = try! NSRegularExpression(pattern: uuidPattern)
        let range = NSRange(location: 0, length: capUUIDString.utf16.count)
        return regex.firstMatch(in: capUUIDString, options: [], range: range) != nil
    }
    
   private func isValidData() -> Bool {
        txtUUID.text = txtUUID.text?.uppercased() ?? ""
        
        if (self.txtUUID.text?.count ?? 0) > 0 {
            if  !self.isValidServiceUUID(self.txtUUID.text?.uppercased() ?? "") {
              //  self.toastMassage?(AlertMsg.UUID_Invaliad)
                self.toastMassage?("Invalid UUID")
                return false
            }
        } else {
            //  self.toastMassage?(AlertMsg.UUID_Empty)
            self.toastMassage?("UUID is Empty")
            return false
        }
        
        return true
    }
}

// ----------------------------------------------------------
//                       MARK: - UITextField Delegate -
// ----------------------------------------------------------
extension UUIDCell : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Check if the replacement string contains only valid characters (hexadecimal digits)
        
        // Allow backspace/delete key
        if string.isEmpty {
            return true
        }
        
        if textField == txtUUID
        {
            let validCharacterSet = CharacterSet(charactersIn: "0123456789ABCDEF-abcdef").inverted
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            if newText.count > 36
            {
                return false
            }
            let isValidInput = newText.rangeOfCharacter(from: validCharacterSet) == nil
            
            return isValidInput
        }
        
        return true
    }
}

