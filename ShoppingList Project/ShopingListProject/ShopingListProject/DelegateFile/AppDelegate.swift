//
//  AppDelegate.swift
//  ShopingListProject
//
//  Created by mac on 18/06/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setRootViewController()
        
        return true
    }
    
    func setRootViewController() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
            
        // Determine the initial view controller based on the condition
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC: UIViewController
        if UserLocalData.needToSkipIntroScreen == false {
            rootVC = storyboard.instantiateViewController(identifier: "WalkScreenVC") as! WalkScreenVC
        } else {
            rootVC = storyboard.instantiateViewController(identifier: "ShopingListVC") as! ShopingListVC
        }
    
        // Create a navigation controller with the root view controller
        let navigationController = UINavigationController(rootViewController: rootVC)
        navigationController.navigationBar.isHidden = true // Hide navigation bar if not needed
            
        // Set the navigation controller as the root view controller of the window
        window?.rootViewController = navigationController
        
        // Make the window visible
        window?.makeKeyAndVisible()
    }
}
