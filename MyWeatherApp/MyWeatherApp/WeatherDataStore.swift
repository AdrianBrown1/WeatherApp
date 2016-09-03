//
//  WeatherDataStore.swift
//  MyWeatherApp
//
//  Created by Adrian Brown  on 8/24/16.
//  Copyright © 2016 Adrian Brown . All rights reserved.
//

import Foundation
import Alamofire.Swift
import SwiftyJSON.Swift


class WeatherDataStore {
    
    

    
    static let sharedDataStore = WeatherDataStore()
    var weatherArray: [Weather] = []
    var WeeklyWeatherArray: [WeeklyWeather] = []
    
    
    
    func fetchWeatherData(completion:(errorDescription: NSString?) -> ()) {
                
        Alamofire.request(.GET, "https://api.forecast.io/forecast/21161b1db326da35c6d6a5b09cc36782/37.8267,-122.423")
            .responseJSON { response in
                
                if let rawJSON = response.result.value {
                    
                    let json = JSON(rawJSON)
                    
                    // This Weather object is Today's Weather
                    let todaysWeather = Weather.init(json: json)
                    self.weatherArray.append(todaysWeather)

                    // This is the WeeklyWeather objects
                    let thisWeeksWeather = json["daily"]["data"]
                    var oneDayOfTheWeek: WeeklyWeather
                    
                    for (key, value) in thisWeeksWeather {
                        //print("\(key) ----- \(value)")
                      oneDayOfTheWeek = WeeklyWeather.init(json: value)
                      self.WeeklyWeatherArray.append(oneDayOfTheWeek)
                    }
                    completion(errorDescription: nil)
                }else {
                    print("Something went wrong!")
                    completion(errorDescription: "oh nooo")
                }
        }
    }
    
}