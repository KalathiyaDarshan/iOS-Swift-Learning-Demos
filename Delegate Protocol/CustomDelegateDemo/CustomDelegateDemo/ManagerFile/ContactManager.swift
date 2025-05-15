//
//  ContactManager.swift
//  CustomDelegateDemo
//
//  Created by Darshan Kalathiya on 24/03/25.
//

import Foundation
import UIKit

// Creat a Protocol
@objc protocol ContactManagerDelegate: AnyObject {
    @objc optional func didRetrieveData(_ arrData: [Any])
    @objc optional func didStoreData() -> [Any]
    @objc optional func didContactDataStore() -> Any
    @objc optional func didRetrieveContactProfileData(_ arrData: [Any])
}

class ContactManager {
    
    static let shared = ContactManager()
    private init() {}  // Prevents multiple instances
    weak var delegate: ContactManagerDelegate?
    
    private var arrContactList: [Contact] = []
    private var arrContactProfile: [ContactProfile] = []
    
    func fetchData() {
        // Notify delegate with the updated contact list
        delegate?.didRetrieveData?(arrContactList)
    }

    func storeData() {
        if let storedData = delegate?.didStoreData?() as? [Contact] {
            arrContactList = storedData
            print("Stored Data: \(arrContactList.count)")
        } else {
            print("Error: No data returned from delegate")
        }
    }
    
    func storeContactData() {
        if let storedData = delegate?.didContactDataStore?() as? ContactProfile {
            if let index = arrContactProfile.enumerated().first(where: { $0.element.img == storedData.img })?.offset {
                arrContactProfile[index].contactDetail = storedData.contactDetail
            } else {
                arrContactProfile.append(storedData)
            }
            print("Stored Data: \(arrContactProfile.count)")
        } else {
            print("Error: No data returned from delegate")
        }
    }
    
    func removeContactData() {
        arrContactProfile.removeAll()
    }
    
    func fetchContactProfile() {
        delegate?.didRetrieveContactProfileData?(arrContactProfile)
    }
}
