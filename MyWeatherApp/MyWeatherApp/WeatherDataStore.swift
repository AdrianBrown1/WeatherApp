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
    static let basicURL = "https://api.forecast.io/forecast/21161b1db326da35c6d6a5b09cc36782/"
    var weatherArray: [Weather] = []
    var WeeklyWeatherArray: [WeeklyWeather] = []
    
    
    func fetchweatherData(lat: String, long: String, completion:@escaping (Bool, String)-> ()){
        
        let newURL = "\(WeatherDataStore.basicURL)\(lat),\(long)"
        
        Alamofire.request(newURL).responseJSON { [unowned self] response in
                
                DispatchQueue.main.async {

                    guard let rawJSON = response.result.value else { completion(false, "No value from response."); return }
                    let json = JSON(rawJSON)
                    
                    // This Weather object is Today's Weather
                    let todaysWeather = Weather.init(json: json)
                    
                    if self.weatherArray.count < 1 {
                        self.weatherArray.append(todaysWeather)
                    }else {
                        print(" I cant add more to this array")
                    }
                    // This is the WeeklyWeather objects
                    let thisWeeksWeather = json["daily"]["data"]
                    var oneDayOfTheWeek: WeeklyWeather
                    
                    for (_, value) in thisWeeksWeather {
                        oneDayOfTheWeek = WeeklyWeather.init(json: value)
                        if self.WeeklyWeatherArray.count < 8 {
                            self.WeeklyWeatherArray.append(oneDayOfTheWeek)
                        }else {
                            print(" I cant add more to this array either")
                        }
                    }
                    
                    completion(true, "n/a")
                }
        }
        
    }
    
}
