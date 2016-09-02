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

    
    init(json: JSON) {
       
        self.date = json["currently"]["time"].intValue
        self.temperature = json["currently"]["tempature"].doubleValue
        self.humidity = json["currently"]["humidity"].stringValue
        self.summary = json["currently"]["summary"].stringValue
        self.icon = json["daily"]["data"]["icon"].stringValue
        //self.maxTemp = json["daily"]["data"]["temperatureMax"].stringValue
        //self.minTemp = json["daily"]["data"]["temperatureMin"].stringValue
        
//        self.day = day 
    }

}

class WeeklyWeather  {
    
    var date: Int
    var temperature: Double
    var humidity: String
    var summary: String
    var icon: String
    var maxTemp: String
    var minTemp: String
    
    init(json: JSON) {
        
        self.date = json["time"].intValue
        self.temperature = json["tempature"].doubleValue
        self.humidity = json["humidity"].stringValue
        self.summary = json["summary"].stringValue
        self.icon = json["icon"].stringValue
        self.maxTemp = json["temperatureMax"].stringValue
        self.minTemp = json["temperatureMin"].stringValue
        
        
    }
}