//
//  Router.swift
//  Where The Weather
//
//  Created by Alex Agapov on 14/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Alamofire

enum WeatherRouter: URLRequestConvertible {
    case
    daily(City)

    static let baseURLString = "http://api.openweathermap.org"

    var method: HTTPMethod {
        switch self {
        case .daily:
            return .get
        }
    }

    var path: String {
        switch self {
        case .daily:
            return "/data/2.5/forecast/daily"
        }
    }

    // MARK: URLRequestConvertible

    var defaultParameters: Parameters {
        return ["APPID": "f345ee0a1fcb86366808c502a181879e",
                "units": "metric"]
    }

    func asURLRequest() throws -> URLRequest {
        let url = try WeatherRouter.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest = try! URLEncoding.default.encode(urlRequest, with: defaultParameters)

        switch self {
        case .daily(let city):
            urlRequest = try! URLEncoding.default.encode(urlRequest, with: ["id": city.id])
        }

        return urlRequest
    }
}
