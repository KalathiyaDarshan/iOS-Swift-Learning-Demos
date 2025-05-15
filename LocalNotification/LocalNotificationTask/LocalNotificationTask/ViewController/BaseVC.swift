//
//  BaseVC.swift
//  LocalNotificationTask
//
//  Created by mac on 18/09/24.
//

import Foundation
import UIKit

class BaseVC: UIViewController{
    
    static let sharedInstance = BaseVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupNotificationObserver()
        
    }
    
    func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: .myNotification, object: nil)
    }
    
    // Handle the notification and update the label with received data
    @objc func handleNotification(_ notification: Notification) {
        
        if self.navigationController?.topViewController == self {
            // This view controller is the top view controller in the navigation stack
            print("This is the top view controller")
            
            if let userInfo = notification.userInfo, let receivedData = userInfo["Screen"] as? String {
                
                switch receivedData {
                    
                    case "Red":
                        
                        let nextVC = storyboard?.instantiateViewController(identifier: "RedVC") as! RedVC
                        navigationController?.pushViewController(nextVC, animated: true)
                        print(receivedData)
                        
                    case "Blue":
                        
                        let blueVC = storyboard?.instantiateViewController(identifier: "BlueVC") as! BlueVC
                        navigationController?.pushViewController(blueVC, animated: true)
                        print(receivedData)
                        
                    case "Green":
                        
                        let greenVc = storyboard?.instantiateViewController(identifier: "GreenVC") as! GreenVC
                        navigationController?.pushViewController(greenVc, animated: true)
                        print(receivedData)
                        
                    default:
                        print("Can not Find")
                }
            }
        } else {
            
            print("This is NOT the top view controller")
            return
        }
    }
    
    deinit {
        // Remove observer when the view controller is deallocated
        NotificationCenter.default.removeObserver(self, name: .myNotification, object: nil)
    }
}
