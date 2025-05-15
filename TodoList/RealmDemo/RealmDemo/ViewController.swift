//
//  ViewController.swift
//  RealmDemo
//
//  Created by mac on 11/09/24.
//

import UIKit

class ViewController: UIViewController {

    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var tblContact: UITableView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var arrContact: [Contact] = []
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        tblContact.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tblContact.tableFooterView = UIView()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func presentAlertBox(isAdd: Bool, index: Int){
        let alertController = UIAlertController(title: isAdd ? "Add Contact" : "Update Contact", message: isAdd ?  "Please enter your contact detail": "Please update your contact detail", preferredStyle: .alert)
        
        let save = UIAlertAction(title: isAdd ? "Save": "Update", style: .default){ _ in
            
            if let firstname = alertController.textFields?.first?.text,
               let lastname = alertController.textFields?[1].text {
                let contact = Contact.init(firstName: firstname, lastName: lastname)
                
                if isAdd{
                    self.arrContact.append(contact)
                    self.tblContact.reloadData()
                }else{
                    self.arrContact[index] = contact
                    
                    let indexPath = IndexPath(item: index, section: 0)
                    self.tblContact.reloadRows(at: [indexPath], with: .automatic)
                }
                    
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(save)
        alertController.addAction(cancel)
        
        alertController.addTextField{ firstName in
            firstName.placeholder = "Enter your firstname"
            
            firstName.text = isAdd ? "" : self.arrContact[index].firstName
            
        }
        
        alertController.addTextField{ lastName in
            lastName.placeholder = "Enter your lastname"
            
            lastName.text = isAdd ? "" : self.arrContact[index].lastName
            
        }
        present(alertController, animated: true, completion: nil)
    }
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    @IBAction func btnAddContact(_ sender: UIBarButtonItem) {
        presentAlertBox(isAdd: true,index: 0)
    }
    
}

// ----------------------------------------------------------
//                       MARK: - UITableView DataSource -
// ----------------------------------------------------------
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrContact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = arrContact[indexPath.row].firstName
        cell.detailTextLabel?.text = arrContact[indexPath.row].lastName
        return cell
    }
    
    
}
// ----------------------------------------------------------
//                       MARK: - UITableView Delegate -
// ----------------------------------------------------------
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
            self.presentAlertBox(isAdd: false, index: indexPath.row)
        }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.arrContact.remove(at: indexPath.row)
            self.tblContact.reloadData()
        }
        
        let swipeConfigration = UISwipeActionsConfiguration(actions: [delete,edit])
        return swipeConfigration
    }
}

