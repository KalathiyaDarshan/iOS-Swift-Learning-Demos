//
//  ViewController.swift
//  dictionary
//
//  Created by Mayur Mori on 09/05/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dictionary
        print("dictionary Example")
        // Creating a dictionary with some initial key-value pairs
        var fruits: [String: String] = ["apple": "red", "banana": "yellow", "orange": "orange"]
        
        // Adding a new key-value pair to the dictionary
        fruits["grape"] = "purple"
        
        // Removing a key-value pair from the dictionary
        fruits.removeValue(forKey: "banana")
        
        // Accessing a value using a key
        if let color = fruits["apple"] {
            print("The color of an apple is \(color)")
        } else {
            print("Apple not found")
        }
        
        // Iterating over key-value pairs in the dictionary
        for (fruit, color) in fruits {
            print("The color of \(fruit) is \(color)")
        }
        
        //Array
        // Creating an array with some initial elements
        print("Array Example")
        var numbers: [Int] = [1, 2, 3, 4, 5]
        
        // Appending elements to the array
        numbers.append(6)
        numbers.append(contentsOf: [7, 8])
        numbers.insert(0, at: 0)
        
        // Removing an element from the array
            numbers.remove(at: 3)
        
        // Accessing elements by index
        if let firstElement = numbers.first {
            print("The first element is \(firstElement)")
        } else {
            print("Array is empty")
        }
        
    
        
        // Iterating over elements in the array
        for number in numbers {
            print(number)
        }
        
        //set
        print("Set Example")
        // Creating a set of integers
        var numbers1: Set<Int> = [1, 2, 3, 4,5]
        
        // Adding elements to the set
        numbers1.insert(6)
        numbers1.insert(7) // Adding another element
        
        // Removing an element from the set
        numbers1.remove(3)
        
        // Checking if an element exists in the set
        if numbers1.contains(5) {
            print("The set contains the number 5")
        } else {
            print("The set does not contain the number 5")
        }
        
        // Iterating over elements in the set
        for number in numbers1 {
            print(number)
        }

        //tuple
        print("tuple Example")
        // Defining a tuple to store information about a person
        let person: (name: String, age: Int, gender: String) = ("John", 30, "Male")
        
        // Accessing elements of the tuple
        print("Name: \(person.name)")
        print("Age: \(person.age)")
        print("Gender: \(person.gender)")

        //enum
        print("Enum Example")
        // Define an enum to represent different types of fruits
        enum Fruit {
            case apple
            case banana
            case orange
        }
        
        // Define a function to describe a fruit
        func describeFruit(_ fruit: Fruit) -> String {
            switch fruit {
                case .apple:
                    return "This is an apple."
                case .banana:
                    return "This is a banana."
                case .orange:
                    return "This is an orange."
            }
        }
        
        // Using the enum and the function
        let apple = Fruit.apple
        let banana = Fruit.banana
        let orange = Fruit.orange
        
        print(describeFruit(apple))   // Output: This is an apple.
        print(describeFruit(banana))  // Output: This is a banana.
        print(describeFruit(orange))  // Output: This is an orange.


    }


}

