//
//  CoreDataManager.swift
//  CoreDataDemo
//
//  Created by mac on 03/09/24.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    var fetchedData: [Student] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func SaveData(obj: StudentDetails) {
        let student = Student(context: context)
        
        student.id = obj.id
        student.name = obj.name
        student.rollNo = Int64(obj.rollNo)
        student.stream = obj.stream
        
        // database reflect
        do {
            try context.save()
          }catch{
            print("Purchase Saving Error",error)
        }
    }
    
    func fetchData(completion: @escaping ([StudentDetails]) -> Void){
        
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        
        do {
            var studentModelArray: [StudentDetails] = []
            
            fetchedData = try context.fetch(fetchRequest)
            for student in fetchedData {
                let studentModel = StudentDetails(
                   
                    id: student.id ?? UUID(),
                    name: student.name ?? "",
                    stream: student.stream ?? "",
                    rollNo: Int(student.rollNo)
                )
                studentModelArray.append(studentModel)
            }
            completion(studentModelArray)
        } catch {
            print("Data Fetching Error: \(error)")
            completion([])
        }
    }
    
    func deleteData(by id: UUID, completion: @escaping (Bool) -> Void) {
        
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)  // Filter by the id
        
        do {
            let fetchedData = try context.fetch(fetchRequest)
            
            // Assuming `id` is unique, we expect only one result
            if let studentToDelete = fetchedData.first {
                
                context.delete(studentToDelete)
                
                try context.save()  // Save the context after deleting
                completion(true)    // Success: Deletion was successful
                
            } else {
                completion(false)    // Failure: No student found with the given id
            }
            
        } catch {
            print("Delete Error: \(error)")
            completion(false)        // Failure: Error during fetching or deleting
        }
    }
    
    func updateStudent(obj: StudentDetails,completion: @escaping (Bool) -> Void) {
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", obj.id as CVarArg)  // Filter by the id
        
        do {
            let fetchedData = try context.fetch(fetchRequest)
            
            // Assuming `id` is unique, we expect only one result
            if let studentToUpdate = fetchedData.first {
                
                // Update the properties
                studentToUpdate.name = obj.name
                studentToUpdate.stream = obj.stream
                studentToUpdate.rollNo = Int64(obj.rollNo)
                
                // Save the updated context
                try context.save()
                
                completion(true)  // Success: Update was successful
            } else {
                completion(false) // Failure: No student found with the given id
            }
            
        } catch {
            print("Update Error: \(error)")
            completion(false)     // Failure: Error during fetching or updating
        }
    }

}
