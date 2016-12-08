//
//  setUpViewController.swift
//  MyWeatherApp
//
//  Created by Adrian Brown  on 11/10/16.
//  Copyright © 2016 Adrian Brown . All rights reserved.
//

import UIKit
import CoreLocation

class setUpViewController: UIViewController, CLLocationManagerDelegate {
    
      var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        

        


     
    }
    @IBAction func buttonTapped(_ sender: AnyObject) {
        
        // coreLoaction Setup
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
