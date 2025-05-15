//
//  Contact.swift
//  CustomDelegateDemo
//
//  Created by Darshan Kalathiya on 24/03/25.
//

import Foundation
import UIKit

class Contact {
    let name: String
    let phoneNumber: String
    var isSelect: Bool
    
    init(name: String, phoneNumber: String, isSelect: Bool = false) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.isSelect = isSelect
    }
}

class ContactProfile {
    let img: UIImage
    var contactDetail: Contact
    
    init(img: UIImage, contactDetail: Contact) {
        self.img = img
        self.contactDetail = contactDetail
    }
}
