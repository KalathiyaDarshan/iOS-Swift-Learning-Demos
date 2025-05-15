//
//  AddProductViewController.swift
//  ShopingListProject
//
//  Created by mac on 20/06/24.
//

import UIKit

class AddProductViewController: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var btnExpand: UIButton!
    @IBOutlet var btnOkay: UIButton!
    
    @IBOutlet var viewCategory: UIView!
    @IBOutlet var viewStore: UIView!
    @IBOutlet var textView: UIView!
    @IBOutlet var backView: UIView!
    
    @IBOutlet var txtQty: UITextField!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtPrice: UITextField!
    @IBOutlet var txtNote: UITextView!
    @IBOutlet var txtCategory: UITextField!
    @IBOutlet var txtStore: UITextField!
    
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var lblAlertMessage: UILabel!
    @IBOutlet var lblProductHeader: UILabel!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var shoppingListsObject: MainShopingList?
    var shoppingListsUpdate = UserLocalData.mainShopingList
    var productObject: ProductList?
    weak var productDelegate: AddViewControllerDelegate?
    var editMode: Bool?
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        txtName.delegate = self
        txtQty.delegate = self
        txtPrice.delegate = self
        txtCategory.delegate = self
        txtStore.delegate = self
        txtNote.delegate = self
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        backView.addGestureRecognizer(tapGestureRecognizer)
        
        placeholderColor(placeholder: "Product Name", txtField: txtName)
        placeholderColor(placeholder: "Qty.", txtField: txtQty)
        placeholderColor(placeholder: "Price", txtField: txtPrice)
        placeholderColor(placeholder: "Category", txtField: txtCategory)
        placeholderColor(placeholder: "Store", txtField: txtStore)
        
        notes()
        editDetaFill()
        setupPickerView()
    }
    
    @objc func handleTap() {
        // Dismiss the view controller
        dismiss(animated: true, completion: nil)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    // textView set placeholder
    func notes() {
        let notesText = productObject?.notes ?? ""
        if editMode == true {
            if notesText == "" {
                txtNote.text = "Notes"
                txtNote.textColor = UIColor.placeholderText
            }
            else {
                txtNote.text = shoppingListsObject?.notes
                txtNote.textColor = UIColor.black
            }
        }
        else {
            txtNote.text = "Notes"
            txtNote.textColor = UIColor.placeholderText
        }
        txtNote.delegate = self
    }
    
    // EditMode
    func editDetaFill() {
        var notes: String
        if productObject?.notes == "" {
            notes = "Notes"
        } else {
            notes = productObject?.notes ?? ""
        }
        
        if editMode == true {
            lblProductHeader.text = "Edit Product"
            txtName.text = productObject?.productName
            txtNote.text = notes
            txtQty.text = "\(productObject?.qty ?? 0)"
            txtPrice.text = "\(productObject?.price ?? 0)"
            txtCategory.text = productObject?.category
            txtStore.text = productObject?.store
        }
    }
    
    func placeholderColor(placeholder: String,txtField: UITextField) {
        
        txtField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.plaseholderColor]
        )
    }
    
    // New Product add
    func addProduct() {
        
        let name = txtName.text?.capitalized
        var notes: String
        
        if txtNote.text == "Notes" {
            notes = ""
        } else {
            notes = txtNote.text
        }
        
        let idName = name?.replacingOccurrences(of: " ", with: "") ?? ""
        let objectPL =  ProductList.init(id: idName,productName: name ?? "", qty: Int(txtQty.text ?? "") ?? 1, price: Int(txtPrice.text ?? "") ?? 0, notes: notes, category: txtCategory.text ?? "", store: txtStore.text ?? "",isExpand: false,checkMark: false)
        
        let arrMainList = UserLocalData.mainShopingList
        
        for List in arrMainList {
            if List.id == shoppingListsObject?.id
            {
                List.arrProduct.append(objectPL)
                let sum = List.arrProduct.reduce(0){ sum, price in sum + price.productTotalPrice}
                List.totalProductPrice = sum
                productDelegate?.didDismissPresentedViewController(updatedObj: List)
            }
        }
        
        UserLocalData.saveArrayToUserDefault(arrData: arrMainList)
        dismiss(animated: true, completion: nil)
        
    }
    
    // Edit Product Okk Click
    func editProduct() {
        
        var notes: String
        let name = txtName.text?.capitalized
        let qty = Int(txtQty.text ?? "") ?? 1
        
        if txtNote.text == "Notes" {
            notes = ""
            
        } else {
            notes = txtNote.text
            txtNote.textColor = UIColor.black
        }
        
        let newProduct = ProductList.init(id: productObject?.id ?? "",productName: name ?? "", qty: qty, price: Int(txtPrice.text ?? "") ?? 0, notes: notes, category: txtCategory.text ?? "", store: txtStore.text ?? "",isExpand: false,checkMark: productObject?.chackMark ?? false)
        
        let arrMainList = UserLocalData.mainShopingList
        for list in arrMainList {
            if list.id == shoppingListsObject?.id {
                
                // Unwrapping productId and shoppingListId safely
                if let productId = productObject?.id {
                    
                    // Calculate the price difference
                    let oldQty = productObject?.qty ?? 1
                    
                    if let productIndex = list.arrProduct.firstIndex(where: { $0.id == productId }) {
                        
                        // Update the product in the shopping list
                        list.updateProduct(at: productIndex, with: newProduct)
                        
                        // Recalculate the total price for all products in the shopping list
                        let totalProductPrice = list.arrProduct.reduce(0) { sum, product in
                            sum + product.productTotalPrice
                        }
                       
                        // Update the total product price
                        list.totalProductPrice = totalProductPrice
                        
                        if oldQty > qty {
                            list.arrProduct[productIndex].qty = oldQty - qty
                           
                        } else if oldQty < qty {
                            list.arrProduct[productIndex].qty = qty
                        }
                        else {
                            list.arrProduct[productIndex].qty = oldQty
                        }
                        // Notify the delegate
                        productDelegate?.didDismissPresentedViewController(updatedObj: list)
                    }
                }
                // Dismiss the view controller
                dismiss(animated: false, completion: nil)
            }
        }
        UserLocalData.saveArrayToUserDefault(arrData: arrMainList)
    }
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    
    @IBAction func ExpandingAction(_ sender: UIButton) {
        
        if viewCategory.isHidden {
            // If viewCategory is hidden, show it and hide viewStore
            viewCategory.isHidden = false
            viewStore.isHidden = false
        } else {
            // If viewCategory is visible, hide it and show viewStore
            viewCategory.isHidden = true
            viewStore.isHidden = true
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okayAction(_ sender: UIButton) {
        
        if txtName.text == "" {
            let toast = CustomToast(image: UIImage(named: "shopping-cart"), message: "Please provide a product name!")
            toast.show(on: view)
            
            // Example hide after a delay:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                toast.hide()
            }
        }
        else{
            
            if editMode == true {
                editProduct()
            }else {
                addProduct()
            }
        }
    }
    
    @IBAction func btnMinusAction(_ sender: UIButton) {
        let currentNumber = Int(txtQty.text ?? "") ?? 0
        if currentNumber > 0 {
            txtQty.text = "\(currentNumber - 1)"
        }
    }
    
    @IBAction func btnPlusAction(_ sender: UIButton) {
        let currentNumber = Int(txtQty.text ?? "") ?? 0
        if currentNumber < 999 {
            txtQty.text = "\(currentNumber + 1)"
        }
    }
}

