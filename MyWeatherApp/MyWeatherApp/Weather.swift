//
//  Weather.swift
//  MyWeatherApp
//
//  Created by Adrian Brown  on 8/24/16.
//  Copyright © 2016 Adrian Brown . All rights reserved.
//

import Foundation
import SwiftyJSON.Swift


class Weather {
    
//    enum Day {
//        case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
//
//    }
    
//    let day: Day
    var date: Int
    var temperature: Double
    var humidity: String
    var summary: String
    var icon: String
   // var maxTemp: String
    //var minTemp: String
    
    init(date: Int, temperature: Double, humidity: String, summary: String,icon: String) {
        
        self.date = date
        self.temperature = temperature
        self.humidity = humidity
        self.summary = summary
        self.icon = icon 
    }

    
    init(json: JSON) {
       
        self.date = json["currently"]["time"].intValue
        self.temperature = json["currently"]["temperature"].doubleValue
        self.humidity = json["currently"]["humidity"].stringValue
        self.summary = json["currently"]["summary"].stringValue
        self.icon = json["daily"]["data"]["icon"].stringValue
    }

}

class WeeklyWeather  {
    
    var date: Int
    var temperature: Double
    var humidity: String
    var summary: String
    var icon: String
    var maxTemp: Double
    var minTemp: Double
    
    init(json: JSON) {
        
        self.date = json["time"].intValue
        self.temperature = json["tempature"].doubleValue
        self.humidity = json["humidity"].stringValue
        self.summary = json["summary"].stringValue
        self.icon = json["icon"].stringValue
        self.maxTemp = json["temperatureMax"].doubleValue
        self.minTemp = json["temperatureMin"].doubleValue
        
        
    }
}
