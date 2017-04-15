//
//  DailyWeatherView.swift
//  Where The Weather
//
//  Created by Alex Agapov on 15/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit

class DailyWeatherView: UIView {

    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var degreesLabel: UILabel!

    class func instantiate(weather: DailyWeather? = nil) -> DailyWeatherView {
        let view = UINib(nibName: String(describing: DailyWeatherView.self), bundle: nil).instantiate(withOwner: nil, options: nil).first as! DailyWeatherView
        view.weather = weather
        return view
    }

    var weather: DailyWeather? {
        didSet {
            if let weather = weather {
                dayLabel.text = DateFormatter.dayFormatter.string(from: weather.date)
                descriptionLabel.text = "\(weather.weatherShort) (\(weather.weatherDescription))"
                degreesLabel.text = NumberFormatter.degreeFormatter.string(from: NSNumber(floatLiteral: weather.temperature))! + "°"
            }
        }
    }
}
