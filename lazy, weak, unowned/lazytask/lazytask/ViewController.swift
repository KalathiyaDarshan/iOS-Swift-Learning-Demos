//
//  ViewController.swift
//  lazytask
//
//  Created by Mayur Mori on 09/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //weak unowned
        class Job {
            let title: String
            
            // A weak reference to a Person instance
            weak var person: Person?
            
            init(title: String) {
                self.title = title
                print("Job \(title) created")
            }
            
            deinit {
                print("Job \(title) destroyed")
            }
        }
        
        class Person {
            let name: String
            
            // A lazy property to initialize the job
            lazy var job: Job = Job(title: "Software Developer")
            
            // An unowned reference to the job
            unowned var unownedJob: Job
            
            init(name: String, job: Job) {
                self.name = name
                self.unownedJob = job
                print("Person \(name) created")
            }
            
            deinit {
                print("Person \(name) destroyed")
            }
        }
        
        // Creating instances
        var job = Job(title: "Manager") // Job instance
        var person = Person(name: "Alice", job: job) // Person instance
        
        // Assigning job to the person
        job.person = person
        
        job = Job(title: "Accountant") // Create a new job instance
        person = Person(name: "Bob", job: job) // Create a new person instance
        
        //lazy
        class Example {
            lazy var lazyProperty: String = {
                print("Lazy property initialized")
                return "Lazy Value"
            }()
            
            init() {
                print("Example instance created")
            }
            
            deinit {
                print("Example instance destroyed")
            }
        }
        
        // Creating an instance of Example
        var instance: Example? = Example()
        
        // Accessing the lazy property
        print(instance?.lazyProperty ?? "")
        
        var instance1: Example? = Example()
        print(instance1?.lazyProperty ?? "")
        
        
        // Deallocating the instance
        instance = nil
        
        
        
    }
    
    
}

