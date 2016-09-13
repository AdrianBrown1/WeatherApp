//
//  WeatherView.swift
//  MyWeatherApp
//
//  Created by Adrian Brown  on 9/3/16.
//  Copyright © 2016 Adrian Brown . All rights reserved.
//

import UIKit
import CoreLocation


class WeatherView: UIView, CLLocationManagerDelegate {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var locationManager: CLLocationManager!
    var todaysWeather: [Weather] = []
    var thisWeeksWeather: [WeeklyWeather] = []
    var lat: String = ""
    var long: String = ""
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    
    private func commonInit() {
        
        NSBundle.mainBundle().loadNibNamed("WeatherView", owner: self, options: [:])
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        contentView.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        contentView.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        contentView.rightAnchor.constraintEqualToAnchor(rightAnchor).active = true
        
        // setting up coreLocation
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()

        
    }
    

    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        
        let userLocation: CLLocation = locationManager.location as CLLocation!
        let strlat = String(format: "%.4f", userLocation.coordinate.latitude)
        let strlong = String(format: "%.4f",userLocation.coordinate.longitude)
        
        self.lat = strlat
        self.long = strlong
        
        updateWeather()
        locationManager.stopUpdatingLocation()
        
        
    }
    func updateWeather() {
        
        print(self.lat)
        print(self.long)
        
        WeatherDataStore.sharedDataStore.fetchWeatherData(self.lat, long: self.long) { (errorDescription) in
            print("back in the VC but not the normal one")
            print(WeatherDataStore.sharedDataStore.weatherArray.count)
            print(WeatherDataStore.sharedDataStore.weatherArray[0].summary)
            print(WeatherDataStore.sharedDataStore.WeeklyWeatherArray.count)
            print(WeatherDataStore.sharedDataStore.WeeklyWeatherArray[0].summary)
            let backroundQueue = NSOperationQueue()
            
            [backroundQueue .addOperationWithBlock({
                
                self.todaysWeather.append(WeatherDataStore.sharedDataStore.weatherArray[0])
                print(WeatherDataStore.sharedDataStore.WeeklyWeatherArray)
                
                var weatherObjects: [WeeklyWeather] = []
                
                weatherObjects.appendContentsOf(WeatherDataStore.sharedDataStore.WeeklyWeatherArray)
                
                
                NSOperationQueue .mainQueue() .addOperationWithBlock({
                    // update labels
                    
                })
                
            })]
        }
    }

}
