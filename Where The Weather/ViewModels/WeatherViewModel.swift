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
        // TODO: Retrieve from Realm, load if needed
        startLoading()
        if shouldLoad {
            loadData()
        } else {
            DispatchQueue.main.async { [weak self] in
                let realm = RealmManager.defaultRealm
                self?.weathers = Array(realm.objects(Weather.self))
                self?.finishLoading(nil)
            }
        }
    }

    // MARK: - Private methods
    private func loadData(completion: (() -> Void)? = nil) {
        Alamofire.request(Router.weathers(forCities: [.london, .manchester, .liverpool]))
            .validate()
            .responseArray(keyPath: "list") { [weak self] (response: DataResponse<[Weather]>) in
                DispatchQueue.main.async {
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
                }
            }
    }

    private func saveToRealm(_ objects:[Weather]) throws {
        let realm = RealmManager.defaultRealm
        try realm.write {
            objects.forEach({ realm.add($0, update: true) })
        }
    }
}
