//
//  NumberFormatters.swift
//  Where The Weather
//
//  Created by Alex Agapov on 15/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import Foundation

extension NumberFormatter {
    class var degreeFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.allowsFloats = false
        return formatter
    }
}
