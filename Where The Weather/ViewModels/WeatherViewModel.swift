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
    var weathers: [Weather] = []

    // MARK: - Closures
    var startLoading: (() -> Void) = {}
    var finishLoading: ((Error?) -> Void) = { _ in }

    // MARK: - Public methods
    func retrieveData(shouldLoad: Bool = false) {
        startLoading()
        if shouldLoad {
            loadData()
        } else {
            do {
                let realm = try Realm()
                weathers = Array(realm.objects(Weather.self))
                finishLoading(nil)
            } catch {
                finishLoading(error)
            }
        }
    }

    // MARK: - Private methods
    private func loadData(completion: (() -> Void)? = nil) {
        // TODO: Retrieve from Realm, load if needed
        Alamofire.request(Router.weathers(forCities: [.london, .manchester, .liverpool]))
            .validate()
            .responseArray(keyPath: "list", completionHandler: { [weak self] (response: DataResponse<[Weather]>) in
                switch response.result {
                case .failure(let error):
                    self?.finishLoading(error)
                case .success(let objects):

                    do {
                        try self?.saveToRealm(objects)
                    } catch {
                        self?.finishLoading(error)
                        return
                    }

                    self?.weathers = objects
                    self?.finishLoading(nil)
                }
            })
    }

    private func saveToRealm(_ objects:[Weather]) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(objects, update: true)
        }
    }
}
