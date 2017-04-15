//
//  WeatherViewController.swift
//  Where The Weather
//
//  Created by Alex Agapov on 13/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - UI outlets
    var pageViewController: PlacePageViewController {
        return childViewControllers.first as! PlacePageViewController
    }

    // MARK: - Properties
    var viewModel: WeatherViewModel! {
        didSet {
            viewModel.startLoading = {
                // TODO: Activity indicator, or whatever
            }
            viewModel.finishLoading = { [weak self] error in
                guard
                    let places = self?.viewModel.places,
                    error == nil
                else {
                    UIAlertController.showSimpleAlert(title: "Error", message: error?.localizedDescription, from: self)
                    return
                }
                self?.fillPageViewController(places: places)
            }
        }
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.retrieveData(city: UserDefaults.searchedCity)
    }

    // MARK: - UI Actions
    @IBAction func tapCity(_ sender: UIButton) {
        let currentCity = UserDefaults.searchedCity
        let nextCity = currentCity.next
        UserDefaults.set(searchedCity: nextCity)
        sender.setTitle(nextCity.name, for: .normal)
    }

    @IBAction func tapRetrieve(_ sender: UIButton) {
        viewModel.retrieveData(city: UserDefaults.searchedCity)
    }

    @IBAction func tapReload(_ sender: UIButton) {
        viewModel.retrieveData(city: UserDefaults.searchedCity, shouldLoad: true)
    }

    // MARK: - Private methods
    private func fillPageViewController(places: [Place]) {
        pageViewController.places = places
    }
}
