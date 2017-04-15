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
                    let weathers = self?.viewModel.weathers,
                    error == nil
                else {
                    // TODO: Error alert or whatever.
                    // Can be empty or error.
                    UIAlertController.showSimpleAlert(title: "Error", message: error?.localizedDescription, from: self)
                    return
                }
                self?.fillPageViewController(weathers: weathers)
            }
        }
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.retrieveData()
    }


    // MARK: - UI Actions
    @IBAction func tapRetrieve(_ sender: UIButton) {
        viewModel.retrieveData()
    }

    @IBAction func tapReload(_ sender: UIButton) {
        viewModel.retrieveData(shouldLoad: true)
    }

    // MARK: - Private methods
    private func fillPageViewController(weathers: [Weather]) {
        pageViewController.weathers = weathers
    }
}
