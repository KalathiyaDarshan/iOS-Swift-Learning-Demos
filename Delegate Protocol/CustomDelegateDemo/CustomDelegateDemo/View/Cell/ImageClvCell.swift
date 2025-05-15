//
//  ImageClvCell.swift
//  CustomDelegateDemo
//
//  Created by Darshan Kalathiya on 27/03/25.
//

import UIKit

class ImageClvCell: UICollectionViewCell {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var imgAlbums: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnUpDown: UIButton!
    
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    let sharedManager = ContactManager.shared
    let pickerView = UIPickerView()
    var arrContact: [Contact] = []
    var objContactProfile: ContactProfile?
    var cellImg: UIImage?
    
    // ----------------------------------------------------------
    //                       MARK: - awake Method -
    // ----------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
       
        txtName.inputView = pickerView
        txtName.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func onBtnUpDown(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            txtName.becomeFirstResponder()
            if let firstContact = arrContact.first {
                txtName.text = firstContact.name
                objContactProfile = ContactProfile(img: cellImg!, contactDetail: firstContact)
                sharedManager.delegate = self
                sharedManager.storeContactData()
            }
        }else {
            txtName.resignFirstResponder()
        }
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func configCell(img: UIImage,arrObjContact: [Contact]) {
        cellImg = img
        self.imgAlbums.image = img
        self.arrContact = arrObjContact
    }
}

// -------------------------------------------------------------------
//                       MARK: - UIPickerView DataSource & Delegate -
// ------------------------------------------------------------------
extension ImageClvCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrContact.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrContact[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row < arrContact.count {
            objContactProfile = ContactProfile(img: cellImg!, contactDetail: arrContact[row])
            txtName.text = arrContact[row].name
            sharedManager.delegate = self
            sharedManager.storeContactData()  // Call only after setting objContactProfile
        }
    }
}

// -------------------------------------------------------------------
//                       MARK: - UITextField Delegate -
// ------------------------------------------------------------------
extension ImageClvCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        txtName.resignFirstResponder()
        if let firstContact = arrContact.first {
            txtName.text = firstContact.name
            objContactProfile = ContactProfile(img: cellImg!, contactDetail: firstContact)
            sharedManager.delegate = self
            sharedManager.storeContactData()
        }
        btnUpDown.isSelected = true
        return true
    }
}

// -------------------------------------------------------------------
//                       MARK: - ContactManager Delegate -
// ------------------------------------------------------------------
extension ImageClvCell: ContactManagerDelegate {
    
    func didContactDataStore() -> Any {
        return objContactProfile as Any
    }
}
