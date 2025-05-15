//
//  Student.swift
//  CoreDataDemo
//
//  Created by mac on 03/09/24.
//

import Foundation

class StudentDetails{
    let id: UUID
    var name: String
    var stream: String
    var rollNo: Int
    
    init(id: UUID,name: String,stream: String,rollNo: Int) {
        self.id = id
        self.name = name
        self.stream = stream
        self.rollNo = rollNo
    }
}
