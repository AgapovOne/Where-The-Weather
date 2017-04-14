//
//  PlaceContentViewController.swift
//  Where The Weather
//
//  Created by Alex Agapov on 14/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit

class PlaceContentViewController: UIViewController {

    @IBOutlet private var degreesLabel: UILabel!
    @IBOutlet private var weatherDescriptionLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!

    var weather: Weather? {
        didSet {
            guard let weather = weather else { return }
            degreesLabel?.text = "\(weather.temperature)"
            weatherDescriptionLabel?.text = weather.weatherDescription
            dateLabel?.text = DateFormatter.dayFormatter.string(from: weather.date)
        }
    }
}
