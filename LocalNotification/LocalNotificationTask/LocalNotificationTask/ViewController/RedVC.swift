//
//  RedVC.swift
//  LocalNotificationTask
//
//  Created by mac on 17/09/24.
//

import UIKit

class RedVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
    
    @IBAction func btnBlueButtonAction(_ sender: UIButton) {
        scheduleNotification(screen: .Blue)
    }
}
