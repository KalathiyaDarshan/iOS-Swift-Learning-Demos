//
//  ViewController.swift
//  BluetoothPermission
//
//  Created by Arjun Gahlot on 27/09/24.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
    let bluetoothManager = BluetoothManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // First, check if Bluetooth is powered on
        if bluetoothManager.centralManager.state == .poweredOn {
            print("Bluetooth is ON")
            
            // Now check for Bluetooth permission
            let permissionStatus = bluetoothManager.checkBluetoothPermission()
            bluetoothManager.permissionDelegate = self
            
            if permissionStatus == .allowedAlways {
                // Permission is granted, proceed with your Bluetooth operations
                print("Bluetooth permission granted")
            } else {
                // Permission is not granted, request permission
                print("Ask to grant Bluetooth Permission")
            }
            
        } else if bluetoothManager.centralManager.state == .poweredOff {
            print("Bluetooth is OFF")
            bluetoothManager.showBluetoothSettingsAlert()
        } else if bluetoothManager.centralManager.state == .unsupported {
            print("Bluetooth is unsupported on this device")
        } else {
            print("Bluetooth state is unknown or resetting")
        }
        
    }
}

extension ViewController: PermissenProtocol {
    func asktoPermission() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.bluetoothManager.showBluetoothUnauthorizedAlert()
        }
    }
}
