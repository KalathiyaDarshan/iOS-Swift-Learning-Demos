//
//  ViewController.swift
//  LocalNotificationDemo
//
//  Created by mac on 16/09/24.
//

/// Here are the 5 steps to set up a local notification in iOS using Swift:
/*
 
    1. Request permission to send notifications using UNUserNotificationCenter.
    2. Create notification content with a title, body, and sound using UNMutableNotificationContent.
    3. Set a trigger to specify when the notification should be fired (e.g., time interval or calendar).
    4. Create a notification request using UNNotificationRequest with an identifier, content, and trigger.
    5. Add the notification request to the notification center using UNUserNotificationCenter.current().add(request).
 */

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Step 1: Request Notification Permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
               
                self.scheduleNotification()
                
                // schedule notification given time 
                self.dispatchNotification()
            } else {
                print("Notification permission denied.")
            }
        }
    }
    
    // Step 2: Schedule a local notification
    func scheduleNotification() {
        // Step 3: Create the content
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't forget to check the app!"
        content.sound = UNNotificationSound.default
        
        // Set badge number
        content.badge = NSNumber(value: 1) // This will set the badge number to 1
        
        // Step 4: Create a trigger (e.g., fire in 5 seconds)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // Step 5: Create a request with a unique identifier
        let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)
        
        // Step 6: Add the request to Notification Center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    func dispatchNotification(){
        let identifier = "my-morning-notification"
        let title = "Time to work out!"
        let body = "Don't be a lazy little butt"
        let hour = 5
        let minute = 43
        let isDaily = true
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.body = body
        content.sound = .default
        
        let calender = Calendar.current
        var dateComponents = DateComponents(calendar: calender, timeZone: TimeZone.current)
       
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
      
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
        }
    }

