//
//  APIStructure.swift
//  APIDemo
//
//  Created by mac on 19/07/24.
//

import Foundation
import UIKit

struct User {
    var navigationDelegate: NavigateDelegate?
       
    func callRegisterUserAPI(obj: Register) {
        
        if let urlRegisterUser = URL(string: "https://api-dev-scus-demo.azurewebsites.net/api/User/RegisterUser") {
            
            var urlReguest = URLRequest(url: urlRegisterUser)
            urlReguest.httpMethod = "post"
            
            let dataDictionary: [String: Any] = ["name": obj.name, "email": obj.email, "password": obj.password]
            
            do {
                
                let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
                urlReguest.httpBody = requestBody
                urlReguest.addValue("application/json", forHTTPHeaderField: "content-type")
                
            } catch let error {
                print(error.localizedDescription)
            }
            
            URLSession.shared.dataTask(with: urlReguest) { data, response, erorr in
                
                if let responseData = data {
                    
                    if let apiResponse = String(data: responseData, encoding: .utf8) {
                        print("apiResponse :: \(apiResponse)")
                        if let json = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any],
                           let errorMessage = json["errorMessage"] as? String, errorMessage == "" {
                            
                            navigationDelegate?.navigateAnotherScreen()
                        }
                    }
                }
            }.resume()
            
        }
    }
    
     func lognUser(obj: Login) {
       
        if let urlRegisterUser = URL(string: "https://www.profiles.blue/api/login") {
            
            var urlReguest = URLRequest(url: urlRegisterUser)
            urlReguest.httpMethod = "post"
            
            let dataDictionary: [String: Any] = ["flag": "login",
                                                 "email": obj.email,
                                                 "password": obj.password, "push_token":"qazxswedcvfrtbnhy8367qwesdffhjklftgvsfgjasdcv",
                                                 "device_type":"iPhone"
            ]
            
            do {
                
                let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
                urlReguest.httpBody = requestBody
                urlReguest.addValue("application/json", forHTTPHeaderField: "content-type")
                
            } catch let error {
                print(error.localizedDescription)
            }
            
            URLSession.shared.dataTask(with: urlReguest) { data, response, erorr in
                if let responseData = data {
                    
                    if let apiResponse = String(data: responseData, encoding: .utf8) {
                        print("apiResponse :: \(apiResponse)")
                        if let json = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any],
                           let status = json["status"] as? String, status == "Success" {
                            
                            navigationDelegate?.navigateAnotherScreen()
                        }else {
                            if let json = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any],
                                let message = json["msg"] as? String {
                                navigationDelegate?.alert?(message: message)
                            }
                        }
                    }
                }
            }.resume()
        }
     }
    
}

@objc protocol NavigateDelegate {
   func navigateAnotherScreen()
    @objc optional func alert(message: String)
}
