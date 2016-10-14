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
        self.summaryLabel.text = "\(self.currentWeeklyWeather.summary)"
        
        // Date conversion
        let date = Date(timeIntervalSince1970: Double(self.currentWeeklyWeather.date))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEEE"
        let dateString = dayTimePeriodFormatter.string(from: date)
        self.dateLabel.text = dateString
        
        // Temp  & Humidity conversion
        let maxTemp = Int(round(self.currentWeeklyWeather.maxTemp))
        let minTemp = Int(round(self.currentWeeklyWeather.minTemp))
        self.tempatureLabel.text = String("Max:\(maxTemp) \n Min:\(minTemp)℉")
        let humidity = Double(self.currentWeeklyWeather.humidity)
        let humidityFormat = Int(round(humidity!))
        self.humidityLabel.text = String("Humidity: \(humidityFormat)%")
        
        setWeatherImage(icon: self.currentWeeklyWeather.icon)

    }
    
    func updateWeather() {
        print("I am updating the weather")
        self.summaryLabel.text = "\(self.currentWeather.summary)"
        
        // Date conversion
        let date = Date(timeIntervalSince1970: Double(self.currentWeather.date))
        let dayTimePeriodFormatter = DateFormatter()
//      dayTimePeriodFormatter.dateFormat = "MMM dd YYYY"
        dayTimePeriodFormatter.dateFormat = "EEEE"
        let dateString = dayTimePeriodFormatter.string(from: date)
        self.dateLabel.text = dateString
        
        // Temp  & Humidity conversion
        let tempFormat = Int(round(self.currentWeather.temperature))
        self.tempatureLabel.text = String("\(tempFormat)℉")
        let humidity = Double(self.currentWeather.humidity)
        let humidityFormat = Int(round(humidity!))
        self.humidityLabel.text = String("Humidity: \(humidityFormat)%")
        
        setWeatherImage(icon: self.currentWeather.icon)
        

    }
    // this function will set image
    func setWeatherImage(icon: String) {
        
        switch icon {
        case "clear-day":
            self.backgroundImage.image = UIImage(named: "sunnyApp.png")
        case "clear-night":
            self.backgroundImage.image = UIImage(named: "clearNightImage.png")
        case "rain":
            self.backgroundImage.image = UIImage(named: "rainImage.png")
        case "snow":
            self.backgroundImage.image = UIImage(named: "snowImage.png")
        case "sleet":
            self.backgroundImage.image = UIImage(named: "sleetImage.png")
        case "wind":
            self.backgroundImage.image = UIImage(named: "windImage.png")
        case "fog":
            self.backgroundImage.image = UIImage(named: "fogImage.png")
        case "cloudy":
            self.backgroundImage.image = UIImage(named: "cloudyImage.png")
        case "partly-cloudy-day":
            self.backgroundImage.image = UIImage(named: "cloudyDayImage.png")
        case "partly-cloudy-night":
            self.backgroundImage.image = UIImage(named: "cloudyNightImage.png")
        default:
            print("There is a missing case")
        }
    
    }


}

