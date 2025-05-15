//
//  BeaconMnager.swift
//  BeaconIntegrationDemo
//
//  Created by Darshan Kalathiya on 13/12/24.


//MARK: -RSSI Range:
/*
 RSSI (Received Signal Strength Indicator) values are measured in decibels (dBm) and typically range from:
 
 0 dBm (strongest signal, closest to the beacon) to
 -100 dBm (weakest signal, farthest from the beacon).
 T
 ypical values you might encounter:
 -30 dBm to -50 dBm: Very close to the beacon.
 -60 dBm to -80 dBm: Moderate distance.
 -90 dBm and below: Weak signal, far from the beacon.
 */

/*
 RSSI Values for Proximity:
 Very Close (Immediate): RSSI around -30 dBm to -50 dBm
 This indicates the beacon is within a few centimeters to 1 meter of your device.
 
 Nearby (Near): RSSI around -51 dBm to -70 dBm
 This suggests the beacon is within 1 to 10 meters of your device.
 
 Far: RSSI around -71 dBm to -90 dBm
 Indicates the beacon is more than 10 meters away.
 
 Out of Range: RSSI below -90 dBm or no signal detected.
 
 The beacon is likely out of effective range or obscured by interference or obstacles.
 */

//MARK: -Major and Minor Ranges:
/*
 =  0 to 65,535.
 
 These values are typically used to:
 Major: Group beacons (e.g., beacons in a specific store or area).
 Minor: Distinguish individual beacons within a group.
 
 */
import CoreLocation
import UIKit

class BeaconManager:NSObject {
    
    static let shared = BeaconManager()
    private var locationManager = CLLocationManager()
    private var beaconConstraint: CLBeaconIdentityConstraint!
    private var targetUUID: UUID!
    private var beaconCheckTimer: Timer?
        
    var arrBeaconsRecordObj = [BeaconRecord]()
    var updateArray: (() -> Void)?
    var nearestBeacon: ((BeaconRecord) -> Void)?
    var oneBeaconObjUpdate: ((Int, BeaconRecord) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func beaconScanner(with uuid: UUID, major: CLBeaconMajorValue? = nil, minor: CLBeaconMinorValue? = nil) {
        self.targetUUID = uuid
        
        // Create the beacon constraint
        if let major = major, let minor = minor {
            beaconConstraint = CLBeaconIdentityConstraint(uuid: uuid, major: major, minor: minor)
        } else {
            beaconConstraint = CLBeaconIdentityConstraint(uuid: uuid)
        }
        
        // Start ranging beacons satisfying the constraint
        locationManager.startRangingBeacons(satisfying: beaconConstraint)
        
        print("Started ranging for beacons with UUID: \(uuid)")
    }
    
    // Location Manager Delegate Methods
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        setBeaconData(beacons: beacons)
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Started monitoring for region: \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered beacon region: \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited beacon region: \(region.identifier)")
    }
    
    private func setBeaconData(beacons: [CLBeacon]) {
        
        for beacon in beacons {
            // Check if the beacon is already in the array
            if let existingBeaconIndex = self.arrBeaconsRecordObj.firstIndex(where: {
                $0.minor == beacon.minor &&
                $0.major == beacon.major &&
                $0.uuid == beacon.uuid
            }){
                self.updateOldValue(index: existingBeaconIndex,beacon: beacon)
            } else {
                self.addNewValue(beacon: beacon)
            }
        }
        
        // Find the beacon to display (the closest one or the last added if only one)
        if let beaconToDisplay = self.arrBeaconsRecordObj.min(by: { $0.distance < $1.distance }), self.arrBeaconsRecordObj.count > 1{
            self.nearestBeacon?(beaconToDisplay)
        }

            //if beacon is out range
            self.checkAndRemoveOldRecords()
    }
    
