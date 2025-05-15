//
//  MapVC.swift
//  MapDemo
//
//  Created by Darshan Kalathiya on 27/01/25.
//

import UIKit
import MapKit
import MapmyIndiaAPIKit
import MapmyIndiaMaps
import CoreLocation
import GoogleMaps
import MapboxMaps
import TomTomSDKMapDisplay
import WebKit

class MapVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnMyLocation: UIButton!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var locationManager = CLLocationManager()
    var mapView: MKMapView?
    var currentLocation: CLLocationCoordinate2D?
    var googleMapView: GMSMapView?
    var mapMyIndiaView: MapmyIndiaMapView?
    var olaMapView = UIView()
    var webView: WKWebView!
    var mapBoxView: MapBoxMapView?
    var tomTomMap = MapView()
    var hasUpdatedLocation = false
    var mapType : MapType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = mapType?.rawValue
        
        configureLocationServices()
        setupMapView(mapType:mapType ?? .appleMap)
    }
    
    func loadLocalHTML() {
        // Get the path of the HTML file
        if let filePath = Bundle.main.path(forResource: "map", ofType: "html") {
            let fileURL = URL(fileURLWithPath: filePath)
            let request = URLRequest(url: fileURL)
            webView.load(request)
        }
    }

    func setupMapView(mapType: MapType) {
        [mapView, googleMapView, mapMyIndiaView,olaMapView,mapBoxView,tomTomMap].forEach { $0?.removeFromSuperview() }
        
        var newMapView: UIView
        
        switch mapType {
            case .appleMap:
                mapView = MKMapView()
                newMapView = mapView!
                
            case .googleMap:
                
                let options = GMSMapViewOptions()
                options.camera = GMSCameraPosition(latitude: 0.0, longitude: 0.0, zoom: 15.0)
                googleMapView = GMSMapView(options: options)
                newMapView = googleMapView!
                
            case .mapMyIndia:
                mapMyIndiaView = MapmyIndiaMapView()
                guard let mapMyIndiaView = mapMyIndiaView else { return }
                newMapView = mapMyIndiaView
                
            case .mapBox:
                self.mapBoxView = MapBoxMapView(frame: mainView.bounds)
                self.mapBoxView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                newMapView = mapBoxView!
                
            case .openStret:
                newMapView = UIView()
                
            case .tomTom:
                btnMyLocation.isHidden = true
                newMapView = tomTomMap
                
            case .hareMap:
                webView = WKWebView(frame: mainView.bounds)
                loadLocalHTML()
                newMapView = webView
                
        }
        
        newMapView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(newMapView)
        mainView.bringSubviewToFront(btnMyLocation)
        
        NSLayoutConstraint.activate([
            newMapView.topAnchor.constraint(equalTo: mainView.topAnchor),
            newMapView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            newMapView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            newMapView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
        ])
        
        btnMyLocation.isHidden = (mapType == .tomTom || mapType == .hareMap)
        startLocationUpdates()
    }
    
    func configureLocationServices() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        let status = locationManager.authorizationStatus
        
        switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                startLocationUpdates()
            case .denied, .restricted:
                print("Location access denied")
            @unknown default:
                break
        }
    }
    
    func startLocationUpdates() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            
            switch mapType {
                case .appleMap:
                    mapView?.showsUserLocation = true
                case .googleMap:
                    googleMapView?.isMyLocationEnabled = true
                case .mapMyIndia:
                    mapMyIndiaView?.showsUserLocation = true
                case .mapBox:
                    // By default, the built-in 2D puck doesn't show the user's heading.
                    mapBoxView?.location.options.puckType = .puck2D()
                case .openStret:
                    print("Openstrit map")
                    
                case .tomTom:
                    tomTomMap.map.cameraTrackingMode = .followRouteDirection()
                    tomTomMap.currentLocationButtonVisibilityPolicy = .hiddenWhenCentered
                    
                case .hareMap:
                    print("Hare Map")
                case .none:
                    print("None")
            }
        }
    }
    
    func updateMapLocation(for coordinate: CLLocationCoordinate2D) {
        switch mapType {
            case .appleMap:
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                mapView?.setRegion(region, animated: true)
                
            case .googleMap:
                let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 19.0)
                //  googleMapView?.settings.myLocationButton = true
                googleMapView?.settings.compassButton = true
                googleMapView?.animate(to: camera)
                
            case .mapMyIndia:
                mapMyIndiaView?.allowsScrolling = false
                mapMyIndiaView?.automaticallyAdjustsContentInset = true
                mapMyIndiaView?.setCenter(coordinate, zoomLevel: 18.0, animated: true)
                
            case .mapBox:
                let cameraOptions = CameraOptions(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude),zoom: 13, bearing: 0, pitch: 0)
                mapBoxView?.mapboxMap.setCamera(to: cameraOptions)
                
            case .openStret:
                print("OpenStreet Map")
                
            case .tomTom:
                print("Tom Tom Map")
                
            case .hareMap:
                print("Hare Map")
            case .none:
                print("none")
        }
    }
    
    @IBAction func btnMyLocationClick(_ sender: UIButton) {
        if let currentLocation = currentLocation {
            updateMapLocation(for: currentLocation)
        }
    }
}


// ----------------------------------------------------------
//                       MARK: - CLLocationManager Delegate -
// ----------------------------------------------------------
extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        currentLocation = userLocation.coordinate
        
        if !hasUpdatedLocation {
            updateMapLocation(for: userLocation.coordinate)
            hasUpdatedLocation = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                startLocationUpdates()
            case .denied, .restricted:
                print("Location access denied")
            default:
                break
        }
    }
}
