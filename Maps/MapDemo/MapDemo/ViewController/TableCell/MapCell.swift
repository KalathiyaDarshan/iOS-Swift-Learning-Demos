//
//  MapCell.swift
//  MapDemo
//
//  Created by Darshan Kalathiya on 27/01/25.
//
import UIKit
import MapKit
import MapmyIndiaMaps
import CoreLocation
import GoogleMaps
import MapboxMaps
import TomTomSDKMapDisplay
import WebKit

class MapCell: UITableViewCell {
    
    // ----------------------------------------------------------
    //                       MARK: - Outlet -
    // ----------------------------------------------------------
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnViewFullMap: UIButton!
    @IBOutlet weak var btnMyLocation: UIButton!
    
    // ----------------------------------------------------------
    //                       MARK: - Property -
    // ----------------------------------------------------------
    var locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    var mapType: MapType?
    var appleMapView: MKMapView?
    var googleMapView: GMSMapView?
    var mapMyIndiaView: MapmyIndiaMapView?
    var mapBoxView: MapBoxMapView?
    var webView: WKWebView!
    var tomTomMap = MapView()
    var olaMapView = UIView()
    var hasUpdatedLocation = false
    var buttonTappedCallback: ((MapType) -> Void)?
    var osmMapView: MKTileOverlay?

    // ----------------------------------------------------------
    //                       MARK: - awake Method -
    // ----------------------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLocationServices()
    }
    
    // ----------------------------------------------------------
    //                       MARK: - Function -
    // ----------------------------------------------------------
    func configure(with mapType: MapType) {
        self.mapType = mapType
        
        setupMapView()
        
        if let currentLocation = currentLocation {
            updateMapLocation(for: currentLocation)
        }
    }
    
    func setupMapView() {
        [appleMapView, googleMapView, mapMyIndiaView,olaMapView,mapBoxView,tomTomMap].forEach { $0?.removeFromSuperview() }
        
        var newMapView: UIView
        
        switch mapType {
            case .appleMap: 
                appleMapView = MKMapView()
                newMapView = appleMapView!
                
            case .googleMap:
                
                let options = GMSMapViewOptions()
                options.camera = GMSCameraPosition(latitude: 0.0, longitude: 0.0, zoom: 15.0)
                googleMapView = GMSMapView(options: options)
                newMapView = googleMapView!
                
            case .mapMyIndia:
                mapMyIndiaView = MapmyIndiaMapView()
                mapMyIndiaView?.userTrackingMode = .follow
                newMapView = mapMyIndiaView!
                
            case .mapBox:
                self.mapBoxView = MapBoxMapView(frame: mainView.bounds)
                self.mapBoxView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                newMapView = mapBoxView!
                
            case .openStret:
//                let overlay = MKTileOverlay(urlTemplate: //"https://tile.openstreetmap.org/{z}/{x}/{y}.png")
//                overlay.canReplaceMapContent = true
//                osmMapView?.addOverlay(overlay,level: .aboveRoads) //addOverlay(overlay, level: .aboveRoads)
//                newMapView = osmMapView!
                
                newMapView = UIView()
            case .tomTom:
                newMapView = tomTomMap
                
            case .hareMap:
                webView = WKWebView(frame: mainView.bounds)
                loadLocalHTML()
                newMapView = webView
            case .none:
                newMapView = UIView()
        }
        
        newMapView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.addSubview(newMapView)
        mainView.bringSubviewToFront(btnMyLocation)
        mainView.bringSubviewToFront(btnViewFullMap)
        
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
                    appleMapView?.showsUserLocation = true
                    
                case .googleMap:
                    googleMapView?.isMyLocationEnabled = true
                    
                case .mapMyIndia:
                    mapMyIndiaView?.showsUserLocation = true
                                        
                case .mapBox:
                    mapBoxView?.location.options.puckType = .puck2D()
                    
                case .openStret:
                    print("Openstrit map")
                
                case .tomTom:
                    tomTomMap.currentLocationButtonVisibilityPolicy = .hiddenWhenCentered
                    tomTomMap.map.cameraTrackingMode = .followRouteDirection()
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
                appleMapView?.setRegion(region, animated: true)
                
            case .googleMap:
                let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 13.0)
               // googleMapView?.settings.myLocationButton = true
                googleMapView?.animate(to: camera)
                
            case .mapMyIndia:
                mapMyIndiaView?.setCenter(coordinate, zoomLevel: 13.0, animated: true)

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
                print("None")
        }
    }
    
    
    func loadLocalHTML() {
        // Get the path of the HTML file
        if let filePath = Bundle.main.path(forResource: "map", ofType: "html") {
            let fileURL = URL(fileURLWithPath: filePath)
            let request = URLRequest(url: fileURL)
            webView.load(request)
        }
    }

    @IBAction func btnViewClick(_ sender: UIButton) {
        buttonTappedCallback?(mapType ?? .appleMap)
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
extension MapCell: CLLocationManagerDelegate {
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
