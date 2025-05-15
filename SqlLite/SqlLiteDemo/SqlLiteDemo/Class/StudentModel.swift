//
//  StudentModel.swift
//  SqlLiteDemo
//
//  Created by mac on 05/09/24.
//

import Foundation

class StudentModel {
    var id: Int
    var name: String
    var number: Int
    var email: String
    
    init(id: Int,name: String, number: Int, email: String) {
        self.id = id
        self.name = name
        self.number = number
        self.email = email
    }
}
