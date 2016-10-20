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
    //WeatherViews
    @IBOutlet weak var todayWeatherView: WeatherView!
    @IBOutlet weak var dayOneView: WeatherView!
    @IBOutlet weak var dayTwoView: WeatherView!
    @IBOutlet weak var dayThreeView: WeatherView!
    @IBOutlet weak var dayFourVew: WeatherView!
    @IBOutlet weak var dayFiveView: WeatherView!
    @IBOutlet weak var daySixView: WeatherView!
    @IBOutlet weak var daySevenView: WeatherView!
    
    //BottomWeatherViews 
    @IBOutlet weak var todayBottomView: BottomWeatherView!
    @IBOutlet weak var dayOneBottomView: BottomWeatherView!
    @IBOutlet weak var dayTwoBottomView: BottomWeatherView!
    @IBOutlet weak var dayThreeBottomView: BottomWeatherView!
    @IBOutlet weak var dayFourBottomView: BottomWeatherView!
    @IBOutlet weak var dayFiveBottomView: BottomWeatherView!
    @IBOutlet weak var daySixBottomView: BottomWeatherView!
    @IBOutlet weak var daySevenBottomVew: BottomWeatherView!
    var bottomWeatherViews: [BottomWeatherView] = []

    //background Image
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
        
        
        //View Cards
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
        
        // Add view cards to Array of Views
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
        // Bottom view added to array
        self.bottomWeatherViews.append(self.dayOneBottomView)
        self.bottomWeatherViews.append(self.dayTwoBottomView)
        self.bottomWeatherViews.append(self.dayThreeBottomView)
        self.bottomWeatherViews.append(self.dayFourBottomView)
        self.bottomWeatherViews.append(self.dayFiveBottomView)
        self.bottomWeatherViews.append(self.daySixBottomView)
        self.bottomWeatherViews.append(self.daySevenBottomVew)
    
        //bottom view design change
        for view in self.bottomWeatherViews {
            
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
        
        self.todayBottomView.layer.cornerRadius = 10
        self.todayBottomView.layer.masksToBounds = true
        self.todayBottomView.layer.borderColor = UIColor.gray.cgColor
        self.todayBottomView.layer.borderWidth = 0
        self.todayBottomView.layer.contentsScale = UIScreen.main.scale
        self.todayBottomView.layer.shadowColor = UIColor.black.cgColor
        self.todayBottomView.layer.shadowOffset = CGSize.zero
        self.todayBottomView.layer.shadowRadius = 5.0
        self.todayBottomView.layer.shadowOpacity = 0.5
        self.todayBottomView.layer.masksToBounds = false
        self.todayBottomView.clipsToBounds = false
        self.todayBottomView.backgroundColor = .clear
        
        self.backgroundImage.backgroundColor = .clear
        
        //Fetch Data
        DispatchQueue.global(qos: .background).async {
            
            WeatherDataStore.sharedDataStore.fetchweatherData(lat: self.lat, long: self.long) { (errorDescription) in
                
                self.weatherObjectsArray.append(contentsOf: WeatherDataStore.sharedDataStore.weatherArray)
                self.weeklyWeatherObjectsArray.append(contentsOf: WeatherDataStore.sharedDataStore.WeeklyWeatherArray)
                
                //today's weather information
                for weatherObject in self.weatherObjectsArray {
                    //setting view cards
                    let todaysWeather = self.todayWeatherView
                    todaysWeather?.currentWeather = weatherObject
                    //setting bottom view
                    let bottomViewTodaysWeather = self.todayBottomView
                    bottomViewTodaysWeather?.currentWeather = weatherObject
                    
                // this should be done in main thread vvv
                 self.setbackgroundImage(icon: (todaysWeather?.currentWeather.icon)!)
                }
                // check on first object in array later
                self.weeklyWeatherObjectsArray.remove(at: 0)
                
                // Setting
                for (dayView, dayObject) in zip(self.weatherViews, self.weeklyWeatherObjectsArray) {
                    
                    let todaysView = dayView
                    todaysView.currentWeeklyWeather = dayObject
                }
                
                for (bottomDayView, dayObject) in zip(self.bottomWeatherViews, self.weeklyWeatherObjectsArray) {
         
                    let dailyBottomView = bottomDayView
                    dailyBottomView.currentWeeklyWeather = dayObject
    
                }
            }
        }
        
    }
    // This function will set the background image to match Weather
    func setbackgroundImage(icon: String) {
        
        switch icon {
        case "clear-day":
            self.backgroundImage.image = UIImage(named: "clearSkyBackground.jpg")
        case "clear-night":
            self.backgroundImage.image = UIImage(named: "clearNightSkyBackground.jpg")
        case "rain":
            self.backgroundImage.image = UIImage(named: "rainBackground.jpg")
        case "snow":
            self.backgroundImage.image = UIImage(named: "snowBackground.jpg")
        case "sleet":
            self.backgroundImage.image = UIImage(named: "sleetBackground.jpg")
        case "wind":
            self.backgroundImage.image = UIImage(named: "windyBackground.jpg")
        case "fog":
            self.backgroundImage.image = UIImage(named: "fogBackground.jpg")
        case "cloudy":
            self.backgroundImage.image = UIImage(named: "cloudBackground.jog")
        case "partly-cloudy-day":
            self.backgroundImage.image = UIImage(named: "Sunny-SkyBackground.jpg")
        case "partly-cloudy-night":
            self.backgroundImage.image = UIImage(named: "cloudyNightBackground.jpg")
        default:
            print("There is a missing case")
        }
    }
   
        
}


