//
//  WeatherViewController.swift
//  Where The Weather
//
//  Created by Alex Agapov on 13/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController {

    @IBOutlet private var pageControl: UIPageControl!

    var pageViewController: PlacePageViewController {
        return childViewControllers.first as! PlacePageViewController
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) { [weak self] in
            Alamofire.request(Router.weather(forCity: City.london))
                .validate()
                .responseJSON(completionHandler: { (json) in
                    print(json)
                    self?.loadData()
            })
        }
    }

    func loadData() {
        // Load data
        var controllers: [UIViewController] = []
        for _ in 0..<3 {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: PlaceContentViewController.self)) as! PlaceContentViewController
            controllers.append(controller)
        }

        pageViewController.pages = controllers
        for (index, page) in pageViewController.pages.enumerated() {
            (page as? PlaceContentViewController)?.place = PlaceWeather(type: .cloudy, degrees: index * 50)
        }
        pageControl.numberOfPages = controllers.count
    }
}
