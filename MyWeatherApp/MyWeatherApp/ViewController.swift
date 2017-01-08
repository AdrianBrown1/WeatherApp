//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Adrian Brown  on 8/24/16.
//  Copyright © 2016 Adrian Brown . All rights reserved.
//

import UIKit
import CoreLocation

extension UIScrollView {
    var currentPage: Int {
        return Int((self.contentOffset.x+(0.5*self.frame.size.width))/self.frame.width)+1
    }
}

class ViewController: UIViewController, CLLocationManagerDelegate, UIScrollViewDelegate {
    
    var locationManager: CLLocationManager!
    var lat: String = ""
    var long: String = ""
    var weatherObjectsArray: [Weather] = []
    var weeklyWeatherObjectsArray: [WeeklyWeather] = []
    var weatherViews : [WeatherView] = []
    
    
    //WeatherViews
    @IBOutlet weak var todayWeatherView: WeatherView!
    @IBOutlet weak var dayOneView: WeatherView!
    @IBOutlet weak var dayTwoView: WeatherView!
    @IBOutlet weak var dayThreeView: WeatherView!
    @IBOutlet weak var dayFourVew: WeatherView!
    @IBOutlet weak var dayFiveView: WeatherView!
    @IBOutlet weak var daySixView: WeatherView!
    @IBOutlet weak var daySevenView: WeatherView!
    
    //BottomWeatherViews
    @IBOutlet weak var todayBottomView: BottomWeatherView!
    @IBOutlet weak var dayOneBottomView: BottomWeatherView!
    @IBOutlet weak var dayTwoBottomView: BottomWeatherView!
    @IBOutlet weak var dayThreeBottomView: BottomWeatherView!
    @IBOutlet weak var dayFourBottomView: BottomWeatherView!
    @IBOutlet weak var dayFiveBottomView: BottomWeatherView!
    @IBOutlet weak var daySixBottomView: BottomWeatherView!
    @IBOutlet weak var daySevenBottomVew: BottomWeatherView!
    var bottomWeatherViews: [BottomWeatherView] = []
    
    //background Image
    @IBOutlet weak var backgroundImage: UIImageView!
    // Weather ScrollView Cards
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // coreLoaction Setup
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        
        _ = locationManager.location
        
        //scrollView setup
        scrollView.delegate = self
        
        //View Cards
        self.todayWeatherView.layer.cornerRadius = 10
        self.todayWeatherView.layer.masksToBounds = true
        self.todayWeatherView.layer.borderColor = UIColor.gray.cgColor
        self.todayWeatherView.layer.borderWidth = 0
        self.todayWeatherView.layer.contentsScale = UIScreen.main.scale
        self.todayWeatherView.layer.shadowColor = UIColor.black.cgColor
        self.todayWeatherView.layer.shadowOffset = CGSize.zero
        self.todayWeatherView.layer.shadowRadius = 5.0
        self.todayWeatherView.layer.shadowOpacity = 0.5
        self.todayWeatherView.layer.masksToBounds = false
        self.todayWeatherView.clipsToBounds = false
        self.todayWeatherView.backgroundColor = .clear
        
        // Add view cards to Array of Views
        self.weatherViews.append(self.dayOneView)
        self.weatherViews.append(self.dayTwoView)
        self.weatherViews.append(self.dayThreeView)
        self.weatherViews.append(self.dayFourVew)
        self.weatherViews.append(self.dayFiveView)
        self.weatherViews.append(self.daySixView)
        self.weatherViews.append(self.daySevenView)
        
        for view in self.weatherViews {
            
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            view.layer.borderColor = UIColor.gray.cgColor
            view.layer.borderWidth = 0
            view.layer.contentsScale = UIScreen.main.scale
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize.zero
            view.layer.shadowRadius = 5.0
            view.layer.shadowOpacity = 0.5
            view.layer.masksToBounds = false
            view.clipsToBounds = false
            view.backgroundColor = .clear
        }
        
