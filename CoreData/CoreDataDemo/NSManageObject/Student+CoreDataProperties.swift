//
//  Student+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by mac on 03/09/24.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var rollNo: Int64
    @NSManaged public var stream: String?

}

extension Student : Identifiable {

}
