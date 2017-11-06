//
//  CitiesListViewController.swift
//  Where The Weather
//
//  Created by Alex Agapov on 06/11/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {
    
    // MARK: - UI Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var cities: [CityModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: CityCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: CityCell.self))
        
        cities = [
            CityModel(name: "Ekb", currentTemperature: 23.5)
        ]
        
        tableView.reloadData()
    }
}

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CityCell.self), for: indexPath) as! CityCell
        cell.city = cities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