        // Bottom view added to array
        self.bottomWeatherViews.append(self.dayOneBottomView)
        self.bottomWeatherViews.append(self.dayTwoBottomView)
        self.bottomWeatherViews.append(self.dayThreeBottomView)
        self.bottomWeatherViews.append(self.dayFourBottomView)
        self.bottomWeatherViews.append(self.dayFiveBottomView)
        self.bottomWeatherViews.append(self.daySixBottomView)
        self.bottomWeatherViews.append(self.daySevenBottomVew)
        
        //bottom view design change
        for view in self.bottomWeatherViews {
            
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            view.layer.borderColor = UIColor.gray.cgColor
            view.layer.borderWidth = 0
            view.layer.contentsScale = UIScreen.main.scale
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize.zero
            view.layer.shadowRadius = 5.0
            view.layer.shadowOpacity = 0.5
            view.layer.masksToBounds = false
            view.clipsToBounds = false
            view.backgroundColor = .clear
            
        }
        
        self.todayBottomView.layer.cornerRadius = 10
        self.todayBottomView.layer.masksToBounds = true
        self.todayBottomView.layer.borderColor = UIColor.gray.cgColor
        self.todayBottomView.layer.borderWidth = 0
        self.todayBottomView.layer.contentsScale = UIScreen.main.scale
        self.todayBottomView.layer.shadowColor = UIColor.black.cgColor
        self.todayBottomView.layer.shadowOffset = CGSize.zero
        self.todayBottomView.layer.shadowRadius = 5.0
        self.todayBottomView.layer.shadowOpacity = 0.5
        self.todayBottomView.layer.masksToBounds = false
        self.todayBottomView.clipsToBounds = false
        self.todayBottomView.backgroundColor = .clear
        
        self.backgroundImage.backgroundColor = .clear
        
        // animate bottom view
        self.todayBottomView.backgroundColor = .white
        self.todayBottomView.layer.shadowOpacity = 2
        
        // Notification for data refresh
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(AppDelegate.applicationDidBecomeActive(_:)),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        print(self.scrollView.contentOffset.x)
        
    }
    
    // Gesture swipe
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
                
                // grab content offset X & add it to current content offset to move over by one.
                
                let contentSizeWidth: Double = Double(self.scrollView.contentSize.width)
                
                let weatherObjects: Double = Double(self.weeklyWeatherObjectsArray.count + 1)
                
                let contentOffSetDouble: Double = Double( contentSizeWidth / weatherObjects)
                
                let currentContentOffset: Double = Double(self.scrollView.contentOffset.x)
        
                
                print("the current content offset is \(currentContentOffset)")
                

                let contentToChange: Double = currentContentOffset - contentOffSetDouble
                
                
                let contentOffSet: CGPoint = CGPoint(x: contentToChange, y: 0)
                print("the content offset is \(contentOffSet)")
                
                self.scrollView.setContentOffset(contentOffSet, animated: true)
                
                
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                
                
                
                let contentSizeWidth: Double = Double(self.scrollView.contentSize.width)
                
                let weatherObjects: Double = Double(self.weeklyWeatherObjectsArray.count + 1)
                
                let contentOffSetDouble: Double = Double( contentSizeWidth / weatherObjects)
                
                let currentContentOffset: Double = Double(self.scrollView.contentOffset.x)
                
                print(contentSizeWidth)
                
                print("the current content offset is \(currentContentOffset)")
                
                if currentContentOffset == 0.0 {
                    
                                        let contentToChange: Double = currentContentOffset + contentOffSetDouble
                    
                    
                    let contentOffSet: CGPoint = CGPoint(x: contentToChange, y: 0)
                    print("the content offset is \(contentOffSet)")
                    
                    self.scrollView.setContentOffset(contentOffSet, animated: true)

                }
                
                
                
               
                
