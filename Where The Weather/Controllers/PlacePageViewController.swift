//
//  PlacePageViewController.swift
//  Where The Weather
//
//  Created by Alex Agapov on 13/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit

class PlacePageViewController: UIPageViewController {

    var pages: [UIViewController] = [] {
        didSet {
            guard let page = pages.first else { return }
            setViewControllers([page], direction: .forward, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        dataSource = self
    }

    private func setup() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: PlaceContentViewController.self)) as! PlaceContentViewController

        setViewControllers([controller], direction: .forward, animated: false, completion: nil)
    }
}

extension PlacePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.index(of: viewController) else {
            return nil
        }

        if index == 0 {
            return pages.last
        }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.index(of: viewController) else {
            return nil
        }

        if pages.count == index + 1 {
            return pages.first
        }
        return pages[index + 1]
    }
}
