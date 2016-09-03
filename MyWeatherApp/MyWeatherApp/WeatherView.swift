//
//  WeatherView.swift
//  MyWeatherApp
//
//  Created by Adrian Brown  on 9/3/16.
//  Copyright © 2016 Adrian Brown . All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    
    private func commonInit() {
        
        NSBundle.mainBundle().loadNibNamed("WeatherView", owner: self, options: [:])
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        contentView.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        contentView.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
        contentView.rightAnchor.constraintEqualToAnchor(rightAnchor).active = true

    }
    

}
