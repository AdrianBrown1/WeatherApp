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
    var weather: [Weather] = []
    
    
    func fetchWeatherData(completion:(errorDescription: NSString?) -> ()) {
        
        //let city = "newyork"
        
        Alamofire.request(.GET, "https://api.forecast.io/forecast/21161b1db326da35c6d6a5b09cc36782/37.8267,-122.423")
            .responseJSON { response in
                
                if let JSON = response.result.value {
                    
                    let json = JSON
                    print(json)
                    
//                    let sevenDays = json["daily"]!!["data"]!!
//                    print(sevenDays)
                    
                }else {
                    print("Something went wrong!")
                }
        }
    }
    
}