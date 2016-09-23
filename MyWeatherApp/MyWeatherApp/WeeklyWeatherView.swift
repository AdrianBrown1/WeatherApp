//
//  WeeklyWeatherView.swift
//  MyWeatherApp
//
//  Created by Adrian Brown  on 9/22/16.
//  Copyright © 2016 Adrian Brown . All rights reserved.
//

import UIKit

class WeeklyWeatherView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
   // @IBOutlet var tableView: UITableView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        Bundle.main.loadNibNamed("WeeklyWeatherView", owner: self, options: [:])
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
    }

}
