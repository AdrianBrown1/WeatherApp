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
    
    var date: Int
    var temperature: Double
    var humidity: String
    var summary: String
    
    init(json: JSON) {
        self.date = json["currently"]["time"].intValue
        self.temperature = json["currently"]["tempature"].doubleValue
        self.humidity = json["currently"]["humidity"].stringValue
        self.summary = json["currently"]["summary"].stringValue
        
    }
}