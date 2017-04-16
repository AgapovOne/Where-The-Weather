//
//  PlaceWeatherCollectionViewCell.swift
//  Where The Weather
//
//  Created by Alex Agapov on 16/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit

class PlaceWeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var forecastStackView: UIStackView!

    @IBOutlet private var degreesLabel: UILabel!
    @IBOutlet private var weatherDescriptionLabel: UILabel!
    @IBOutlet private var cityLabel: UILabel!

    class var identifier: String {
        return String(describing: PlaceWeatherCollectionViewCell.self)
    }

    var place: Place? {
        didSet {
            guard let place = place else { return }
            degreesLabel.text = NumberFormatter.degreeFormatter.string(from: NSNumber(floatLiteral: place.forecast.first!.temperature))! + "°"
            weatherDescriptionLabel.text = place.forecast.first!.weatherShort
            cityLabel.text = place.name
            cityLabel.isHidden = false

            forecastStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
            place.forecast.forEach {
                let view = DailyWeatherView.instantiate(weather: $0)
                forecastStackView.addArrangedSubview(view)
            }

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
