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
    @IBOutlet private var actInd: UIActivityIndicatorView!

    var place: PlaceWeather? {
        didSet {
            guard let place = place else { return }
            degreesLabel?.text = "\(place.temperature)"
            weatherDescriptionLabel?.text = place.description
            actInd?.stopAnimating()
        }
    }
}
