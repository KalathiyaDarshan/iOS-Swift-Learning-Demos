//
//  ViewController.swift
//  ThreadDemo
//
//  Created by mac on 19/09/24.
//

//Youtube Link :-
 ///Playlist Link :- https://youtube.com/playlist?list=PLWZIhpNhtvfoCeEuwPkNi43kTRgKgqqnP&si=Nt6ONHICF8peeFS2

/*
        Thread   Task
        Serial + Sync  - ORDER
        Serial + Async - ORDER
        Concurrent + Sync - ORDER
        Concurrent + ASync - UNORDER
 */

/*
 DispatchQueue Types:-
    1. Main Queue: A system-provided serial queue that runs on the main thread.
        Example:-
         DispatchQueue.main.async {
             // UI updates should be done here
         }
 
    2. Gloable Queuse: A set of global concurrent queues provided by the system, used for executing tasks in parallel.
 
        Quality of Service (QoS): These queues allow you to specify the priority of the tasks using the QoS levels
        types of Qos:
          1. .userInteractive: Priority: Highest
                - For tasks that need to be performed immediately to update the user interface these tasks must complete as quickly as posible
                - use of : animation,UI-Updating Calculations
 
          2. .userInitiated: Priority: High
                - Change UI Immediately
                - This queue should take a few seconds or less to complete task
                - simular to .userInteractive but Perfom Immediately
 
          3. .default and .unspecified: Priority: Mediam
                - General Processing task that are not time-critical
 
          4. .utility: Priority: Low
                - Long-Running compatations, I/O, networking or Continuous data feeds
                - Tasks can take a few second to a few minutes in this queue
 
          5. .background: Priority: Lowest
                - For tasks that the user is not directly aware of Where execution time can be Flexible
 
    3. Serial Queue (DispatchQueue(label:)) :
        - Use case: A custom serial queue that executes tasks in the order they are added, one at a time.
        - Example: Serial queues are useful when you need tasks to run in sequence without overlap.
                 let serialQueue = DispatchQueue(label: "com.example.serialQueue")
                 serialQueue.async {
                     // Task 1
                 }
                 serialQueue.async {
                     // Task 2
                 }
 
    4. Concurrent Queue (DispatchQueue(label:attributes:)):
        - Use case: A custom concurrent queue that allows multiple tasks to run in parallel.
        - Attributes: Specify the queue as concurrent using attributes: .concurrent.
        - Example:
            let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
             concurrentQueue.async {
                 // Task 1 (runs in parallel with Task 2)
             }
             concurrentQueue.async {
                 // Task 2 (runs in parallel with Task 1)
             }

 */

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queueTesting()

//        // Dispatch the background task to a background thread
//        DispatchQueue.global(qos: .background).async {
//            self.performBackgroundTask()
//
//          // When the background task is done, return to the main thread to update the UI
//            DispatchQueue.main.async {
//                print("Updating UI on main thread after background task.")
//            }
//        }
//
//        print("This is printed on the main thread.")
   }
    
    // Function that simulates a task running in the background
//    func performBackgroundTask() {
//        // Simulating a delay
//        print("Starting task in background thread...")
//        for i in 1...5 {
//            print("Background Task: \(i)")
//            Thread.sleep(forTimeInterval: 1) // Simulates work by sleeping the thread
//        }
//        print("Background task finished!")
//    }
    
    func queueTesting(){
        let myQueue = DispatchQueue(label: "swiftless.serial.queue", attributes: .concurrent)
        
        //One Thread
        myQueue.async {
            print("[\(self.currentTime())] Task 1 started")
            //Do some Work..
            for index in 1...3{
                print("[\(self.currentTime())] \(index) [Task-1] \(myQueue.label) ")
                Thread.sleep(forTimeInterval: 1) // Simulates work by sleeping the thread
            }
            print("[\(self.currentTime())] Task 1 finished")
        }
        
        //Second Thread
        myQueue.async {
            print("[\(self.currentTime())] Task 2 Started")
            //Do some Work..
            for index in 1...5{
                print("[\(self.currentTime())] \(index) [Task-2] time 5 is \(index * 5)")
            }
            print("[\(self.currentTime())] Task 2 finished")
        }
        
        myQueue.async {
            print("[\(self.currentTime())] Task 3 Started")
            //Do some Work..
            for index in 1...15{
                print("[\(self.currentTime())] \(index) [Task-3] time 5 is \(index * 5)")
            }
            print("[\(self.currentTime())] Task 3 finished")
        }
    }
    
    // Function to get the current time as a formatted string
    func currentTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SSS" // Hours, minutes, seconds, and milliseconds
        return dateFormatter.string(from: date)
    }
}

