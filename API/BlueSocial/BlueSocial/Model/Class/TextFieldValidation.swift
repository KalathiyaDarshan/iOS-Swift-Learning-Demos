//
//  TextFieldValidation.swift
//  BlueSocial
//
//  Created by mac on 29/07/24.
//

import Foundation

class Validation {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidName(_ name: String) -> Bool {
        let nameRegex = "^[A-Za-z]{2,}$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        // Check password length (at least 8 characters)
        guard password.count >= 8 else { return false }
        
        // Check if password contains at least one uppercase letter
        let uppercaseLetter = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
        guard uppercaseLetter.evaluate(with: password) else { return false }
        
        // Check if password contains at least one lowercase letter
        let lowercaseLetter = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
        guard lowercaseLetter.evaluate(with: password) else { return false }
        
        // Check if password contains at least one digit
        let digit = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
        guard digit.evaluate(with: password) else { return false }
        
        return true
    }
}

