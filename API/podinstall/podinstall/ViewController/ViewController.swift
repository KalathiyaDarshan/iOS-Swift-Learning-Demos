//
//  ViewController.swift
//  podinstall
//
//  Created by mac on 23/07/24.
//

// MARK: - Data Parsing Methods in Swift(Mapping)

// 1.JSONSerialization - A built-in class for converting between JSON data and Foundation objects. It provides a lower-level approach for parsing JSON.

// 2.Codable - A protocol that combines Encodable and Decodable, allowing for easy conversion between JSON (or other formats) and Swift objects. It's more type-safe and user-friendly compared to JSONSerialization.

// 3.XMLParse - A class for parsing XML data in Swift. It's used for reading and processing XML documents, usually through delegate methods.

// 4.SwiftyJSON - A third-party library that simplifies working with JSON data. It provides a more convenient API for extracting and handling JSON data compared to the built-in methods.

// 5.ObjectMapper - Another third-party library that offers flexible mapping of JSON data to Swift objects. It provides a different approach to data parsing compared to Codable and JSONSerialization.


import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiCall()
    }
    
    func apiCall() {
        
        let url = "https://api-dev-scus-demo.azurewebsites.net/api/User/RegisterUser"
        
        let objRegisterUser =  RegiseterUser.init(name: "darshan", email: "Darshan@gmail.com", password: "Darshan@123")
        
        let dataDictionary: [String: Any] = ["name": objRegisterUser.name, "email": objRegisterUser.email, "password": objRegisterUser.password]
        
        User.callRegisterUserAPI(url: url, method: .post, data: dataDictionary) { [self] result in
            switch result {
                
                case .success(let data) :
                    
                    self.simpleResponseApi(data: data)
                    self.jsonSerialization(data: data)
                    self.swiftyJson(data: data)
                    self.objectMapper(data: data)
                    
                case .failure(let error) :
                    print("Error: \(error)")
            }
        }
    }
    
    // MARK: - Simple Response JSON format
    func simpleResponseApi(data: Data) {
        
        print("Simple Response JSON format")
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Success: \(jsonString)")
        } else {
            print("Success: Data received but could not convert to string")
        }
    }
    
    // MARK: - Using JSONSerialization to convert data from JSON format to a model.
    func jsonSerialization(data: Data) {
        
        print("Using JSONSerialization to convert data from JSON format to a model.")
        
        do {
            // Convert JSON data to a Foundation object
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                // Deserialize the JSON object into the model
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
                
                let userResponse = try JSONDecoder().decode(APIResponse.self, from: jsonData)
                
                print("Success: \(userResponse)")
            } else {
                print("Success: Data received but could not convert to JSON object")
            }
        } catch {
            print("Failed to process JSON data: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Using a SwiftyJson to convert Data
    func swiftyJson(data:Data) {
        
        print("Using a SwiftyJson to convert Data")
        
        // Parse the JSON data using SwiftyJSON
        let json = JSON(data)
        
        // Check for errorMessage and data
        if let errorMessage = json["errorMessage"].string {
            print("Error Message: \(errorMessage)")
            
            // Manually map the "data" field to UserData
            if let dataJson = json["data"].dictionary {
                
                let userData = UserData(
                    name: dataJson["name"]?.string ?? "",
                    email: dataJson["email"]?.string ?? "",
                    id: dataJson["id"]?.string ?? "",
                    joining: dataJson["joining"]?.string ?? ""
                )
                
                // Create the APIResponse object
                let response = APIResponse(errorMessage: errorMessage, data: userData)
                
                // Access the parsed data
                print("Name: \(response.data.name)")
                print("Email: \(response.data.email)")
                print("ID: \(response.data.id)")
                print("Joining Date: \(response.data.joining)")
                
            } else {
                print("Error: 'data' field is missing or not a dictionary")
            }
             
        } else {
            print("Error: 'errorMessage' not found in JSON")
        }
    }
    
    // MARK: - Using a ObjectMapper to convert Data
    func objectMapper(data:Data) {
        
        print("Using a ObjectMapper to convert Data")
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                print("Failed to convert data to JSON")
                return
            }
        
        if let apiResponse = APIResponseMappable(JSON: json) {
                // Access the parsed data
          
                if let userData = apiResponse.data {
                    print("Name: \(userData.name)")
                    print("Email: \(userData.email)")
                    print("ID: \(userData.id)")
                    print("Joining: \(userData.joining)")
                }
            } else {
                print("Failed to map JSON to APIResponse model")
            }
    }
}