//                self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
//                var contentOffSetAsDouble: Double? = nil
//                var contentOffSet: CGPoint? = nil
//                
//                contentOffSetAsDouble = Double(self.scrollView.contentOffset.x + 415)
//                print(contentOffSetAsDouble!)
//                
//                contentOffSet = CGPoint(x: contentOffSetAsDouble!, y: 0)
//                self.scrollView.setContentOffset(contentOffSet!, animated: true)
            default:
                break
            }
        }
    }
    
    // coreLocation stuff
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    
                    let location = locationManager.location
                    
                    if  let long = location?.coordinate.longitude {
                        let strlong = String(format: "%.4f",long)
                        self.long = strlong
                    }
                    if let lat = location?.coordinate.latitude {
                        let strlat = String(format: "%.4f", lat)
                        self.lat = strlat
                    }
                    
                    fetchData()
                }
            }
        }
    }
    
    
    func applicationDidBecomeActive(_ notification: NSNotification) {
        
        fetchData()
        scrollToBeginning()
        
    }
    
    // This function will set the background image to match Weather
    func setbackgroundImage(icon: String) {
        
        switch icon {
        case "clear-day":
            self.backgroundImage.image = UIImage(named: "clearSkyBackground.jpg")
        case "clear-night":
            self.backgroundImage.image = UIImage(named: "clearNightSkyBackground.jpg")
        case "rain":
            self.backgroundImage.image = UIImage(named: "rainBackground.jpg")
        case "snow":
            self.backgroundImage.image = UIImage(named: "snowBackground.jpg")
        case "sleet":
            self.backgroundImage.image = UIImage(named: "sleetBackground.jpg")
        case "wind":
            self.backgroundImage.image = UIImage(named: "windyBackground.jpg")
        case "fog":
            self.backgroundImage.image = UIImage(named: "fogBackground.jpg")
        case "cloudy":
            self.backgroundImage.image = UIImage(named: "cloudBackground.jpg")
        case "partly-cloudy-day":
            self.backgroundImage.image = UIImage(named: "Sunny-SkyBackground.jpg")
        case "partly-cloudy-night":
            self.backgroundImage.image = UIImage(named: "cloudyNightBackground.jpg")
        default:
            print("There is a missing case")
        }
    }
    
    func fetchData() {
        
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
        WeatherDataStore.sharedDataStore.fetchweatherData(lat: self.lat, long: self.long) { (success, error) in
            
            if success {
                
                self.weatherObjectsArray.removeAll()
                self.weeklyWeatherObjectsArray.removeAll()
                self.weatherObjectsArray.append(contentsOf: WeatherDataStore.sharedDataStore.weatherArray)
                self.weeklyWeatherObjectsArray.append(contentsOf: WeatherDataStore.sharedDataStore.WeeklyWeatherArray)
                
                //today's weather information
                for weatherObject in self.weatherObjectsArray {
                    //setting view cards
                    let todaysWeather = self.todayWeatherView
                    todaysWeather?.currentWeather = weatherObject
                    //setting bottom view
                    let bottomViewTodaysWeather = self.todayBottomView
                    bottomViewTodaysWeather?.currentWeather = weatherObject
                    
                    DispatchQueue.main.async {
                        self.setbackgroundImage(icon: (todaysWeather?.currentWeather.icon)!)
                        
                    }
                }
                
                // check on first object in array later
                self.weeklyWeatherObjectsArray.remove(at: 0)
                // Setting
                for (dayView, dayObject) in zip(self.weatherViews, self.weeklyWeatherObjectsArray) {
                    let todaysView = dayView
                    todaysView.currentWeeklyWeather = dayObject
                }
                for (bottomDayView, dayObject) in zip(self.bottomWeatherViews, self.weeklyWeatherObjectsArray) {
                    let dailyBottomView = bottomDayView
                    dailyBottomView.currentWeeklyWeather = dayObject
                }
            } else {
                
                // show labels saying internet is down !
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Load"), object: nil)
            }
        }
    }
    
    func scrollToBeginning() {
        
        var arrayOfViews: [UIView] = []
        arrayOfViews.append(self.todayBottomView)
        arrayOfViews.append(self.dayOneBottomView)
        arrayOfViews.append(self.dayTwoBottomView)
        arrayOfViews.append(self.dayThreeBottomView)
        arrayOfViews.append(self.dayFourBottomView)
        arrayOfViews.append(self.dayFiveBottomView)
        arrayOfViews.append(self.daySixBottomView)
        arrayOfViews.append(self.daySevenBottomVew)
        
        for view in arrayOfViews {
            view.backgroundColor = .clear
            view.layer.shadowOpacity = 0.5
        }
        UIView.animate(withDuration: 0.1, animations: {
            self.todayBottomView.backgroundColor = .white
            self.todayBottomView.layer.shadowOpacity = 1
        })
        
    }
    
    // Bottom view highlighting based on scroll
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        var arrayOfViews: [UIView] = []
        arrayOfViews.append(self.todayBottomView)
        arrayOfViews.append(self.dayOneBottomView)
        arrayOfViews.append(self.dayTwoBottomView)
        arrayOfViews.append(self.dayThreeBottomView)
        arrayOfViews.append(self.dayFourBottomView)
        arrayOfViews.append(self.dayFiveBottomView)
        arrayOfViews.append(self.daySixBottomView)
        arrayOfViews.append(self.daySevenBottomVew)
        
        for view in arrayOfViews {
            view.backgroundColor = .clear
            view.layer.shadowOpacity = 0.5
        }
        
        switch scrollView.currentPage {
        case 1:
            UIView.animate(withDuration: 0.2, animations: {
                self.todayBottomView.backgroundColor = .white
                self.todayBottomView.layer.shadowOpacity = 1
            })
        case 2:
            UIView.animate(withDuration: 0.2, animations: {
                for view in arrayOfViews {
                    view.backgroundColor = .clear
                }
                self.dayOneBottomView.backgroundColor = .white
                self.dayOneBottomView.layer.shadowOpacity = 1
            })
        case 3:
            UIView.animate(withDuration: 0.2, animations: {
                for view in arrayOfViews {
                    view.backgroundColor = .clear
                }
                self.dayTwoBottomView.backgroundColor = .white
                self.dayTwoBottomView.layer.shadowOpacity = 1
            })
            
        case 4:
            UIView.animate(withDuration: 0.2, animations: {
                for view in arrayOfViews {
                    view.backgroundColor = .clear
                }
                self.dayThreeBottomView.backgroundColor = .white
                self.dayThreeBottomView.layer.shadowOpacity = 1
            })
        case 5:
            UIView.animate(withDuration: 0.2, animations: {
                for view in arrayOfViews {
                    view.backgroundColor = .clear
                }
                self.dayFourBottomView.backgroundColor = .white
                self.dayFourBottomView.layer.shadowOpacity = 1
            })
        case 6:
            UIView.animate(withDuration: 0.2, animations: {
                for view in arrayOfViews {
                    view.backgroundColor = .clear
                }
                self.dayFiveBottomView.backgroundColor = .white
                self.dayFiveBottomView.layer.shadowOpacity = 1
            })
        case 7:
            UIView.animate(withDuration: 0.2, animations: {
                for view in arrayOfViews {
                    view.backgroundColor = .clear
                }
                self.daySixBottomView.backgroundColor = .white
                self.daySixBottomView.layer.shadowOpacity = 1
            })
        case 8:
            UIView.animate(withDuration: 0.2, animations: {
                for view in arrayOfViews {
                    view.backgroundColor = .clear
                }
                self.daySevenBottomVew.backgroundColor = .white
                self.daySevenBottomVew.layer.shadowOpacity = 1
            })
        default:
            print("I am the default case")
        }
    }
    
}


