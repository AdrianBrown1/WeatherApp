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
 
    
    func commonInit() {
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: [:])
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
        
        // coreLoaction Setup 
        
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()

    }
    

    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        
        let userLocation: CLLocation = locationManager.location as CLLocation!
        let strlat = String(format: "%.4f", userLocation.coordinate.latitude)
        let strlong = String(format: "%.4f",userLocation.coordinate.longitude)
        
        self.lat = strlat
        self.long = strlong
        
        updateWeather()
        locationManager.stopUpdatingLocation()
        
        
    }
    func updateWeather() {
        print("I am updating the weather")
        
        DispatchQueue.global(qos: .background).async {
            print("I am the background thread")
            
            WeatherDataStore.sharedDataStore.fetchweatherData(lat: self.lat, long: self.long) { (errorDescription) in
                
                
                self.todaysWeather.append(WeatherDataStore.sharedDataStore.weatherArray[0])
                
                let todaysWeather: Weather = Weather.init(date: WeatherDataStore.sharedDataStore.weatherArray[0].date, temperature: WeatherDataStore.sharedDataStore.weatherArray[0].temperature, humidity: WeatherDataStore.sharedDataStore.weatherArray[0].humidity, summary: WeatherDataStore.sharedDataStore.weatherArray[0].summary, icon: WeatherDataStore.sharedDataStore.weatherArray[0].icon)
                
                    DispatchQueue.main.async(execute: {
                        
                        print("back in the main thread")
                        // Update labels
                        self.summaryLabel.text = "Weather: \(todaysWeather.summary)"
                        
                        // Date conversion
                        let date = Date(timeIntervalSince1970: Double(todaysWeather.date))
                        let dayTimePeriodFormatter = DateFormatter()
                        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY"
                        let dateString = dayTimePeriodFormatter.string(from: date)
                        self.dateLabel.text = dateString
                        
                        // Temp  & Humidity conversion
                        let tempFormat = Int(round(todaysWeather.temperature))
                        self.tempatureLabel.text = String("\(tempFormat)℉")
                        let humidity = Double(todaysWeather.humidity)
                        let humidityFormat = Int(round(humidity!))
                        self.humidityLabel.text = String("Humidity: \(humidityFormat)%")
                        
                    })

            }
            
            
        }
        
    

    }

}
