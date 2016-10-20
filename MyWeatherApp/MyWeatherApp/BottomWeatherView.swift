//
//  BottomWeatherView.swift
//  MyWeatherApp
//
//  Created by Adrian Brown  on 10/14/16.
//  Copyright © 2016 Adrian Brown . All rights reserved.
//

import UIKit

class BottomWeatherView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var todayTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var bottomWeatherImageView: UIImageView!
    
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
        Bundle.main.loadNibNamed("BottomWeatherView", owner: self, options: [:])
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.backgroundColor = .clear
        
    }
    
    func updateWeather() {
        // Date conversion
        let date = Date(timeIntervalSince1970: Double(self.currentWeather.date))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "E"
        let dateString = dayTimePeriodFormatter.string(from: date)
        self.dateLabel.text = dateString
        
        // Temp  & Humidity conversion
        let tempFormat = Int(round(self.currentWeather.temperature))
        self.todayTempLabel.text = String("\(tempFormat)℉")
       
        self.highTempLabel.isHidden = true
        setWeatherImage(icon: self.currentWeather.icon)
  
    }
    
    func updateWeeklyWeather() {
        
        // Date conversion
        let date = Date(timeIntervalSince1970: Double(self.currentWeeklyWeather.date))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "E"
        let dateString = dayTimePeriodFormatter.string(from: date)
        self.dateLabel.text = dateString
        
        // Temp  & Humidity conversion
        self.todayTempLabel.isHidden = true
        
        // Temp  & Humidity conversion
        let maxTemp = Int(round(self.currentWeeklyWeather.maxTemp))
        self.highTempLabel.text = String("\(maxTemp)℉")
        
        setWeatherImage(icon: self.currentWeeklyWeather.icon)
        
        
    }

    // this function will set image
    func setWeatherImage(icon: String) {
        
        switch icon {
        case "clear-day":
            self.bottomWeatherImageView.image = UIImage(named: "sunnyApp.png")
        case "clear-night":
            self.bottomWeatherImageView.image = UIImage(named: "clearNightImage.png")
        case "rain":
            self.bottomWeatherImageView.image = UIImage(named: "rainImage.png")
        case "snow":
            self.bottomWeatherImageView.image = UIImage(named: "snowImage.png")
        case "sleet":
            self.bottomWeatherImageView.image = UIImage(named: "sleetImage.png")
        case "wind":
            self.bottomWeatherImageView.image = UIImage(named: "windImage.png")
        case "fog":
            self.bottomWeatherImageView.image = UIImage(named: "fogImage.png")
        case "cloudy":
            self.bottomWeatherImageView.image = UIImage(named: "cloudyImage.png")
        case "partly-cloudy-day":
            self.bottomWeatherImageView.image = UIImage(named: "cloudyDayImage.png")
        case "partly-cloudy-night":
            self.bottomWeatherImageView.image = UIImage(named: "cloudyNightImage.png")
        default:
            print("There is a missing case")
        }
        
    }


}
