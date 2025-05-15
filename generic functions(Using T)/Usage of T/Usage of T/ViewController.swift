//
//  ViewController.swift
//  Usage of T
//
//  Created by mac on 18/09/24.
//

// Key Differences:
/// Type Safety:-  Generic functions ensure type safety at compile-time, while Any does not.
/// Flexibility vs. Safety:- Generics give you flexibility with type safety, whereas Any provides maximum flexibility but sacrifices compile-time type checking.
/// Use Case:- Use generics when you want flexibility with type safety, and use Any when you need to handle values of various types without constraints but are okay with manual type casting.

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        example1()
        example2()
    }
    
    func example1(){
        // Generic function to swap two values
        func swapTwoValues<T>(a: inout T, b: inout T) {
            let temp = a
            a = b
            b = temp
        }
        // The inout keyword is used because we're modifying the original variables passed to the function.
        
        // Usage with Integers
        var number1 = 5
        var number2 = 10
        swapTwoValues(a: &number1, b: &number2)
        print("number1: \(number1), number2: \(number2)") // Output: number1: 10, number2: 5
        
        // Usage with Strings
        var string1 = "Hello"
        var string2 = "World"
        swapTwoValues(a: &string1, b: &string2)
        print("string1: \(string1), string2: \(string2)") // Output: string1: World, string2: Hello
    }
    
    func example2(){
        // Generic function with type constraint: T must conform to Comparable
        func findMax<T: Comparable>(a: T, b: T) -> T {
            return a > b ? a : b
        }
        
        // Usage with Integers
        let maxInt = findMax(a: 5, b: 10)
        print(maxInt)  // Output: 10
        
        // Usage with Strings
        let maxString = findMax(a: "Apple", b: "Banana")
        print(maxString)  // Output: Banana
        
    }
}
