//
//  SevenDayWeather.swift
//  MyWeatherApp
//
//  Created by Adrian Brown  on 8/30/16.
//  Copyright © 2016 Adrian Brown . All rights reserved.
//

import Foundation
import SwiftyJSON

class SevenDayWeather {
    
    var week: [WeeklyWeather]
    
    
    init(week: [WeeklyWeather]) {
        self.week = week
    }
    
    
}