    private func updateOldValue(index: Int,beacon: CLBeacon) {
        let existingBeaconObj = self.arrBeaconsRecordObj[index]
        
        existingBeaconObj.updateRSSI(rssi: beacon.rssi,timeStamp: beacon.timestamp)
        
        print("Minor: \(beacon.minor), beacon rssi: \(beacon.rssi) kalmanFilterRssi: \(existingBeaconObj.kalmanFilterRSSI) AverageRSSI: \(existingBeaconObj.averageRSSI)")
        
        // Update the array with the modified beacon object
        self.arrBeaconsRecordObj[index] = existingBeaconObj
        
        //print("arr average: ", self.arrBeaconsRecordObj[index].arrKalmanFilterRSSI)
        print("average RSSI: \(existingBeaconObj.averageRSSI), distance: \(existingBeaconObj.distance)")
        print("===========================================")
                
        self.oneBeaconObjUpdate?(index,existingBeaconObj)
        
    }
    
    private func addNewValue(beacon: CLBeacon) {
        // Add the new beacon to the array
        let objBeaconRecord = BeaconRecord(
            rssi: beacon.rssi,
            uuid: beacon.uuid,
            major: beacon.major,
            minor: beacon.minor,
            timeStamp: Date()
        )
        self.arrBeaconsRecordObj.append(objBeaconRecord)
        self.arrBeaconsRecordObj.reverse()
        
        updateArray?()
    }
    
   private func checkAndRemoveOldRecords() {
        // Schedule the timer if it isn't already running
        if beaconCheckTimer == nil {
            beaconCheckTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                
                // Get the current time dynamically within the timer block
                let currentTime = Date()
                
                // Store the count of records before removal
                let initialRecordCount = self.arrBeaconsRecordObj.count
                
                // Remove records older than 2 seconds
                self.arrBeaconsRecordObj.removeAll { record in
                    return currentTime.timeIntervalSince(record.timeStamp) > 2
                }
                
                // Check if any record was deleted
                if self.arrBeaconsRecordObj.count != initialRecordCount {
                    self.updateArray?()
                }
                
                // Invalidate the timer if the array becomes empty
                if self.arrBeaconsRecordObj.isEmpty {
                    self.beaconCheckTimer?.invalidate()
                    self.beaconCheckTimer = nil
                }
            }
        }
    }
    
    // Helper Function to Get the Topmost View Controller
    private func getTopViewController(base: UIViewController? = nil) -> UIViewController? {
        let baseViewController = base ?? UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .filter { $0.isKeyWindow }
            .first?.rootViewController
        
        if let navController = baseViewController as? UINavigationController {
            return getTopViewController(base: navController.visibleViewController)
        } else if let tabController = baseViewController as? UITabBarController {
            return getTopViewController(base: tabController.selectedViewController)
        } else if let presented = baseViewController?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return baseViewController
    }
}

extension BeaconManager : CLLocationManagerDelegate {
    
    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .notDetermined:
                // User hasn't decided yet
                print("Authorization status: Not Determined")
            case .restricted:
                // Parental controls or restrictions prevent location services
                print("Authorization status: Restricted")
            case .denied:
                // User explicitly denied permission or cancelled the prompt
                print("Authorization status: Denied")
                handleDeniedPermission()
                
            case .authorizedWhenInUse, .authorizedAlways:
                // User granted permission
                print("Authorization status: Authorized")
            @unknown default:
                // Handle unexpected cases
                print("Authorization status: Unknown")
        }
    }
    
    func handleDeniedPermission() {
        // Show an alert to inform the user about the importance of location access
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Location Access Denied",
                message: "Please enable location services in Settings to use this feature.",
                preferredStyle: .alert
            )
            
            // Add the "Open Settings" button
            alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
                if let bundleId = Bundle.main.bundleIdentifier,
                   let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)"){
                    UIApplication.shared.open(url,options: [:], completionHandler: nil)
                }
            })
            
            // Add the "Cancel" button
            alert.addAction(UIAlertAction(title: "Cancel", style: .default){ _ in
                self.handleDeniedPermission()
            })
            
            // Present the alert from the currently active window scene
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(alert, animated: true)
            }
        }
    }
}
