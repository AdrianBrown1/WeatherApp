//
//  WeatherView.swift
//  MyWeatherApp
//
//  Created by Adrian Brown  on 9/3/16.
//  Copyright © 2016 Adrian Brown . All rights reserved.
//

import UIKit


class WeatherView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var currentWeather: Weather! {
        didSet {
            updateWeather()
        }
    }
    
    var currentWeeklyWeather: WeeklyWeather! {
        didSet {
        updateWeeklyWeather()
        }
    }
    
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
        
        
    }
    
    
    func updateWeeklyWeather() {
        print("I am update the weekly Weather")
        print(self.currentWeeklyWeather.date)
//        print(self.currentWeeklyWeather.summary)
//        print(self.currentWeeklyWeather.maxTemp)
//        print(self.currentWeeklyWeather.minTemp)
        
        
        self.summaryLabel.text = "Weather: \(self.currentWeeklyWeather.summary)"
        
        // Date conversion
        let date = Date(timeIntervalSince1970: Double(self.currentWeeklyWeather.date))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY"
        let dateString = dayTimePeriodFormatter.string(from: date)
        self.dateLabel.text = dateString
        
        // Temp  & Humidity conversion
        let maxTemp = Int(round(self.currentWeeklyWeather.maxTemp))
        let minTemp = Int(round(self.currentWeeklyWeather.minTemp))
        self.tempatureLabel.text = String("Max:\(maxTemp)- Min:\(minTemp)℉")
        let humidity = Double(self.currentWeeklyWeather.humidity)
        let humidityFormat = Int(round(humidity!))
        self.humidityLabel.text = String("Humidity: \(humidityFormat)%")

    }
    
    func updateWeather() {
        print("I am updating the weather")
        print(self.currentWeather.date)
        print(self.currentWeather.summary)
        print(self.currentWeather.temperature)
        print(self.currentWeather.humidity)

        self.summaryLabel.text = "Weather: \(self.currentWeather.summary)"
        
        // Date conversion
        let date = Date(timeIntervalSince1970: Double(self.currentWeather.date))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY"
        let dateString = dayTimePeriodFormatter.string(from: date)
        self.dateLabel.text = dateString
        
        // Temp  & Humidity conversion
        let tempFormat = Int(round(self.currentWeather.temperature))
        self.tempatureLabel.text = String("\(tempFormat)℉")
        let humidity = Double(self.currentWeather.humidity)
        let humidityFormat = Int(round(humidity!))
        self.humidityLabel.text = String("Humidity: \(humidityFormat)%")
        
    }
    
}



//        DispatchQueue.global(qos: .background).async {
//
//            WeatherDataStore.sharedDataStore.fetchweatherData(lat: self.lat, long: self.long) { (errorDescription) in
//
//
//                self.todaysWeather.append(WeatherDataStore.sharedDataStore.weatherArray[0])
//
//                let todaysWeather: Weather = Weather.init(date: WeatherDataStore.sharedDataStore.weatherArray[0].date, temperature: WeatherDataStore.sharedDataStore.weatherArray[0].temperature, humidity: WeatherDataStore.sharedDataStore.weatherArray[0].humidity, summary: WeatherDataStore.sharedDataStore.weatherArray[0].summary, icon: WeatherDataStore.sharedDataStore.weatherArray[0].icon)
//
//                    DispatchQueue.main.async(execute: {
//
//                        print("back in the main thread")
//                        // Update labels
//                        self.summaryLabel.text = "Weather: \(todaysWeather.summary)"
//
//                        // Date conversion
//                        let date = Date(timeIntervalSince1970: Double(todaysWeather.date))
//                        let dayTimePeriodFormatter = DateFormatter()
//                        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY"
//                        let dateString = dayTimePeriodFormatter.string(from: date)
//                        self.dateLabel.text = dateString
//
//                        // Temp  & Humidity conversion
//                        let tempFormat = Int(round(todaysWeather.temperature))
//                        self.tempatureLabel.text = String("\(tempFormat)℉")
//                        let humidity = Double(todaysWeather.humidity)
//                        let humidityFormat = Int(round(humidity!))
//                        self.humidityLabel.text = String("Humidity: \(humidityFormat)%")
//
//                    })
//
//            }


//        }
