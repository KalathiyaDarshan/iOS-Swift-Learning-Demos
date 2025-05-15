//
//  ViewController.swift
//  OlaMap
//
//  Created by Darshan Kalathiya on 03/02/25.
//

import UIKit
import CoreLocation
import OlaMapCore

let olaMap = OlaMapService(
    auth: .apiKey(key: "YUN1flm0FcrpEwrGha9PTg5YeDrDG06e8Upv6xdM"),
    tileURL: URL(string: "https://api.olamaps.io/tiles/vector/v1/styles/default-light-standard/style.json")!,
    projectId: "a3c9c91f-34ae-4446-a796-7f4bbaada39c"
)


class ViewController: UIViewController {

    
    @IBOutlet weak var mainView: UIView!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var locationManager = CLLocationManager()
    var hasUpdatedLocation = false
    var currentLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // configureLocationServices()
        
        olaMap.loadMap(onView: self.mainView)
        olaMap.addCurrentLocationButton(self.mainView)
        olaMap.setCurrentLocationMarkerColor(UIColor.systemBlue)
        olaMap.setDebugLogs(true)
        olaMap.setRotatingGesture(true)
        olaMap.setMaxZoomLevel(16.0)
    }

   
}

// ----------------------------------------------------------
//                       MARK: - CLLocationManager Delegate -
// ----------------------------------------------------------
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        currentLocation = userLocation.coordinate
        
        if !hasUpdatedLocation {
           // updateMapLocation(for: userLocation.coordinate)
            hasUpdatedLocation = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .authorizedWhenInUse, .authorizedAlways:
               // startLocationUpdates()
                print("")
            case .denied, .restricted:
                print("Location access denied")
            default:
                break
        }
    }
}
