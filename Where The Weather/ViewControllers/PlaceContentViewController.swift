//
//  PlaceContentViewController.swift
//  Where The Weather
//
//  Created by Alex Agapov on 14/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit

class PlaceContentViewController: UIViewController {
    @IBOutlet private var foreCastStackView: UIStackView!

    @IBOutlet private var degreesLabel: UILabel!
    @IBOutlet private var weatherDescriptionLabel: UILabel!
    @IBOutlet private var cityLabel: UILabel!

    var place: Place? {
        didSet {
            guard let place = place else { return }
            degreesLabel?.text = NumberFormatter.degreeFormatter.string(from: NSNumber(floatLiteral: place.forecast.first!.temperature))! + "°"
            weatherDescriptionLabel?.text = place.forecast.first!.weatherShort
            cityLabel?.text = place.name
            cityLabel?.isHidden = false

            if foreCastStackView != nil {
                place.forecast.forEach {
                    let view = DailyWeatherView.instantiate(weather: $0)
                    foreCastStackView?.addArrangedSubview(view)
                }
            }
        }
    }
}
