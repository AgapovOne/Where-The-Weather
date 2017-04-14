//
//  UserDefaults.swift
//  Where The Weather
//
//  Created by Alex Agapov on 14/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Foundation

extension UserDefaults {
    struct Keys {
        static let searchedCity = "searchedCity"
    }

    class var searchedCity: City {
        let userDefaults = UserDefaults.standard

        if userDefaults.object(forKey: UserDefaults.Keys.searchedCity) == nil {
            UserDefaults.set(searchedCity: City.london)
        }

        let cityString = userDefaults.string(forKey: UserDefaults.Keys.searchedCity)!
        return City(rawValue: cityString)!
    }

    class func set(searchedCity: City) {
        UserDefaults.standard.set(searchedCity.rawValue, forKey: UserDefaults.Keys.searchedCity)
    }
}
