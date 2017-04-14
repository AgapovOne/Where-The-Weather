//
//  PlaceWeather.swift
//  Where The Weather
//
//  Created by Alex Agapov on 14/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Foundation
import Gloss

struct PlaceWeather {
    enum WeatherType {
        case
        cloudy,
        sunny,
        rain
    }

    let type: WeatherType
    let degrees: Int

    var description: String {
        switch type {
        case .cloudy:
            return "Cloudy here!"
        case .rain:
            return "Rainy-rainy-rain"
        case .sunny:
            return "Ohh, it's hot here. SUN!"
        }
    }
}

extension PlaceWeather: Decodable {
    init?(json: JSON) {
        self.degrees = ("weather.temp" <~~ json)!
        self.type = .sunny
    }

}
