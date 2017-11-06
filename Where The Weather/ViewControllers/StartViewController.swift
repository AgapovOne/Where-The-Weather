//
//  StartViewController.swift
//  Where The Weather
//
//  Created by Alex Agapov on 06/11/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBAction func didTapList(_ sender: UIButton) {
        let controller = StoryboardScene.Main.citiesListViewController.instantiate()
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func didTapPage(_ sender: UIButton) {
        let controller = StoryboardScene.Main.weatherViewController.instantiate()
        controller.viewModel = WeatherViewModel()
        
        navigationController?.pushViewController(controller, animated: true)
    }
}
