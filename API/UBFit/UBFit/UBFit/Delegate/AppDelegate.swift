//
//  AppDelegate.swift
//  UBFit
//
//  Created by mac on 31/07/24.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.previousNextDisplayMode = .default
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        setRootViewController()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func setRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC: UIViewController
        
        // Check user ID and instantiate appropriate view controller
        if UserLocalData.saveUserId == "" {
            // Safely instantiate LoginVC
            rootVC = storyboard.instantiateViewController(identifier: "LoginVC") as? LoginVC ?? UIViewController()
        } else {
            // Safely instantiate NewsfeedVC
            rootVC = storyboard.instantiateViewController(identifier: "NewsfeedVC") as? NewsfeedVC ?? UIViewController()
        }
        
        // Embed rootVC in a navigation controller
        let navigationController = UINavigationController(rootViewController: rootVC)
        navigationController.navigationBar.isHidden = true // Hide the navigation bar
        
        // Set the root view controller and make the window visible
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}

