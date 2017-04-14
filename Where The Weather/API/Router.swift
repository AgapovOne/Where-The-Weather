//
//  Router.swift
//  Where The Weather
//
//  Created by Alex Agapov on 14/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    case weather(forCity: City)

    static let baseURLString = "http://api.openweathermap.org"

    var method: HTTPMethod {
        switch self {
        case .weather:
            return .get
        }
    }

    var path: String {
        switch self {
        case .weather:
            return "/data/2.5/weather"
        }
    }

    // MARK: URLRequestConvertible

    var defaultParameters: Parameters {
        return ["APPID": "f345ee0a1fcb86366808c502a181879e",
                "units": "metric"]
    }

    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest = try! URLEncoding.default.encode(urlRequest, with: defaultParameters)

        switch self {
        case .weather(forCity: let city):
            urlRequest = try! URLEncoding.default.encode(urlRequest, with: ["q": city.name])
        }

        return urlRequest
    }
}
