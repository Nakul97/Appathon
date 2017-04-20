//
//  MapsViewController.swift
//  AppathonAPP
//
//  Created by Nakul on 05/03/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapsViewController: UIViewController,CLLocationManagerDelegate {
    
    // You don't need to modify the default init(nibName:bundle:) method.
    
    let userLocation:CLLocation! = nil
    let long = 0.0
    let lat = 0.0
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
       
      
        let locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        let camera = GMSCameraPosition.camera(withLatitude: 12.9693, longitude: 79.1559, zoom: 14.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 12.9693, longitude: 79.1559)
        marker.title = "Vellore"
        marker.snippet = "India"
        marker.map = mapView
        // Creates a marker in the center of the map.
        
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        
        let userLocation:CLLocation = locations[0] as! CLLocation
        let long = userLocation.coordinate.longitude;
        let lat = userLocation.coordinate.latitude;
   

        //Do What ever you want with it
    }
}
