//
//  SqlLiteManager.swift
//  SqlLiteDemo
//
//  Created by mac on 05/09/24.
//

import Foundation
import SQLite3

class SqlLiteManager{
    
    static let shared = SqlLiteManager()
    
    var db: OpaquePointer?
    
    func openDatabase() {
        if db == nil {
            let documentsDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let databasePath = documentsDirectory.appendingPathComponent("dbStudent.db")
            
            if sqlite3_open(databasePath.path, &db) == SQLITE_OK {
                print("Successfully opened database at \(databasePath.path)")
            } else {
                print("Error opening database")
            }
        }
    }
    
    // Close the database
    func closeDatabase() {
        if db != nil {
            sqlite3_close(db)
            db = nil
            print("Database connection closed.")
        }
    }
    
    // Function to create the Student table if it doesn't exist
    func createTable() {
        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS Student (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                Name TEXT,
                Number INTEGER,
                Email TEXT
            );
            """
        
        var stmt: OpaquePointer?
        
        // Prepare the create table statement
        if sqlite3_prepare_v2(db, createTableQuery, -1, &stmt, nil) == SQLITE_OK {
            // Execute the create table statement
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Table created successfully!")
            } else {
                print("Error creating table.")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error preparing create table: \(errmsg)")
        }
        
        // Finalize the statement
        sqlite3_finalize(stmt)
    }
    
    // Function to insert data into the Student table
    func insertRecord(obj: StudentModel) {
        
        // Correct SQL statement with four placeholders (for id, name, number, email)
        let insertQuery = "INSERT INTO Student (Name, Number, Email) VALUES ('\(obj.name)', '\(Int32(obj.number))', '\(obj.email)');"
        
        var stmt: OpaquePointer?
        
        // Prepare the insert statement
        if sqlite3_prepare_v2(db, insertQuery, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error preparing insert: \(errmsg)")
            return
        }
        
        // Execute the insert statement
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error inserting row: \(errmsg)")
        } else {
            let lastId = sqlite3_last_insert_rowid(db)
            print("Successfully inserted row with ID \(lastId).")
        }
        
        // Finalize the statement
        sqlite3_finalize(stmt)
    }
    
    // Function to fetch and print all students from the Student table
    func fetchAllRecord() -> [StudentModel] {
        // Ensure database is open
        openDatabase()
        var students = [StudentModel]()
        
        let query = "SELECT * FROM Student order by ID desc;"
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                
                let id = sqlite3_column_int(stmt, 0)
                // Safely unwrap text columns
                let nameCString = sqlite3_column_text(stmt, 1)
                let name = nameCString != nil ? String(cString: nameCString!) : "Unknown"
                
                let number = sqlite3_column_int(stmt, 2)
                
                let emailCString = sqlite3_column_text(stmt, 3)
                let email = emailCString != nil ? String(cString: emailCString!) : "Unknown"
                
               // print("id: \(id), name: \(name), number: \(number), email: \(email)")
                // Create a StudentModel object and append to the array
                let student = StudentModel(id: Int(id), name: name, number: Int(number), email: email)
                students.append(student)
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error fetching data: \(errmsg)")
        }
        
        sqlite3_finalize(stmt)
        return students
    }
    
    func deleteRecord(by id: Int) {
        // Ensure the database is open before attempting any operation
        if db == nil {
            SqlLiteManager.shared.openDatabase()
        }
        
        // SQL statement to delete a record by ID
        let deleteQuery = "DELETE FROM Student WHERE id = '\(Int32(id))';"
        
        var stmt: OpaquePointer?
        
        // Prepare the delete statement
        if sqlite3_prepare_v2(db, deleteQuery, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error preparing delete: \(errmsg)")
            return
        }
        
        // Execute the delete statement
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error deleting record: \(errmsg)")
        } else {
            print("Successfully deleted record with ID: \(id)")
        }
        
        // Finalize the statement to release its resources
        sqlite3_finalize(stmt)
    }

    func update(obj: StudentModel) {
        // Ensure the database is open before attempting any operation
        if db == nil {
            SqlLiteManager.shared.openDatabase()
        }
        
        // SQL statement to update a student's record
        let updateQuery = "UPDATE Student SET Name = '\(obj.name)', Number = '\(Int32(obj.number))', Email = '\(obj.email)' WHERE id = '\(Int32(obj.id))';"
        
        var stmt: OpaquePointer?
        
        // Prepare the update statement
        if sqlite3_prepare_v2(db, updateQuery, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error preparing update: \(errmsg)")
            return
        }
        
        // Execute the update statement
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error updating record: \(errmsg)")
        } else {
            print("Successfully updated record with ID: \(obj.id)")
        }
        
        // Finalize the statement to release its resources
        sqlite3_finalize(stmt)
    }

}
