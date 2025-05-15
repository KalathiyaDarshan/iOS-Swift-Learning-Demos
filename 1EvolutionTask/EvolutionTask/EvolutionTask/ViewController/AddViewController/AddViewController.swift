//
//  AddViewController.swift
//  EvolutionTask
//
//  Created by mac on 04/07/24.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var txtAdd: UITextField!
    @IBOutlet var backView: UIView!
    
    var updateDelegate: updateTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        txtAdd.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        backView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        
        if txtAdd.text == ""{
            let alert = UIAlertController(title: "Alert", message: "Please Enter Category.", preferredStyle: .alert)
               
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               
               self.present(alert, animated: true, completion: nil)
        }else {
            
            let idName = txtAdd.text?.replacingOccurrences(of: " ", with: "") ?? ""
            let objectSL = MainCatagory.init(id: idName, name: txtAdd.text ?? "", arrProuduct: [], isExpand: false)
            
            UserLocalData.mainCatagory.append(objectSL)
            updateDelegate?.updateTable()
            dismiss(animated: false, completion: nil)
        }
        
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Define allowed characters (letters and whitespace)
        let allowedCharacters = CharacterSet.letters.union(.whitespaces)
        let characterSet = CharacterSet(charactersIn: string)
        
        // Check if the string contains only allowed characters
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }
        
        // Get the current text
        let currentText = textField.text ?? ""
        
        // Create the new text string after the proposed change
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // If the text field is txtAdd, check the length
        if textField == txtAdd {
            if updatedText.count <= 40 {
                lblCount.text = "\(updatedText.count)/40"
                return true
            } else {
                return false
            }
        }
        
        return true
    }
}

protocol updateTable {
    func updateTable()
}
