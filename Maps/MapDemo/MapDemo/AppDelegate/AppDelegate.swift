//
//  AppDelegate.swift
//  MapDemo
//
//  Created by Darshan Kalathiya on 27/01/25.
//

import UIKit
import MapmyIndiaMaps
import MapmyIndiaAPIKit
import GoogleMaps
import TomTomSDKMapDisplay

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        GMSServices.provideAPIKey("AIzaSyAcnA4mL9vDVCruNdX-Xana7Y4FDCM7TGg")
        
        MapmyIndiaAccountManager.setMapSDKKey("52c7791636f511e877452195b48f412d")
        MapmyIndiaAccountManager.setRestAPIKey("52c7791636f511e877452195b48f412d")
        MapmyIndiaAccountManager.setAtlasClientId("96dHZVzsAuvbLVJsKMHLpVVXn8H-7hkLq_VdzTf2UKRkLVsqqqsojlnk3bGEzQf9mPCPmumdMfwRr6eWsTZeRw==")
        MapmyIndiaAccountManager.setAtlasClientSecret("lrFxI-iSEg_lW73_4z6v7rAQSN9IjXxobFumPvud0j6v-DWRXBrMei94ipKdIdNMMtZSXZY7nxs1L4IQPXsWNJ8qO6YGoqFw")
        
        //TomTom Map Key
        MapsDisplayService.apiKey = "joFncFDW6cfd0gPjaC50A8h19xL8YOIj"
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

