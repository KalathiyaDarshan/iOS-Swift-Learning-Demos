//
//  ViewController.swift
//  arrayFunction
//
//  Created by Mayur Mori on 14/05/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Array Example")
        var numbers: [Int] = [1, 2, 3, 4, 5]
        
        let sum = numbers.reduce(0,+)
        print("Reduce ",sum) //

        numbers.append(6)
        print("append 6 \(numbers)") //Single element add in last
        
        numbers.append(contentsOf: [7,8])
        print("append contentsOf \(numbers)")  // Multipall element add in last
        
        
        numbers.insert(0, at: 0)
        print("insert 0 \(numbers)")  // Add element in specific index
        
        numbers.insert(contentsOf: [9,10], at: 9) // multipal element add in specific index
        print("insert contentsOf \(numbers)")
        
        print(numbers.contains([9,110])) // return bool value
        
        print("dropFirs \(numbers.dropFirst(2))") // remove first side elements
        
        print("dropLast \(numbers.dropLast(2))") // remove last side elements
        
        print(numbers.min())
        
        numbers.remove(at: 10)
        print("remove \(numbers)") // remove specific element
        
        //numbers.removeAll()
        //print("Remove All \(numbers)") // remove all elements
        
        numbers.removeSubrange(2...4)
        print("removeSubrange ",numbers)
        
         numbers.reverse()
        print("Reverse Array",numbers)
        
        numbers.sort()
        print("Sort ",numbers)
        
        numbers.swapAt(0, 6)
        print("Swap ",numbers)
        
        print(numbers.allSatisfy{$0 is Int})
        print("filter ",numbers.filter{$0 is Int})
        
        print(numbers.map{ $0 + 2})
        

        numbers.forEach{ number in
              print("numbers ",number)
        }
        
        let arrayOfArrays = [[1, 2, 3], [4, 5], [6, 7, 8, 9]]
        
        let flattenedArray = arrayOfArrays.flatMap{$0}
        print("flat Map ",flattenedArray)

        var num = [1, 4, 5, nil, nil]
        print("Compact map ",num.compactMap { $0 }) // remove nil value

        var num1 = ["1", "4", "5", "One", "two"]
        print("Compact map ",num1.compactMap{Int($0)})
        
                var string: [String] = ["Hello", "my", "Name" , "is", "Darshan"]
        
        print(string.joined(separator: " ")) // join all array in a one string
        
        
    }


}

