//
//  PlacePageViewController.swift
//  Where The Weather
//
//  Created by Alex Agapov on 13/04/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit
import ChameleonFramework

class PlacePageViewController: UIPageViewController {

    var weathers: [Weather] = []
    var pages: [UIViewController] = [] {
        didSet {
            guard let page = pages.first else { return }
            (page as! PlaceContentViewController).weather = weathers.first
            setViewControllers([page], direction: .forward, animated: true, completion: nil)
        }
    }
    var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [PlacePageViewController.self])
        pageControl.pageIndicatorTintColor = UIColor.flatSand.withAlphaComponent(0.5)
        pageControl.currentPageIndicatorTintColor = UIColor.flatSandDark

        setup()
        dataSource = self
    }

    private func setup() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: PlaceContentViewController.self)) as! PlaceContentViewController

        setViewControllers([controller], direction: .forward, animated: false, completion: nil)
    }

    fileprivate func contentController(at index: Int) -> PlaceContentViewController {
        let controller = pages[index] as! PlaceContentViewController
        controller.weather = weathers[index]
        return controller
    }
}

extension PlacePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.index(of: viewController) else {
            return nil
        }

        if index == 0 {
            currentPage = pages.count - 1
            return contentController(at: currentPage)
        }
        currentPage = index - 1
        return contentController(at: currentPage)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.index(of: viewController) else {
            return nil
        }

        if pages.count == index + 1 {
            currentPage = 0
            return contentController(at: currentPage)
        }
        currentPage = index + 1
        return contentController(at: currentPage)
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentPage
    }
}
