//
//  ViewController.swift
//  RestRoam
//
//  Created by Franziska Kammerl on 5/1/19.
//  Copyright © 2019 Franziska Kammerl. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    var locationManager:CLLocationManager!
    var mapView:MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMapView()
        determineCurrentLocation()
    }
    
    func createMapView() {
        mapView = MKMapView()
        
        mapView?.frame = CGRect(x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height)

        mapView!.mapType = MKMapType.standard
        mapView!.isZoomEnabled = true
        mapView!.isScrollEnabled = true
        
        // Or, if needed, we can position map in the center of the view
        mapView!.center = view.center
        
        view!.addSubview(self.mapView!)
    }
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager!.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
        }
    }
}
