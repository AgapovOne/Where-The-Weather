//
//  RealmManager.swift
//  Where The Weather
//
//  Created by Alex Agapov on 15/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import RealmSwift

class RealmManager {
    static let defaultRealm: Realm = {
        return try! Realm()
    }()
}
