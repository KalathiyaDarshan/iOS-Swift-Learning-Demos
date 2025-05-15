//
//  ViewController.swift
//  EvolutionTask
//
//  Created by mac on 04/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet var buttonView: UIView!
    @IBOutlet var tblList: UITableView!
    
    var arrCategory = UserLocalData.mainCatagory
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonView.layer.cornerRadius = buttonView.frame.size.width/2
        buttonView.layer.shadowColor = UIColor.black.cgColor
        buttonView.layer.shadowOpacity = 0.5
        buttonView.layer.shadowOffset = CGSize(width: -1, height: 2)
        buttonView.layer.shadowRadius = 3
        buttonView.layer.masksToBounds = false
        
        tblList.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        tblList.register(UINib(nibName: "RowCell", bundle: nil), forCellReuseIdentifier: "RowCell")
        tblList.tableFooterView = UIView()
    }
    
    func loadData(){
        arrCategory = UserLocalData.mainCatagory
    }
    
    func addProduct(nameText: String,Qty:Int,index: Int) {
        
        if nameText == "" || Qty == 0{
            textFieldAlert()
        }
        else {
            
            let idName = nameText.replacingOccurrences(of: " ", with: "")
            let indexSet = IndexSet(integer: index)
            
            let objProduct = ProductList.init(id:idName , productName: nameText, qty: Qty)
            arrCategory[index].arrProduct.append(objProduct)
            UserLocalData.saveArrayToUserDefault(obj: arrCategory)
            
            tblList.reloadSections(indexSet, with: .none)
        }
    }
    
    @objc func dropDown(sender: UIButton) {
        let section = sender.tag
        
        arrCategory[section].isExpand = !(arrCategory[section].isExpand)
        tblList.reloadSections(IndexSet(integer: section), with: .none)
    }
    
    func textFieldAlert()  {
        
        let alert = UIAlertController(title: "Alert", message: "Please Enter Proper Details!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func showAlert(sender:UIButton) {
        let alertController = UIAlertController(title: arrCategory[sender.tag].name, message: "Add Product", preferredStyle: .alert)
        
        // Add two text fields to the alert
        alertController.addTextField { (textField) in
            textField.placeholder = "First Text Field"
            textField.delegate = self
            textField.tag = 1
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Qty"
            textField.delegate = self
            textField.keyboardType = .numberPad
            textField.tag = 2
        }
        
        // Add the Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Add the OK button
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if let textFields = alertController.textFields {
                let firstText = textFields[0].text ?? ""
                let secondText = textFields[1].text ?? ""
                let qty = Int(secondText) ?? 0
                
                self.addProduct(nameText: firstText, Qty: qty,index: sender.tag)
            }
        }
        
        alertController.addAction(okAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnAddView(_ sender: UIButton) {
        let popupVC = storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        popupVC.updateDelegate = self
        self.present(popupVC, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellExpanded = arrCategory[section].isExpand
        let rowCount = arrCategory[section].arrProduct.count + 1
        return cellExpanded ? rowCount : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.lblHeaderName.text = arrCategory[indexPath.section].name
            cell.btnPlus.tag = indexPath.section
            cell.btnExpand.tag = indexPath.section
            cell.btnPlus.addTarget(self, action: #selector(showAlert(sender:)), for: .touchUpInside)
            cell.btnExpand.addTarget(self, action: #selector(dropDown(sender:)), for: .touchUpInside)
            
            if arrCategory[indexPath.section].arrProduct.count > 0 {
                cell.btnExpand.isHidden = false
            }
          else{
            cell.btnExpand.isHidden = true
          }
            
            return cell
        }
        else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RowCell", for: indexPath) as! RowCell
            cell.lblCount.text = "\(arrCategory[indexPath.section].arrProduct[indexPath.row-1].qty)"
            cell.lblName.text =  arrCategory[indexPath.section].arrProduct[indexPath.row-1].productName
            return cell
        }
        
    }
    
}

extension ViewController: updateTable {
    func updateTable() {
        loadData()
        tblList.reloadData()
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1 {
            // First text field: only allow letters
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        } else if textField.tag == 2 {
            // Second text field: only allow numbers
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
