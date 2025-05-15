//
//  ViewController.swift
//  CustomDelegateDemo
//
//  Created by Darshan Kalathiya on 24/03/25.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController, ContactManagerDelegate {

    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var btnAllSelect: UIButton!
    @IBOutlet weak var tblContactList: UITableView!
    
    @IBOutlet weak var btnNext: UIButton!
    
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var arrContacts: [Contact] = []
    let contactStore = CNContactStore()
    let sharedManager = ContactManager.shared
    var selectedContacts: [Contact] = []

    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblContactList.register(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
        requestContactsPermission()
        
        // Access shared instance
        sharedManager.delegate = self
    }
      
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func onBtnAllSelect(_ sender: UIButton) {
        sender.isSelected.toggle()
        arrContacts.forEach { $0.isSelect = sender.isSelected }
        tblContactList.reloadData()
    }
    
    @IBAction func onBtnNextClick(_ sender: UIButton) {
                
        // Iterate one by one where isSelect is true
        for contact in arrContacts where contact.isSelect {
            selectedContacts.append(contact)
        }
        
        // Store data
        sharedManager.storeData()
        
        let imageVC = storyboard?.instantiateViewController(withIdentifier: "ImageVC") as! ImageVC
        navigationController?.pushViewController(imageVC, animated: true)
    }
       
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    // Request Permission to Access Contacts
    func requestContactsPermission() {
        contactStore.requestAccess(for: .contacts) { granted, error in
            if granted {
                self.fetchContacts()
            } else {
                print("Permission Denied: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    // Fetch Contacts
    func fetchContacts() {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            var fetchedContacts: [Contact] = []
            try contactStore.enumerateContacts(with: request) { (contact, stopPointer) in
                if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                    let fullName = "\(contact.givenName) \(contact.familyName)".trimmingCharacters(in: .whitespaces)
                    fetchedContacts.append(Contact(name: fullName, phoneNumber: phoneNumber))
                }
            }
            
            DispatchQueue.main.async {
                self.arrContacts = fetchedContacts
                self.tblContactList.reloadData()
            }
        } catch {
            print("Failed to fetch contacts: \(error)")
        }
    }
    
    func didStoreData() -> [Any] {
        return selectedContacts
    }
    
}

// ----------------------------------------------------------
//                       MARK: - UITableView DataSource -
// ----------------------------------------------------------
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactCell
        let contact = arrContacts[indexPath.row]
        cell.configCell(objContact: contact)
        return cell
    }
}


// ----------------------------------------------------------
//                       MARK: - UITableView Delegate -
// ----------------------------------------------------------
extension ViewController: UITableViewDelegate {
    
}
