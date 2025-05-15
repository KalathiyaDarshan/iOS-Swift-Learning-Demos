//
//  ViewController.swift
//  OOPSPolymorphism
//
//  Created by mac on 30/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    let objChild = Child()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Polymorphism = overrloading,overriding
        objChild.add()
        add(a: 10, b: 20)
        add(a: 10, b: 20, c: 30)
    }
    
    //Overrloading
    func add(a: Int, b: Int) {
        let sum = a + b
        print("Overrloading Sum of A and B:", sum)
    }
    
    func add(a: Int, b: Int, c: Int) {
        let sum = a + b + c
        print("Overrloading Sum of A, B, and C:", sum)
    }
}

//override
class  Perrent {
    
    func add() {
        let a = 10
        let b = 20
        let c = a + b
        print("sum of A and B",c)
    }
}

class Child: Perrent {
    
    override func add() {
        let a = 10
        let b = 20
        let c = 30
        let d = a + b + c
        print("Override Sum Of A,B And C",d)
    }
}

