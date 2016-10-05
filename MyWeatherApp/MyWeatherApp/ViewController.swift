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
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
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
        
        //Views
        self.todayWeatherView.layer.cornerRadius = 10
        self.todayWeatherView.layer.masksToBounds = true
        self.todayWeatherView.layer.borderColor = UIColor.gray.cgColor
        self.todayWeatherView.layer.borderWidth = 0
        self.todayWeatherView.layer.contentsScale = UIScreen.main.scale
        self.todayWeatherView.layer.shadowColor = UIColor.black.cgColor
        self.todayWeatherView.layer.shadowOffset = CGSize.zero
        self.todayWeatherView.layer.shadowRadius = 5.0
        self.todayWeatherView.layer.shadowOpacity = 0.5
        self.todayWeatherView.layer.masksToBounds = false
        self.todayWeatherView.clipsToBounds = false
        self.todayWeatherView.backgroundColor = .clear
        
        // Add views to Array of Views
        self.weatherViews.append(self.dayOneView)
        self.weatherViews.append(self.dayTwoView)
        self.weatherViews.append(self.dayThreeView)
        self.weatherViews.append(self.dayFourVew)
        self.weatherViews.append(self.dayFiveView)
        self.weatherViews.append(self.daySixView)
        self.weatherViews.append(self.daySevenView)

        for view in self.weatherViews {
            
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            view.layer.borderColor = UIColor.gray.cgColor
            view.layer.borderWidth = 0
            view.layer.contentsScale = UIScreen.main.scale
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize.zero
            view.layer.shadowRadius = 5.0
            view.layer.shadowOpacity = 0.5
            view.layer.masksToBounds = false
            view.clipsToBounds = false
            view.backgroundColor = .clear
        }
        
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
                    
//                    if todaysWeather?.currentWeather.icon == "Clear" {
//                        self.backgroundImage.image = UIImage(named: "temp-background-image.jpg")
//                        
//                    }
                    self.backgroundImage.image = UIImage(named: "temp-background-image.jpg")

                    
                }

                // check on first object in array later
                self.weeklyWeatherObjectsArray.remove(at: 0)
                
                for (dayView, dayObject) in zip(self.weatherViews, self.weeklyWeatherObjectsArray) {
                    
                    let todaysView = dayView
                    todaysView.currentWeeklyWeather = dayObject
                }
    
            }
        }
    
    }
    // This function will set the background image to match Weather 
    func setbackgroundImage(icon: String) {
        let weathertypes = ["clear-day", "clear-night", "rain", "snow", "sleet", "wind", "fog", "cloudy", "partly-cloudy-day", "partly-cloudy-night"]
        
        for type in weathertypes {
            if type == icon {
                
            }
        }
    }
    
}
