//
//  ViewController.swift
//  LocalNotificationTask
//
//  Created by mac on 17/09/24.
//

import UIKit
import UserNotifications

class ViewController: BaseVC{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestNotificationPermission()
        
    }

    // Request notification permissions
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }

    func scheduleNotification(screen: screen) {
        
        let content = UNMutableNotificationContent()
        content.title = "New Notification"
        content.body = "Tap to open \(screen) screen"
        content.sound = UNNotificationSound.default
        content.userInfo = ["screen": "\(screen)"] // To identify the screen

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: "notificationId", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }

    @IBAction func btnRedButtonAction(_ sender: UIButton) {

        scheduleNotification(screen: .Red)
    }
    
    @IBAction func btnBlueButtonAction(_ sender: UIButton) {
        
        scheduleNotification(screen: .Blue)
    }
    
    @IBAction func btnGreenButtonAction(_ sender: UIButton) {
        
        scheduleNotification(screen: .Green)
    }
    
}

enum screen{
    case Red
    case Blue
    case Green
}

extension Notification.Name {
    static let myNotification = Notification.Name("MyNotification")
}