extension AddProductViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField == txtName {
            
            if updatedText.count <= 40 {
                lblCount.text = "\(updatedText.count)/40"
                return true
            } else {
                return false
            }
        }
        
        if textField == txtQty {
            return updatedText.count <= 3
        }
        if textField == txtPrice {
            return updatedText.count <= 7
        }
        if textField == txtCategory || textField == txtStore{
            return updatedText.count <= 15
        }
        // Allow the change if the new length is 40 characters or less
        return false
    }
    
    // if product alraady exists
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == txtName {
            if let newProduct = textField.text, !newProduct.isEmpty {
                    
                if editMode == true {
                    let filteredProducts = shoppingListsObject?.arrProduct.filter { $0.id != productObject?.id }
            
                    if filteredProducts?.contains(where: { $0.productName == newProduct }) == true {
                        lblAlertMessage.isHidden = false
                        textView.backgroundColor = .red
                        btnOkay.isEnabled = false
                        
                    }
                    else{
                        lblAlertMessage.isHidden = true
                        textView.backgroundColor = .placeholderText
                        btnOkay.isEnabled = true
                    }
                       
                }else {
                    if shoppingListsObject?.arrProduct.contains(where: { $0.productName == newProduct }) == true {
                        lblAlertMessage.isHidden = false
                        textView.backgroundColor = .red
                        btnOkay.isEnabled = false
                        
                    }
                    else{
                        lblAlertMessage.isHidden = true
                        textView.backgroundColor = .placeholderText
                        btnOkay.isEnabled = true
                    }
                }
            }
            else{
                lblAlertMessage.isHidden = true
                textView.backgroundColor = .placeholderText
                btnOkay.isEnabled = true
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func setupPickerView() {
        
        // Set up the toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        txtNote.inputAccessoryView = toolbar
        txtQty.inputAccessoryView = toolbar
        txtPrice.inputAccessoryView = toolbar
    }
    
    // Keybord Dismiss
    @objc func doneButtonTapped() {
        txtNote.resignFirstResponder()
        txtQty.resignFirstResponder()
        txtPrice.resignFirstResponder()
    }
    
}

extension AddProductViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtNote.text == "Notes" {
            txtNote.text = ""
            txtNote.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtNote.text == "" {
            txtNote.text = "Notes"
            txtNote.textColor = UIColor.plaseholderColor
        }
    }
}

protocol AddViewControllerDelegate: AnyObject {
    func didDismissPresentedViewController(updatedObj : MainShopingList)
}
