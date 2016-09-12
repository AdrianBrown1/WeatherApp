//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Adrian Brown  on 8/24/16.
//  Copyright © 2016 Adrian Brown . All rights reserved.
//

import UIKit
import CoreLocation



class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    var todaysWeather: [Weather] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("I am doing something right now !!!")
        
//        // setting up coreLocation
//        locationManager = CLLocationManager()
//        locationManager.delegate = self;
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingLocation()
//        locationManager.requestWhenInUseAuthorization()
//    
        

        
        
        

    }
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        let userLocation: CLLocation = locationManager.location as CLLocation!
//        let long = userLocation.coordinate.longitude
//        let lat = userLocation.coordinate.latitude
//       
//        print(lat)
//        print(long)
//        
//        //locationManager.startUpdatingLocation()
//    }


}

