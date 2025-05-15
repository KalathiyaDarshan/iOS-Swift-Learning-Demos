//
//  AppDelegate.swift
//  LocalNotificationTask
//
//  Created by mac on 17/09/24.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        
        setRootViewController()
        
        return true
    }
    
    func setRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Safely instantiate NewsfeedVC
        let rootVC = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController
        
        // Embed rootVC in a navigation controller
        let navigationController = UINavigationController(rootViewController: rootVC)
        // navigationController.navigationBar.isHidden = true // Hide the navigation bar
        
        // Set the root view controller and make the window visible
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    // This method will be called when the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    // This method will be called when the notification is clicked
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        if let screen = userInfo["screen"] as? String {
            let userDetails: [String: Any] = ["Screen": screen]
            
            DispatchQueue.main.async {
                
                NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: userDetails)
            }
        }
        completionHandler()
    }
}

/*
 if let viewController = viewController {
 
 // Ensure that the root view controller is a navigation controller
 if let navigationController = window?.rootViewController as? UINavigationController {
 navigationController.pushViewController(viewController, animated: true)
 } else {
 // Handle case when there's no navigation controller
 let navigationController = UINavigationController(rootViewController: viewController)
 window?.rootViewController = navigationController
 }
 }
 */

