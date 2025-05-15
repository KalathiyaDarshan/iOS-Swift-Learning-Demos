//
//  ClassFile.swift
//  APIDemo
//
//  Created by mac on 18/07/24.
//

import Foundation

class Register: Codable {
    
    let name: String
    let email: String
    let password: String
    
    init(name:String,email:String,password:String) {
        self.name = name
        self.email = email
        self.password = password
    }
}

class Login: Codable {
    
    let email: String
    let password: String
    
    init(email:String,password:String) {
        self.email = email
        self.password = password
    }
}
