//
//  AddShopingListVC.swift
//  ShopingListProject
//
//  Created by mac on 19/06/24.
//

import UIKit

class AddShopingListVC: UIViewController {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet var BackView: UIView!
    
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var lblHeaderText: UILabel!
    
    @IBOutlet var txtCategoryName: UITextField!
    @IBOutlet var txtPriority: UITextField!
    @IBOutlet var txtViewNotes: UITextView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    let pickerView = UIPickerView()
    let arrPriority = ["Normal", "Low","High"]
    var arrMainObj = [MainShopingList]()
    weak var delegate: AddVCDelegate?
    var shoppingListsObject: MainShopingList?
    var editScreen: Bool?
    
    // ----------------------------------------------------------
    //                       MARK: - View Life Cycle -
    // ----------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        txtCategoryName.delegate = self
        
        notes()
        setupPickerView()
        placeholderColor()
        editData()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        BackView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func notes() {
        let notesText = shoppingListsObject?.notes ?? ""
        if editScreen == true {
            lblHeaderText.text = "Edit Shopping List"
            if notesText == "" {
                txtViewNotes.text = "Notes"
                txtViewNotes.textColor = UIColor.placeholderText
            }
            else {
                txtViewNotes.text = shoppingListsObject?.notes
                txtViewNotes.textColor = UIColor.black
            }
        }
        else {
            txtViewNotes.text = "Notes"
            txtViewNotes.textColor = UIColor.placeholderText
        }
        txtViewNotes.delegate = self
    }
    
    func editData(){
        
        if editScreen == true {
            
            txtCategoryName.text = shoppingListsObject?.nameSL
            txtPriority.text = "\(shoppingListsObject?.priority ?? .Normal)"
            
            switch shoppingListsObject?.priority {
                case .Normal:
                    txtPriority.textColor = .green
                case .Low:
                    txtPriority.textColor = .blue
                case .High:
                    txtPriority.textColor = .red
                default:
                    return
            }
        }
    }
    
    // Set the placeholder with custom color
    func placeholderColor() {
        let placeholderText = "Shoping List Name"
        
        txtCategoryName.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.plaseholderColor]
        )
    }
    
    func EditList() {
        
        let name = txtCategoryName.text?.capitalized
        var notes: String
        
        if txtViewNotes.text == "Notes" {
            notes = ""
            
        } else {
            notes = txtViewNotes.text
            txtViewNotes.textColor = UIColor.black
        }
        
        if txtCategoryName.text == "" {
            let toast = CustomToast(image: UIImage(named: "shopping-cart"), message: "Please provide a product name!")
            toast.show(on: view)
            
            // Example hide after a delay:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                toast.hide()
            }
        }
        else{
            let selectedPriority = pickerView.selectedRow(inComponent: 0)
            let updatedList = MainShopingList(id: shoppingListsObject?.id ?? "", nameSL: name ?? "", priority: Priority(rawValue: selectedPriority) ?? .Normal, notes: notes, arrProuduct: shoppingListsObject?.arrProduct ?? [], isExpand: shoppingListsObject?.isExpand ?? false, totalProductPrice: shoppingListsObject?.totalProductPrice ?? 0,sortOrder: .ascending,sortBy: .name)
            
            UserLocalData.updateMainShopingList(with: updatedList)
            delegate?.didDismissPresentedViewController(updatedObj: shoppingListsObject,screen: .EditScreen)
            dismiss(animated: false, completion: nil)
            
            
        }
    }
    
    func newListAdd() {
      
        let name = txtCategoryName.text?.capitalized
        var notes: String
        
        if txtViewNotes.text == "Notes" {
            notes = ""
        } else {
            notes = txtViewNotes.text
        }
        
        if txtCategoryName.text == "" {
            let toast = CustomToast(image: UIImage(named: "shopping-cart"), message: "Please provide a product name!")
            toast.show(on: view)
            
            // Example hide after a delay:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                toast.hide()
            }
        }
        else{
            let selectedPriority = pickerView.selectedRow(inComponent: 0)
            let idName = name?.replacingOccurrences(of: " ", with: "") ?? ""
            let objectSL = MainShopingList.init(id: idName,nameSL: name ?? "New Shoping List", priority: Priority(rawValue: selectedPriority) ?? .Normal, notes: notes, arrProuduct: [],isExpand: true, totalProductPrice: 0,sortOrder: .ascending, sortBy: .name)
            
            shoppingListsObject = objectSL
            UserLocalData.mainShopingList.append(objectSL)
            dismiss(animated: false, completion: nil)
            delegate?.didDismissPresentedViewController(updatedObj: shoppingListsObject,screen: .AddScreeen)
            
        }
    }
    
    func setupPickerView() {
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.frame.size = CGSize(width: 0, height: 150)
        txtPriority.inputView = pickerView
        
        // Set up the toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
             
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        // Set the pickerView and toolbar as the inputView and inputAccessoryView for the text field
        pickerView.selectRow(0, inComponent: 0, animated: true)
        txtPriority.text = arrPriority[0]
        
        switch arrPriority[0] {
            case "Normal":
                txtPriority.textColor = .green
            case "Low":
                txtPriority.textColor = .blue
            case "High":
                txtPriority.textColor = .red
            default:
                return
        }
        txtPriority.inputAccessoryView = toolbar
        txtPriority.inputView = pickerView
        txtViewNotes.inputAccessoryView = toolbar
        
    }
    
    @objc func doneButtonTapped() {
        // Dismiss the picker view
        txtPriority.resignFirstResponder()
        txtViewNotes.resignFirstResponder()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Button Action -
    // ----------------------------------------------------------
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okayAction(_ sender: UIButton) {
        if editScreen == true{
            EditList()
        }
        else{
            newListAdd()
        }
    }
}

extension AddShopingListVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrPriority.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrPriority[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        txtPriority.text = arrPriority[row]
        switch row {
            case 0:
                txtPriority.textColor = .green
            case 1:
                txtPriority.textColor = .blue
            case 2:
                txtPriority.textColor = .red
            default:
                return
        }
    }
}

extension AddShopingListVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField == txtCategoryName{
            if updatedText.count <= 40 {
                lblCount.text = "\(updatedText.count)/40"
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           // Dismiss the keyboard
           textField.resignFirstResponder()
           return true
       }
    
}

extension AddShopingListVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtViewNotes.text == "Notes" {
            txtViewNotes.text = ""
            txtViewNotes.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtViewNotes.text == "" {
            txtViewNotes.text = "Notes"
            txtViewNotes.textColor = UIColor.plaseholderColor
        }
    }
    
}

protocol AddVCDelegate: AnyObject {
    func didDismissPresentedViewController(updatedObj : MainShopingList?,screen: WhichScreen)
}

