//
//  BluetoothManager.swift
//  BluetoothPermission
//
//  Created by Arjun Gahlot on 27/09/24.
//

import Foundation
import CoreBluetooth
import UIKit

class BluetoothManager: NSObject, CBCentralManagerDelegate {
    
    // Singleton instance
    static let shared = BluetoothManager()
    
    // Central Manager instance
    var centralManager: CBCentralManager!
    var permissionDelegate: PermissenProtocol?
    
    override init() {
        super.init()
        // Initialize the central manager
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    // MARK: - Check Bluetooth Permission
    func checkBluetoothPermission() -> CBManagerAuthorization {
        let authorizationStatus = CBManager.authorization
        
        switch authorizationStatus {
            case .allowedAlways:
                print("Bluetooth permission granted")
            case .restricted:
                print("Bluetooth access restricted")
            case .denied:
                print("Bluetooth permission denied")
            case .notDetermined:
                print("Bluetooth permission not determined")
            @unknown default:
                fatalError("Unknown Bluetooth authorization state")
        }
        
        return authorizationStatus
    }
    
    // MARK: - Check if Bluetooth is On or Off
    
    func checkBluetoothState() -> Bool {
        // Bluetooth state is determined in the centralManagerDidUpdateState method
        return centralManager.state == .poweredOn
    }
    
    // MARK: - CBCentralManagerDelegate Method
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .poweredOn:
                print("Bluetooth is ON")
            case .poweredOff:
                showBluetoothSettingsAlert()
                print("Bluetooth is OFF")
            case .unauthorized:
                print("Bluetooth is unauthorized")
                permissionDelegate?.asktoPermission()
            case .unsupported:
                print("Bluetooth is unsupported on this device")
            case .unknown:
                print("Bluetooth state is unknown")
            case .resetting:
                print("Bluetooth is resetting")
            @unknown default:
                fatalError()
        }
    }
    
    func showBluetoothUnauthorizedAlert() {
        DispatchQueue.main.async {
            if let topController = self.getTopViewController() {
                let alertController = UIAlertController(
                    title: "Bluetooth Access Required",
                    message: "This app requires Bluetooth access to function properly. Please enable Bluetooth permissions in Settings.",
                    preferredStyle: .alert
                )
                
                let settingsAction = UIAlertAction(title: "Go to Settings", style: .default) { _ in
                    // Open app settings
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                    }
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){_ in
                    self.showBluetoothUnauthorizedAlert()
                } // Removed recursion
                
                alertController.addAction(settingsAction)
                alertController.addAction(cancelAction)
                
                topController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func getTopViewController() -> UIViewController? {
        // Get the key window's root view controller and navigate to the top-most view controller
        if let windowScene = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first, let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            
            return getVisibleViewController(from: rootViewController)
        }
        return nil
    }
    
    func getVisibleViewController(from vc: UIViewController) -> UIViewController {
        if let presentedViewController = vc.presentedViewController {
            return getVisibleViewController(from: presentedViewController)
        }
        if let navigationController = vc as? UINavigationController {
            return getVisibleViewController(from: navigationController.visibleViewController ?? navigationController)
        }
        if let tabBarController = vc as? UITabBarController {
            return getVisibleViewController(from: tabBarController.selectedViewController ?? tabBarController)
        }
        return vc
    }
    
    func showBluetoothSettingsAlert() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(
                title: "Bluetooth is Off",
                message: "Please turn on Bluetooth to use this feature.",
                preferredStyle: .alert
            )
            
            let settingsAction = UIAlertAction(title: "Go to Settings", style: .default) { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){_ in
                self.showBluetoothSettingsAlert()
            } // Removed recursion
            
            alertController.addAction(settingsAction)
            alertController.addAction(cancelAction)
            
            if let topController = self.getTopViewController() {
                topController.present(alertController, animated: true, completion: nil)
            }
        }
    }

}

protocol PermissenProtocol{
   func asktoPermission()
}
