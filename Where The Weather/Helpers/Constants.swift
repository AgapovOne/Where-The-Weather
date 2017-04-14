//
//  Constants.swift
//  Where The Weather
//
//  Created by Alex Agapov on 14/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Foundation

enum City: String {
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

    // Sadly, but API has only several cities by ID :(
    var id: Int {
        switch self {
        case .london:
            return 5056033
        case .cardiff:
            return 2172349
        case .liverpool:
            return 7839747
        case .manchester:
            return 3489586
        }
    }

}
