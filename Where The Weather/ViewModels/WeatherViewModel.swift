//
//  WeatherViewModel.swift
//  Where The Weather
//
//  Created by Alex Agapov on 15/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import RealmSwift
import Alamofire
import AlamofireObjectMapper

class WeatherViewModel {
    // MARK: - Data
    var places: [Place] = []

    // MARK: - Closures
    var startLoading: (() -> Void) = {}
    var finishLoading: ((Error?) -> Void) = { _ in }

    // MARK: - Public methods
    func retrieveData(city: City? = nil, shouldLoad: Bool = false) {
        // TODO: Retrieve from Realm, load if needed
        startLoading()
        if let city = city,
            shouldLoad {
            loadData(city: city)
        } else {
            DispatchQueue.main.async { [weak self] in
                let realm = RealmManager.defaultRealm
                self?.places = Array(realm.objects(Place.self))
                self?.finishLoading(nil)
            }
        }
    }

    // MARK: - Private methods
    private func loadData(city: City) {
        Alamofire.request(WeatherRouter.daily(city))
            .validate()
            .responseObject { [weak self] (response: DataResponse<Place>) in
                DispatchQueue.main.async {
                    switch response.result {
                    case .failure(let error):
                        self?.finishLoading(error)
                    case .success(let object):
                        do {
                            try self?.saveToRealm([object])
                        } catch {
                            self?.finishLoading(error)
                            return
                        }
                        self?.retrieveData()
                    }
                }
            }
    }

    private func saveToRealm(_ objects:[Place]) throws {
        let realm = RealmManager.defaultRealm
        try realm.write {
            realm.add(objects, update: true)
        }
    }
}
