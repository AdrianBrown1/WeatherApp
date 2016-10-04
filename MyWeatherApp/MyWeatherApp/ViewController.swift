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
    var lat: String = ""
    var long: String = ""
    var weatherObjectsArray: [Weather] = []
    var weeklyWeatherObjectsArray: [WeeklyWeather] = []
    var weatherViews : [WeatherView] = []
    
    
    @IBOutlet weak var todayWeatherView: WeatherView!
    @IBOutlet weak var dayOneView: WeatherView!
    @IBOutlet weak var dayTwoView: WeatherView!
    @IBOutlet weak var dayThreeView: WeatherView!
    @IBOutlet weak var dayFourVew: WeatherView!
    @IBOutlet weak var dayFiveView: WeatherView!
    @IBOutlet weak var daySixView: WeatherView!
    @IBOutlet weak var daySevenView: WeatherView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // coreLoaction Setup
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        let location = locationManager.location
        let long = location?.coordinate.longitude
        let lat = location?.coordinate.latitude
        let strlat = String(format: "%.4f", lat!)
        let strlong = String(format: "%.4f",long!)
        self.lat = strlat
        self.long = strlong
        
        //Fetch Data
        DispatchQueue.global(qos: .background).async {
            
            WeatherDataStore.sharedDataStore.fetchweatherData(lat: self.lat, long: self.long) { (errorDescription) in
                
                self.weatherObjectsArray.append(contentsOf: WeatherDataStore.sharedDataStore.weatherArray)
                self.weeklyWeatherObjectsArray.append(contentsOf: WeatherDataStore.sharedDataStore.WeeklyWeatherArray)
                //today's weather information
                for weatherObject in self.weatherObjectsArray {
                    print(weatherObject.summary)
                    let todaysWeather = self.todayWeatherView
                    todaysWeather?.currentWeather = weatherObject
                }
                
                self.weatherViews.append(self.dayOneView)
                self.weatherViews.append(self.dayTwoView)
                self.weatherViews.append(self.dayThreeView)
                self.weatherViews.append(self.dayFourVew)
                self.weatherViews.append(self.dayFiveView)
                self.weatherViews.append(self.daySixView)
                self.weatherViews.append(self.daySevenView)
                // check on first object in array later
                self.weeklyWeatherObjectsArray.remove(at: 0)
                
                for (dayView, dayObject) in zip(self.weatherViews, self.weeklyWeatherObjectsArray) {
                    
                    let todaysView = dayView
                    todaysView.currentWeeklyWeather = dayObject
                }
    
            }
            
        }
       
    }
    
}
