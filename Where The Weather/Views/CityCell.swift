//
//  CityCell.swift
//  Where The Weather
//
//  Created by Alex Agapov on 06/11/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!
    
    var city: CityModel? {
        didSet {
            titleLabel?.text = city?.name
            temperatureLabel?.text = "\(city?.currentTemperature ?? 0)"
        }
    }
    
}

