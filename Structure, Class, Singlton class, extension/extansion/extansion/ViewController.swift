//
//  ViewController.swift
//  extansion
//
//  Created by Mayur Mori on 13/05/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let details = persone()
        details.printPersonName()
        details.newgeet()
    }

}
struct first{
    var name: String
    var age: Int
    var profession: String
    
    func greet() {
        print("Hello, my name is \(name). I am \(age) years old and work as a \(profession).")
    }
}
class persone{
    
    var person1 = first(name: "fddgfd", age: 20, profession: "Software Engineer")
    func printPersonName() {
        print(person1.name)
        person1.greet()
    }

}

extension persone{
    func newgeet(){
        person1.name = "darshan"
        person1.greet()
    }
}


