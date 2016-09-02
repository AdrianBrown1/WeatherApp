//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Adrian Brown  on 8/24/16.
//  Copyright © 2016 Adrian Brown . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        WeatherDataStore.sharedDataStore.fetchWeatherData { (errorDescription) in
            
            print("back in the VC")
            print(WeatherDataStore.sharedDataStore.weatherArray.count)
            print(WeatherDataStore.sharedDataStore.WeeklyWeatherArray.count)
            
            
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
