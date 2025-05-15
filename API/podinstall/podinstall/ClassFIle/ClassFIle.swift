//
//  ClassFIle.swift
//  podinstall
//
//  Created by mac on 23/07/24.
//

import Foundation

class RegiseterUser: Codable{
    var name: String
    var email: String
    var password: String
    
    init(name: String,email:String,password:String) {
        self.name = name
        self.email = email
        self.password = password
    }
}

