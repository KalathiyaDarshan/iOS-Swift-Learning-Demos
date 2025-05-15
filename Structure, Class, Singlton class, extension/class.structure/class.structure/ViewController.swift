//
//  ViewController.swift
//  class.structure
//
//  Created by Mayur Mori on 13/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //structure
        print("Structure")
        
        
        var man = persone()
        var man1 = man
        man.name = "darshan"
        man.details()
        man1.details()
        
        
        // Class
        print("Class")
        
        let man2 = persone1()
        let man3 = man2
        man2.name = "darshan"
        man2.details()
        man3.details()
        
    }
    
    
}

struct persone{
    var name: String = "fffdfhd"
    var age: Int = 23
    
    func details(){
        print("Name: \(name) Age: \(age)")
    }
}
class persone1{
    
    
    var name: String = "fffdfhd"
    var age: Int = 23
    
    func details(){
        print("Name: \(name) Age: \(age)")
    }
}


