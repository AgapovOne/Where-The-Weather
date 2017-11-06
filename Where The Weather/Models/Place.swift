//
//  Place.swift
//  Where The Weather
//
//  Created by Alex Agapov on 14/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Place: Object, Mappable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    let forecast = List<DailyWeather>()

    override static func primaryKey() -> String? {
        return "id"
    }

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["city.id"]
        name <- map["city.name"]
        forecast <- map["list"]
    }
}

class DailyWeather: Object, Mappable {
    @objc dynamic var temperature: Double = 0.0
    @objc dynamic var minTemperature: Double = 0.0
    @objc dynamic var maxTemperature: Double = 0.0
    @objc dynamic var weatherShort: String = ""
    @objc dynamic var weatherDescription: String = ""
    @objc dynamic var date: Date = Date()

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        temperature <- map["temp.day"]
        minTemperature <- map["temp.min"]
        maxTemperature <- map["temp.max"]
        weatherShort <- map["weather.0.main"]
        weatherDescription <- map["weather.0.description"]
        date <- (map["dt"], DateTransform())
    }
}


// Mapping for Realm Lists
infix operator <-

/// For Realm's List type
public func <- <T: Mappable>(left: List<T>, right: Map) {
    var array: [T]?

    if right.mappingType == .toJSON {
        array = Array(left)
    }

    array <- right

    if right.mappingType == .fromJSON {
        if let theArray = array {
            left.append(objectsIn: theArray)
        }
    }
}

/*{
    "cod": "200",
    "message": 0,
    "city": {
        "geoname_id": 524901,
        "name": "Moscow",
        "lat": 55.7522,
        "lon": 37.6156,
        "country": "RU",
        "iso2": "RU",
        "type": "city",
        "population": 0
    },
    "cnt": 7,
    "list": [
    {
    "dt": 1485766800,
    "temp": {
    "day": 262.65,
    "min": 261.41,
    "max": 262.65,
    "night": 261.41,
    "eve": 262.65,
    "morn": 262.65
    },
    "pressure": 1024.53,
    "humidity": 76,
    "weather": [
    {
    "id": 800,
    "main": "Clear",
    "description": "sky is clear",
    "icon": "01d"
    }
    ],
    "speed": 4.57,
    "deg": 225,
    "clouds": 0,
    "snow": 0.01
    }
    ]
}*/
