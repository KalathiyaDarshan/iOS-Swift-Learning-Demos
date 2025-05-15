//
//  ViewController.swift
//  dictionaryFunction
//
//  Created by mac on 14/05/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let Dictionary = ["a": 1,"b": 2, "c": 3,"d":4,"e":5]
        
        print(Dictionary.mapValues{$0 * 2})
       
        let Dictionary1 = ["a": 1,"b": 2, "c": 3,"d":4,"e":5,"f" :nil]
        print(Dictionary1.compactMapValues{$0})
        
        var Dictionary2 = ["a": 1,"b": 2, "c": 3,"d": 4]
        let sum = Dictionary2.reduce(0) {$0 + $1.value}
        print(sum)
        print(Dictionary)
        print(Dictionary.contains{$0.key == "a"})
        print(Dictionary.contains{$0.value == 5})
        
        Dictionary.forEach{key, value in
                           print("Key: \(key), Value: \(value)")
        }
        
        for (index, key_value) in Dictionary.enumerated() {
           print("\(index): \(key_value)")
        }
        
        print(Dictionary.filter({ $0.value is Int }))
        
        Dictionary2.updateValue(6, forKey: "e")
        print(Dictionary2)
    }


}

