//
//  ViewController.swift
//  CustomPlistDemo
//
//  Created by mac on 12/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writePlist()
        updatePlist()
        
        let success = deleteKey(fromPlist: "CustomData.plist", key: "Vegetables")
        if success {
            print("Key was deleted successfully.")
        } else {
            print("Failed to delete key.")
        }
        
        readPlist()
    }
    
    // if file not Ceated
    func writePlist(){
        
        // Sample data to write
        let dataToWrite: [String: [String]] = ["Fruits": ["Apple", "Banana", "Orange"], "Vegetables": ["Carrot", "Broccoli"]]
        
        // Get the path for the plist file in the Documents directory
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let plistURL = documentDirectory.appendingPathComponent("CustomData.plist")
            
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            
            do {
                let plistData = try encoder.encode(dataToWrite)
                try plistData.write(to: plistURL)
                print("Plist written successfully to \(plistURL)")
            } catch {
                print("Error writing to plist: \(error)")
            }
        }
    }
    
    func readPlist() {
        // Get the path for the plist file in the Documents directory
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let plistURL = documentDirectory.appendingPathComponent("CustomData.plist")
            
            // Check if the plist file exists
            if FileManager.default.fileExists(atPath: plistURL.path) {
                do {
                    let plistData = try Data(contentsOf: plistURL)
                    let decoder = PropertyListDecoder()
                    
                    // Decode the plist data back into a dictionary
                    let decodedData = try decoder.decode([String: [String]].self, from: plistData)
                    
                    // Print or use the decoded data
                    print("Plist data read successfully: \(decodedData)")
                } catch {
                    print("Error reading from plist: \(error)")
                }
            } else {
                print("Plist file does not exist at path: \(plistURL)")
            }
        }
    }

    func updatePlist() {
        // Get the path for the plist file in the Documents directory
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let plistURL = documentDirectory.appendingPathComponent("CustomData.plist")
            
            // Check if the plist file exists
            if FileManager.default.fileExists(atPath: plistURL.path) {
                do {
                    // Step 1: Read existing plist data
                    let plistData = try Data(contentsOf: plistURL)
                    let decoder = PropertyListDecoder()
                    var decodedData = try decoder.decode([String: [String]].self, from: plistData)
                    
                    // Step 2: Update the plist data (for example, adding a new fruit)
                    if var fruits = decodedData["Fruits"] {
                        fruits.append("Mango")  // Add a new fruit
                        decodedData["Fruits"] = fruits
                    } else {
                        decodedData["Fruits"] = ["Mango"]  // If the key doesn't exist, create it
                    }
                    
                    // Step 3: Write the updated data back to the plist
                    let encoder = PropertyListEncoder()
                    encoder.outputFormat = .xml
                    let updatedPlistData = try encoder.encode(decodedData)
                    try updatedPlistData.write(to: plistURL)
                    
                    print("Plist updated successfully.")
                } catch {
                    print("Error updating plist: \(error)")
                }
            } else {
                print("Plist file does not exist at path: \(plistURL)")
            }
        }
    }
    
    func deleteKey(fromPlist named: String, key: String) -> Bool {
        // Get the path for the plist file in the Documents directory
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let plistURL = documentDirectory.appendingPathComponent(named)
            
            // Check if the plist file exists
            if FileManager.default.fileExists(atPath: plistURL.path) {
                do {
                    // Read the plist data
                    let plistData = try Data(contentsOf: plistURL)
                    let decoder = PropertyListDecoder()
                    
                    // Decode the plist data into a dictionary
                    var decodedData = try decoder.decode([String: [String]].self, from: plistData)
                    
                    // Remove the key from the dictionary if it exists
                    if decodedData.keys.contains(key) {
                        decodedData.removeValue(forKey: key)
                        
                        // Write the updated data back to the plist
                        let encoder = PropertyListEncoder()
                        encoder.outputFormat = .xml
                        let updatedPlistData = try encoder.encode(decodedData)
                        try updatedPlistData.write(to: plistURL)
                        
                        print("Key '\(key)' deleted successfully.")
                        return true
                    } else {
                        print("Key '\(key)' does not exist.")
                        return false
                    }
                } catch {
                    print("Error reading, updating, or writing plist: \(error)")
                    return false
                }
            } else {
                print("Plist file does not exist at path: \(plistURL)")
                return false
            }
        }
        return false
    }

}

