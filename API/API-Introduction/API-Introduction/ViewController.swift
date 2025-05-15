//
//  ViewController.swift
//  API-Introduction
//
//  Created by mac on 18/07/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Example JSON data
        let jsonData = """
        {
           "name": "John",
           "age": 30,
           "city": "New York"
        }
        """.data(using: .utf8)!
        
        // Parse the JSON data
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
        
            // Access the data as a dictionary
            if let dict = json as? [String: Any] {
                let name = dict["name"] as? String ?? ""
                let age = dict["age"] as? Int ?? 0
                let city = dict["city"] as? String ?? ""
                print("Name: \(name), Age: \(age), City: \(city)")
            }
        } catch {
            print("Error parsing JSON: \(error.localizedDescription)")
        }
    }


}

