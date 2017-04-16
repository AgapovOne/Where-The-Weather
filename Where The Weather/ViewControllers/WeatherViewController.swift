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
    @IBOutlet fileprivate var collectionView: UICollectionView!
    @IBOutlet fileprivate var pageControl: UIPageControl!

    @IBOutlet fileprivate var cityButton: UIButton!

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
                self?.collectionView.reloadData()
                self?.pageControl.numberOfPages = places.count
            }
        }
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = nil

        let nib = UINib(nibName: PlaceWeatherCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PlaceWeatherCollectionViewCell.identifier)

        collectionView.dataSource = self
        collectionView.delegate = self

        let searchedCity = UserDefaults.searchedCity
        cityButton.setTitle(searchedCity.name, for: .normal)

        viewModel.retrieveData(city: searchedCity)
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
}

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.places.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceWeatherCollectionViewCell.identifier, for: indexPath) as! PlaceWeatherCollectionViewCell
        cell.place = viewModel.places[indexPath.row]
        return cell
    }
}

extension WeatherViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        NSInteger currentIndex = (NSInteger)(self.collectionView.contentOffset.x / self.collectionView.frame.size.width + 0.5);
        pageControl.currentPage = Int(collectionView.contentOffset.x / collectionView.frame.size.width + 0.5)
    }
}
