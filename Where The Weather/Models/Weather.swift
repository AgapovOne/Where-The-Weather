//
//  Weather.swift
//  Where The Weather
//
//  Created by Alex Agapov on 14/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Weather: Object, Mappable {
    dynamic var id: Int = 0
    dynamic var temperature: Double = 0.0
    dynamic var name: String = ""
    dynamic var weatherDescription: String = ""
    dynamic var windSpeed: Double = 0.0
    dynamic var date: Date = Date()

    override static func primaryKey() -> String? {
        return "id"
    }

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        temperature <- map["main.temp"]
        name <- map["name"]
        weatherDescription <- map["weather.0.description"]
        windSpeed <- map["wind.speed"]
        date <- (map["dt"], DateTransform())
    }
}
/*SUCCESS: {
 base = stations;
 clouds =     {
 all = 92;
 };
 cod = 200;
 coord =     {
 lat = "51.51";
 lon = "-0.13";
 };
 dt = 1492192200;
 id = 2643743;
 main =     {
 humidity = 87;
 pressure = 1012;
 temp = "12.91";
 "temp_max" = 14;
 "temp_min" = 12;
 };
 name = London;
 sys =     {
 country = GB;
 id = 5187;
 message = "0.0069";
 sunrise = 1492146307;
 sunset = 1492196225;
 type = 1;
 };
 visibility = 10000;
 weather =     (
 {
 description = "overcast clouds";
 icon = 04d;
 id = 804;
 main = Clouds;
 }
 );
 wind =     {
 deg = 220;
 speed = "4.1";
 };
 }*/
