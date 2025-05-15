//
//  TextFieldValidation.swift
//  TextField_Validation
//
//  Created by Apple on 03/10/24.
//

import Foundation

public class TextFieldValidation{
    public static func emailValidation(email: String) -> Bool{
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: email)
    }
}
