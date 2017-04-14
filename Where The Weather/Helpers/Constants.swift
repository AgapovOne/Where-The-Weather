//
//  Constants.swift
//  Where The Weather
//
//  Created by Alex Agapov on 14/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Foundation

enum City {
    case
    london,
    cardiff,
    liverpool,
    manchester

    var name: String {
        switch self {
        case .london:
            return "London"
        case .cardiff:
            return "Cardiff"
        case .liverpool:
            return "Liverpool"
        case .manchester:
            return "Manchester"
        }
    }

}
